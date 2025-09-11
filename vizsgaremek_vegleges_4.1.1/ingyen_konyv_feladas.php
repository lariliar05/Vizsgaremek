<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

if (!isset($_SESSION['uid'])) {
  $_SESSION['flash'] = ["type"=>"err","msg"=>"Felajánlást csak bejelentkezve adhatsz fel."];
  header("Location: ./?p=ingyen_konyvek"); exit;
}

// CSRF
if (empty($_SESSION['csrf'])) { $_SESSION['csrf'] = bin2hex(random_bytes(16)); }
$csrf = $_SESSION['csrf'];

$errors=[]; $ok="";

/* --- Szervezetek legördülőhöz (bármikor kell a formban) --- */
$orgs = [];
$oq = mysqli_query($adb, "SELECT uid, COALESCE(org_name, username) AS nev FROM user WHERE is_org=1 ORDER BY nev");
while ($oq && ($r = mysqli_fetch_assoc($oq))) { $orgs[] = $r; }

if ($_SERVER['REQUEST_METHOD']==='POST') {
  if (!isset($_POST['csrf']) || !hash_equals($csrf, $_POST['csrf'])) {
    $errors[]="Érvénytelen űrlap (CSRF).";
  } else {
    $title  = trim($_POST['title'] ?? '');
    $author = trim($_POST['author'] ?? '');
    $desc   = trim($_POST['description'] ?? '');
    $city   = trim($_POST['city'] ?? '');
    $email  = trim($_POST['contact_email'] ?? '');
    $phone  = trim($_POST['contact_phone'] ?? '');

    // ÚJ: szervezeti jelölés + cél szervezet
    $orgOnly = isset($_POST['org_only']) ? 1 : 0;
    $recipientOrgId = !empty($_POST['recipient_org_id']) ? (int)$_POST['recipient_org_id'] : null;

    if ($title==='') $errors[]="A cím kötelező.";
    if ($email!=='' && !filter_var($email, FILTER_VALIDATE_EMAIL)) $errors[]="Hibás e-mail.";

    // KÉP (opcionális)
    $imageUrl=null;
    if (!empty($_FILES['image']['name'])) {
      if ($_FILES['image']['error']!==UPLOAD_ERR_OK) {
        $errors[]="Képfeltöltési hiba (".$_FILES['image']['error'].").";
      } else {
        $allowed=['jpg','jpeg','png','webp','gif'];
        $max=3*1024*1024; // 3MB
        if ($_FILES['image']['size']>$max) $errors[]="A kép túl nagy (max 3MB).";
        $ext=strtolower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
        if (!in_array($ext,$allowed,true)) $errors[]="Csak JPG/PNG/WEBP/GIF engedélyezett.";

        if (!$errors) {
          $dir=__DIR__."/uploads/free_books";
          if (!is_dir($dir)) { @mkdir($dir,0777,true); }
          $fname=time().'_'.bin2hex(random_bytes(4)).'.'.$ext;
          $dest=$dir.'/'.$fname;
          if (move_uploaded_file($_FILES['image']['tmp_name'],$dest)) {
            $imageUrl='uploads/free_books/'.$fname; // relatív elérési út az oldalhoz
          } else {
            $errors[]="Nem sikerült a képet menteni.";
          }
        }
      }
    }

    if (!$errors) {
      $uid=(int)$_SESSION['uid'];

      /* ÚJ: org_only + recipient_org_id bekerül a beszúrásba (status továbbra is 'available') */
      $stmt = mysqli_prepare(
        $adb,
        "INSERT INTO free_books
          (title,author,description,city,image_url,owner_user_id,contact_email,contact_phone,org_only,recipient_org_id,status)
         VALUES (?,?,?,?,?,?,?,?,?,?,'available')"
      );
      // s s s s s i s s i i
      mysqli_stmt_bind_param(
        $stmt,
        "ssssisssii",
        $title,
        $author,
        $desc,
        $city,
        $imageUrl,       // lehet NULL is
        $uid,
        $email,
        $phone,
        $orgOnly,
        $recipientOrgId  // lehet NULL is
      );

      if ($stmt && mysqli_stmt_execute($stmt)) {
        $ok="Köszönjük! A könyved felkerült. (#".mysqli_insert_id($adb).")";
        // ürítsük a POST-ot, hogy a form is tiszta legyen
        $_POST=[]; $_FILES=[];
      } else {
        $errors[]="Mentési hiba: ".mysqli_error($adb);
      }
      if ($stmt) mysqli_stmt_close($stmt);
    }
  }
}
?>
<div style="max-width:800px;margin:0 auto;padding:20px;">
  <h1>Könyv felajánlása</h1>
  <style>
    :root { --accent:#ff6b6b; --accent2:#e65959; --border:#eaeaea; --ring:rgba(255,107,107,.25); }
    body { color:#000; }
    .card { background:#fff; border:1px solid var(--border); border-radius:14px; padding:16px; }
    .grid2 { display:grid; grid-template-columns: 1fr 1fr; gap:12px; }
    input, textarea, select { width:100%; padding:10px 12px; border:1px solid var(--border); border-radius:10px; outline:none; box-sizing:border-box; }
    textarea { max-height:200px; resize:vertical; }
    input:focus, textarea:focus, select:focus { box-shadow:0 0 0 4px var(--ring); }
    .btn { padding:10px 14px; border-radius:10px; cursor:pointer; border:1px solid #dcdcdc; background:#fff; }
    .btn-primary { background:linear-gradient(180deg,var(--accent),var(--accent2)); color:#fff; border:none; }
    .alert { padding:10px 12px; border-radius:10px; margin:10px 0; }
    .alert-ok { background:#e6ffea; border:1px solid #b5f5c9; }
    .alert-err{ background:#ffe0e0; border:1px solid #ffaaaa; }
    .muted{ color:#666; font-size:13px; }
    .org-row{ display:flex; align-items:center; gap:8px; }
  </style>

  <?php if ($ok): ?><div class="alert alert-ok"><?= htmlspecialchars($ok) ?></div><?php endif; ?>
  <?php if ($errors): ?><div class="alert alert-err">
    <ul style="margin:6px 0 0 18px;"><?php foreach($errors as $e): ?><li><?= htmlspecialchars($e) ?></li><?php endforeach; ?></ul>
  </div><?php endif; ?>

  <form class="card" method="post" enctype="multipart/form-data" action="./?p=ingyen_konyv_feladas">
    <input type="hidden" name="csrf" value="<?= htmlspecialchars($csrf) ?>">

    <!-- ÚJ: szervezeti adomány blokk -->
    <div style="margin-bottom:12px; padding:12px; border:1px solid #eee; border-radius:10px;">
      <label class="org-row">
        <input type="checkbox" name="org_only" value="1"
               id="org_only" <?= !empty($_POST['org_only']) ? 'checked' : '' ?>>
        <strong>Szervezeti adomány</strong>
      </label>
      <div style="margin-top:8px;">
        <label>Cél szervezet (opcionális):
          <select name="recipient_org_id" id="recipient_org_id" <?= empty($_POST['org_only']) ? 'disabled' : '' ?>>
            <option value="">— Bármely szervezet viheti el —</option>
            <?php
              $sel = $_POST['recipient_org_id'] ?? '';
              foreach($orgs as $o):
                $optVal = (int)$o['uid'];
                $isSel  = ($sel !== '' && (int)$sel === $optVal) ? 'selected' : '';
            ?>
              <option value="<?= $optVal ?>" <?= $isSel ?>><?= htmlspecialchars($o['nev']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>
      </div>
      <div class="muted" style="margin-top:6px;">
        Ha bejelölöd, <em>magánszemély</em> nem igényelheti; csak szervezet(ek). Cél szervezet megadása esetén kizárólag a kijelölt szervezet viheti el.
      </div>
    </div>

    <div class="grid2">
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Cím*</div>
        <input type="text" name="title" required value="<?= htmlspecialchars($_POST['title']??'') ?>">
      </div>
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Szerző</div>
        <input type="text" name="author" value="<?= htmlspecialchars($_POST['author']??'') ?>">
      </div>
    </div>

    <div class="grid2">
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Város</div>
        <input type="text" name="city" value="<?= htmlspecialchars($_POST['city']??'') ?>">
      </div>
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Kép (opcionális, max 3MB)</div>
        <input type="file" name="image" accept=".jpg,.jpeg,.png,.webp,.gif">
      </div>
    </div>

    <div>
      <div style="font-size:13px;color:#555;margin-bottom:6px;">Leírás</div>
      <textarea name="description" rows="4"><?= htmlspecialchars($_POST['description']??'') ?></textarea>
    </div>

    <div class="grid2">
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Kapcsolat e-mail</div>
        <input type="text" name="contact_email" placeholder="pl. te@pelda.hu"
               value="<?= htmlspecialchars($_POST['contact_email']??'') ?>">
      </div>
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Kapcsolat telefon</div>
        <input type="text" name="contact_phone" placeholder="+36 …"
               value="<?= htmlspecialchars($_POST['contact_phone']??'') ?>">
      </div>
    </div>

    <div style="display:flex;gap:10px;margin-top:10px;">
      <button class="btn btn-primary" type="submit">Felajánlás közzététele</button>
      <a class="btn" href="./?p=ingyen_konyvek">Mégse</a>
    </div>
  </form>
</div>

<script>
  // a "Cél szervezet" select legyen csak akkor aktív, ha pipálva van a "Szervezeti adomány"
  const orgOnly = document.getElementById('org_only');
  const recip   = document.getElementById('recipient_org_id');
  if (orgOnly && recip) {
    orgOnly.addEventListener('change', () => {
      recip.disabled = !orgOnly.checked;
      if (!orgOnly.checked) recip.value = '';
    });
  }
</script>
