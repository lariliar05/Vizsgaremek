<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

if (!isset($_SESSION['uid'])) { header("Location: ./?p=login"); exit; }
$uid=(int)$_SESSION['uid'];

// CSRF
if (empty($_SESSION['csrf'])) { $_SESSION['csrf']=bin2hex(random_bytes(16)); }
$csrf=$_SESSION['csrf'];

// műveletek
$errors=[]; $ok="";
if ($_SERVER['REQUEST_METHOD']==='POST' && isset($_POST['act'])) {
  if (!hash_equals($csrf, $_POST['csrf']??'')) { $errors[]="Érvénytelen űrlap (CSRF)."; }
  else {
    $bookId=(int)($_POST['book_id']??0);
    if ($bookId<=0) { $errors[]="Hiányzó azonosító."; }
    else {
      // ellenőrizd hogy a sajátod-e
      $r=mysqli_query($adb,"SELECT image_url FROM free_books WHERE id=$bookId AND owner_user_id=$uid");
      $row=$r?mysqli_fetch_assoc($r):null;
      if (!$row) $errors[]="Nincs jogosultság.";
      else {
        $oldImg=$row['image_url']??null;

        if ($_POST['act']==='status') {
          $st=$_POST['status']??'available';
          if (!in_array($st,['available','reserved','gone'],true)) $st='available';
          mysqli_query($adb,"UPDATE free_books SET status='".mysqli_real_escape_string($adb,$st)."' WHERE id=$bookId AND owner_user_id=$uid");
          if (mysqli_affected_rows($adb)>=0) $ok="Státusz frissítve.";

        } elseif ($_POST['act']==='delete') {
          if ($oldImg && file_exists(__DIR__.'/'.$oldImg)) @unlink(__DIR__.'/'.$oldImg);
          mysqli_query($adb,"DELETE FROM free_books WHERE id=$bookId AND owner_user_id=$uid");
          if (mysqli_affected_rows($adb)>0) $ok="Felajánlás törölve.";

        } elseif ($_POST['act']==='remove_image') {
          if ($oldImg && file_exists(__DIR__.'/'.$oldImg)) @unlink(__DIR__.'/'.$oldImg);
          mysqli_query($adb,"UPDATE free_books SET image_url=NULL WHERE id=$bookId AND owner_user_id=$uid");
          $ok="Kép törölve.";

        } elseif ($_POST['act']==='replace_image') {
          if (!empty($_FILES['image']['name'])) {
            if ($_FILES['image']['error']===UPLOAD_ERR_OK) {
              $allowed=['jpg','jpeg','png','webp','gif']; $ext=strtolower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
              if (in_array($ext,$allowed,true) && $_FILES['image']['size']<=3*1024*1024) {
                $dir=__DIR__."/uploads/free_books"; if (!is_dir($dir)) @mkdir($dir,0777,true);
                $fname=time().'_'.bin2hex(random_bytes(4)).'.'.$ext; $dest=$dir.'/'.$fname;
                if (move_uploaded_file($_FILES['image']['tmp_name'],$dest)) {
                  if ($oldImg && file_exists(__DIR__.'/'.$oldImg)) @unlink(__DIR__.'/'.$oldImg);
                  $rel='uploads/free_books/'.$fname;
                  $st=mysqli_prepare($adb,"UPDATE free_books SET image_url=? WHERE id=? AND owner_user_id=?");
                  mysqli_stmt_bind_param($st,"sii",$rel,$bookId,$uid);
                  mysqli_stmt_execute($st); mysqli_stmt_close($st);
                  $ok="Kép frissítve.";
                } else $errors[]="Nem sikerült a képet menteni.";
              } else $errors[]="Csak JPG/PNG/WEBP/GIF, max 3MB.";
            } else $errors[]="Képfeltöltési hiba.";
          } else $errors[]="Nem választottál képet.";
        }
      }
    }
  }
}

// saját könyvek
$books=[];
$res=mysqli_query($adb,"SELECT id,title,author,city,image_url,status,created_at FROM free_books WHERE owner_user_id=$uid ORDER BY created_at DESC");
while ($res && ($r=mysqli_fetch_assoc($res))) { $books[]=$r; }

// igénylés-számok
$counts=[]; 
if ($books) {
  $ids=implode(',',array_map('intval',array_column($books,'id')));
  $q=mysqli_query($adb,"SELECT book_id, COUNT(*) c FROM free_book_requests WHERE book_id IN ($ids) GROUP BY book_id");
  while ($q && ($row=mysqli_fetch_assoc($q))) { $counts[(int)$row['book_id']]=(int)$row['c']; }
}
?>
<div style="max-width:1100px;margin:0 auto;padding:20px;">
    <h1>Saját felajánlásaim</h1>
    <style>
    :root {
        --accent: #ff6b6b;
        --accent2: #e65959;
        --border: #eaeaea;
        --ring: rgba(255, 107, 107, .25);
    }

    body {
        color: #000;
    }

    .grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 14px;
    }

    .card {
        background: #fff;
        border: 1px solid var(--border);
        border-radius: 14px;
        padding: 14px;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .thumb {
        width: 100%;
        height: 160px;
        object-fit: cover;
        border-radius: 10px;
        background: #f3f3f3;
    }

    .row {
        display: flex;
        gap: 8px;
        align-items: center;
        flex-wrap: wrap;
    }

    .btn {
        padding: 8px 12px;
        border-radius: 10px;
        cursor: pointer;
        border: 1px solid #dcdcdc;
        background: #fff;
    }

    .btn-danger {
        border-color: #e99;
        background: #fee;
    }

    .btn-primary {
        background: linear-gradient(180deg, var(--accent), var(--accent2));
        color: #fff;
        border: none;
    }

    select {
        padding: 8px 10px;
        border: 1px solid #eaeaea;
        border-radius: 10px;
    }

    .alert {
        padding: 10px 12px;
        border-radius: 10px;
        margin: 10px 0;
    }

    .alert-ok {
        background: #e6ffea;
        border: 1px solid #b5f5c9;
    }

    .alert-err {
        background: #ffe0e0;
        border: 1px solid #ffaaaa;
    }
    </style>

    <?php if (!empty($_SESSION['flash'])): $f=$_SESSION['flash']; unset($_SESSION['flash']); ?>
    <div class="alert <?= $f['type']==='err'?'alert-err':'alert-ok' ?>"><?= htmlspecialchars($f['msg']) ?></div>
    <?php endif; ?>
    <?php if ($ok): ?><div class="alert alert-ok"><?= htmlspecialchars($ok) ?></div><?php endif; ?>
    <?php if ($errors): ?><div class="alert alert-err">
        <ul style="margin:6px 0 0 18px;"><?php foreach($errors as $e): ?><li><?= htmlspecialchars($e) ?></li>
            <?php endforeach; ?></ul>
    </div><?php endif; ?>

    <div class="row" style="justify-content:space-between;margin-bottom:10px;">
        <a class="btn" href="./?p=ingyen_konyv_feladas">+ Új felajánlás</a>
        <div class="row" style="color:#555">Összes: <?= count($books) ?></div>
    </div>

    <?php if (!$books): ?>
    <div class="card">Még nincs felajánlásod.</div>
    <?php else: ?>
    <div class="grid">
        <?php foreach($books as $b): ?>
        <div class="card">
            <?php if (!empty($b['image_url'])): ?>
            <img class="thumb" src="<?= htmlspecialchars($b['image_url']) ?>" alt="borító">
            <?php else: ?>
            <div class="thumb" style="display:flex;align-items:center;justify-content:center;color:#777;">Nincs kép
            </div>
            <?php endif; ?>

            <div><strong><?= htmlspecialchars($b['title']) ?></strong></div>
            <div style="color:#555;font-size:13px;"><?= htmlspecialchars($b['author']??'') ?> —
                <?= htmlspecialchars($b['city']??'') ?></div>
            <div style="color:#555;font-size:12px;">Feladva: <?= htmlspecialchars($b['created_at']) ?></div>
            <div style="color:#555;font-size:12px;">Igénylések: <?= (int)($counts[$b['id']]??0) ?></div>

            <!-- státusz -->
            <form method="post" class="row" action="./?p=ingyen_konyveim">
                <input type="hidden" name="csrf" value="<?= htmlspecialchars($csrf) ?>">
                <input type="hidden" name="book_id" value="<?= (int)$b['id'] ?>">
                <input type="hidden" name="act" value="status">
                <select name="status">
                    <?php foreach (['available'=>'Elvihető','reserved'=>'Foglalt','gone'=>'Elvitték'] as $val=>$label): ?>
                    <option value="<?= $val ?>" <?= $b['status']===$val?'selected':'' ?>><?= $label ?></option>
                    <?php endforeach; ?>
                </select>
                <button class="btn btn-primary" type="submit">Mentés</button>
            </form>

            <!-- kép csere / törlés -->
            <form method="post" enctype="multipart/form-data" class="row" action="./?p=ingyen_konyveim">
                <input type="hidden" name="csrf" value="<?= htmlspecialchars($csrf) ?>">
                <input type="hidden" name="book_id" value="<?= (int)$b['id'] ?>">
                <input type="hidden" name="act" value="replace_image">
                <input type="file" name="image" accept=".jpg,.jpeg,.png,.webp,.gif">
                <button class="btn" type="submit">Kép csere</button>
                <?php if (!empty($b['image_url'])): ?>
                <button class="btn btn-danger" type="submit" formaction="./?p=ingyen_konyveim" name="act"
                    value="remove_image">Kép törlése</button>
                <?php endif; ?>
            </form>

            <!-- felajánlás törlése -->
            <form method="post" action="./?p=ingyen_konyveim" onsubmit="return confirm('Biztos törlöd?');">
                <input type="hidden" name="csrf" value="<?= htmlspecialchars($csrf) ?>">
                <input type="hidden" name="book_id" value="<?= (int)$b['id'] ?>">
                <input type="hidden" name="act" value="delete">
                <button class="btn btn-danger" type="submit">Felajánlás törlése</button>
            </form>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>