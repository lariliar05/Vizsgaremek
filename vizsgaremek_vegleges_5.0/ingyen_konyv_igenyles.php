<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

$bookId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($bookId <= 0) { header("Location: ./?p=ingyen_konyvek"); exit; }

/* Könyv betöltése – fontos mezők is */
$stmt = mysqli_prepare($adb, "SELECT id, title, author, description, city,
                                     contact_email, contact_phone, status,
                                     owner_user_id, org_only, recipient_org_id
                              FROM free_books WHERE id=? LIMIT 1");
mysqli_stmt_bind_param($stmt, "i", $bookId);
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);
$book = $res ? mysqli_fetch_assoc($res) : null;
mysqli_stmt_close($stmt);

if (!$book || $book['status'] !== 'available') {
  $_SESSION['flash'] = ["type"=>"err","msg"=>"Ez a könyv már nem elérhető."];
  header("Location: ./?p=ingyen_konyvek"); exit;
}

/* Szervezeti szabályok */
$onlyOrg = (int)($book['org_only'] ?? 0);
$target  = (int)($book['recipient_org_id'] ?? 0);

if ($onlyOrg) {
  if (!isset($_SESSION['uid'])) {
    die("<script>alert('Csak bejelentkezett szervezetek igényelhetik!');location.href='./?p=login';</script>");
  }
  $uid   = (int)$_SESSION['uid'];
  $isOrg = (int)($_SESSION['is_org'] ?? 0);
  if (!$isOrg) {
    die("<script>alert('Magánszemélyként nem igényelhető szervezeti adomány.');location.href='./?p=ingyen_konyvek';</script>");
  }
  if ($target && $uid !== $target) {
    die("<script>alert('Ez az adomány csak a kijelölt szervezetnek szól.');location.href='./?p=ingyen_konyvek';</script>");
  }
}

/* Saját könyvet ne lehessen igényelni */
if (isset($_SESSION['uid']) && (int)$book['owner_user_id'] === (int)$_SESSION['uid']) {
  die("<script>alert('A saját felajánlásodat nem igényelheted.');location.href='./?p=ingyen_konyvek';</script>");
}

/* CSRF */
if (empty($_SESSION['csrf'])) { $_SESSION['csrf'] = bin2hex(random_bytes(16)); }
$csrf = $_SESSION['csrf'];

$errors = []; $ok = "";
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  if (!isset($_POST['csrf']) || !hash_equals($_SESSION['csrf'], $_POST['csrf'])) {
    $errors[] = "Érvénytelen űrlap (CSRF).";
  } else {
    $name  = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $phone = trim($_POST['phone'] ?? '');
    $msg   = trim($_POST['message'] ?? '');

    if ($email==='' && $phone==='') $errors[] = "Adj meg e-mailt vagy telefonszámot.";
    if ($email!=='' && !filter_var($email, FILTER_VALIDATE_EMAIL)) $errors[] = "Érvénytelen e-mail cím.";

    // még egy önellenőrzés (ha valaki manuálisan küld POST-ot)
    if (isset($_SESSION['uid']) && (int)$book['owner_user_id'] === (int)$_SESSION['uid']) {
      $errors[] = "A saját felajánlásodat nem igényelheted.";
    }

    if (!$errors) {
      $uid = isset($_SESSION['uid']) ? (int)$_SESSION['uid'] : null;
      $stmt = mysqli_prepare($adb, "INSERT INTO free_book_requests
                  (book_id, requester_user_id, name, email, phone, message)
                  VALUES (?,?,?,?,?,?)");
      mysqli_stmt_bind_param($stmt, "iissss", $bookId, $uid, $name, $email, $phone, $msg);
      $okRun = $stmt && mysqli_stmt_execute($stmt);
      if ($stmt) mysqli_stmt_close($stmt);

      if ($okRun) {
        // értesítő e-mail a hirdetőnek (ha van kontakt e-mail)
        if (!empty($book['contact_email'])) {
          @mail(
            $book['contact_email'],
            "Érdeklődés: ".$book['title'],
            "Név: $name\nE-mail: $email\nTelefon: $phone\n\nÜzenet:\n$msg\n",
            "From: no-reply@example.com"
          );
        }
        $ok = "Köszönjük! Továbbítottuk a kérésed a hirdetőnek.";
        $_POST = [];
      } else {
        $errors[] = "Mentési hiba: ".mysqli_error($adb);
      }
    }
  }
}
?>
<div style="max-width:720px;margin:0 auto;padding:20px;">
  <h1>Elvinném: <?= htmlspecialchars($book['title']) ?></h1>
  <p style="color:#333">Szerző: <?= htmlspecialchars($book['author'] ?? 'Ismeretlen') ?> — Város: <?= htmlspecialchars($book['city'] ?? '') ?></p>

  <style>
    :root { --accent:#ff6b6b; --accent2:#e65959; --border:#eaeaea; --ring:rgba(255,107,107,.25); }
    body { color:#000; }
    .card { background:#fff; border:1px solid var(--border); border-radius:14px; padding:16px; }
    .grid2 { display:grid; grid-template-columns: 1fr 1fr; gap:12px; }
    input, textarea { width:100%; padding:10px 12px; border:1px solid #eaeaea; border-radius:10px; outline:none; box-sizing:border-box; }
    input:focus, textarea:focus { box-shadow:0 0 0 4px var(--ring); }
    .btn { padding:10px 14px; border-radius:10px; cursor:pointer; border:1px solid #dcdcdc; background:#fff; }
    .btn-primary { background:linear-gradient(180deg,var(--accent),var(--accent2)); color:#fff; border:none; }
    .alert { padding:10px 12px; border-radius:10px; margin:10px 0; }
    .alert-ok { background:#e6ffea; border:1px solid #b5f5c9; }
    .alert-err{ background:#ffe0e0; border:1px solid #ffaaaa; }
  </style>

  <?php if ($ok): ?><div class="alert alert-ok"><?= htmlspecialchars($ok) ?></div><?php endif; ?>
  <?php if ($errors): ?><div class="alert alert-err">
    <ul style="margin:6px 0 0 18px;"><?php foreach($errors as $e): ?><li><?= htmlspecialchars($e) ?></li><?php endforeach; ?></ul>
  </div><?php endif; ?>

  <form class="card" method="post" action="./?p=ingyen_konyv_igenyles&id=<?= (int)$book['id'] ?>">
    <input type="hidden" name="csrf" value="<?= htmlspecialchars($csrf) ?>">

    <div class="grid2">
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Név (opcionális)</div>
        <input type="text" name="name" value="<?= htmlspecialchars($_POST['name'] ?? '') ?>">
      </div>
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">E-mail (vagy telefon kötelező)</div>
        <input type="text" name="email" value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
      </div>
    </div>

    <div class="grid2">
      <div>
        <div style="font-size:13px;color:#555;margin-bottom:6px;">Telefon (vagy e-mail kötelező)</div>
        <input type="text" name="phone" value="<?= htmlspecialchars($_POST['phone'] ?? '') ?>">
      </div>
      <div></div>
    </div>

    <div>
      <div style="font-size:13px;color:#555;margin-bottom:6px;">Üzenet a hirdetőnek</div>
      <textarea name="message" rows="4"><?= htmlspecialchars($_POST['message'] ?? '') ?></textarea>
    </div>

    <div style="margin-top:10px;display:flex;gap:10px;">
      <button class="btn btn-primary" type="submit">Kérés elküldése</button>
      <a class="btn" href="./?p=ingyen_konyvek">Vissza</a>
    </div>
  </form>
</div>
