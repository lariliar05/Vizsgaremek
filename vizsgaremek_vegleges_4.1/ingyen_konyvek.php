<?php
// ingyen_konyvek.php – 7. pont (A+B+C) egyben
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

// 7/A – a lekérdezésben legyen org_only és recipient_org_id
$books = [];
$res = mysqli_query(
  $adb,
  "SELECT id, title, author, description, city, image_url, status, org_only, recipient_org_id
   FROM free_books
   WHERE status='available'
   ORDER BY created_at DESC"
);
while ($res && ($r = mysqli_fetch_assoc($res))) { $books[] = $r; }

// bejelentkezés és szervezeti státusz a 7/C-hez
$isLogged = isset($_SESSION['uid']);
$isOrg    = $isLogged ? (int)($_SESSION['is_org'] ?? 0) : 0;
?>
<?php
if (session_status()===PHP_SESSION_NONE) session_start();
require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");

$bookId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($bookId<=0) die("<script>alert('Hiányzó könyv ID');history.back();</script>");

$r = mysqli_query($adb, "SELECT id, org_only, recipient_org_id FROM free_books WHERE id=$bookId LIMIT 1");
$book = $r ? mysqli_fetch_assoc($r) : null;
if (!$book) die("<script>alert('Nincs ilyen könyv');location.href='./?p=ingyen_konyvek';</script>");

$onlyOrg = (int)$book['org_only'];
$target  = (int)($book['recipient_org_id'] ?? 0);

if ($onlyOrg) {
  if (!isset($_SESSION['uid'])) {
    die("<script>alert('Csak bejelentkezett szervezetek igényelhetik!');location.href='./?p=login';</script>");
  }
  $uid = (int)$_SESSION['uid'];
  $isOrg = (int)($_SESSION['is_org'] ?? 0);
  if (!$isOrg) {
    die("<script>alert('Magánszemélyként nem igényelhető szervezeti adomány.');location.href='./?p=ingyen_konyvek';</script>");
  }
  if ($target && $uid !== $target) {
    die("<script>alert('Ez az adomány csak a kijelölt szervezetnek szól.');location.href='./?p=ingyen_konyvek';</script>");
  }
}

/* innen folytatódhat a meglévő igénylési űrlapod / beszúrás */
?>
<div style="max-width:1100px;margin:0 auto;padding:20px;" class="free-container">
  <h1>Ingyen könyvek</h1>

  <style>
    :root {
      --accent: #ff6b6b;
      --accent2: #e65959;
      --card: #fff;
      --border: #eaeaea;
      --ring: rgba(255, 107, 107, .25);
    }
    body { color:#000; }
    .row { display:flex; gap:12px; align-items:center; flex-wrap:wrap; }
    .grid { display:grid; grid-template-columns:repeat(auto-fill, minmax(260px,1fr)); gap:14px; }
    .card { background:var(--card); border:1px solid var(--border); border-radius:14px; padding:14px; display:flex; flex-direction:column; gap:8px; }
    .title { font-weight:700; }
    .muted { color:#333; font-size:13px; }
    .btn { padding:10px 14px; border-radius:10px; cursor:pointer; border:1px solid #dcdcdc; background:#fff; color:#000; }
    .btn-primary { background:linear-gradient(180deg,var(--accent),var(--accent2)); color:#fff; border:none; }
    input[type="text"]{ padding:10px 12px; border:1px solid var(--border); border-radius:10px; outline:none; min-width:280px; }
    input[type="text"]:focus{ box-shadow:0 0 0 4px var(--ring); }
    .thumb{ width:100%; height:160px; object-fit:cover; border-radius:10px; background:#f3f3f3; }
    .badge{ display:inline-block; background:#f7f7f7; border:1px solid #eee; border-radius:999px; padding:2px 8px; font-size:12px; color:#444; }
    .empty{ padding:10px; border:1px dashed #ddd; border-radius:10px; background:#fff; }
    #freeSearch + .muted { color:#ffa500; }
    #freeSearch + .muted #cnt { color:#ffa500; font-weight:600; }

    .free-container{ max-width:1200px; margin:0 auto; padding:20px; }

    /* KÉT OSZLOP FIXEN, stabil hézaggal */
    #freeList{ display:grid !important; grid-template-columns:repeat(2, minmax(0,1fr)) !important; gap:40px !important; }
    #freeList .card{ width:100%; }

    /* Mobilon 1 oszlop */
    @media (max-width:800px){
      #freeList{ grid-template-columns:1fr !important; }
    }
  </style>

  <?php if (isset($_SESSION['uid'])): ?>
    <div class="row" style="gap:8px;margin:8px 0 14px;">
      <a class="btn" href="./?p=ingyen_konyv_feladas">+ Könyv felajánlása</a>
      <a class="btn" href="./?p=ingyen_konyveim">Saját felajánlásaim</a>
      <a class="btn" href="./?p=ingyen_konyv_kereseim">Saját igényléseim</a>
    </div>
  <?php endif; ?>

  <div class="row" style="justify-content:space-between;margin:8px 0 14px;">
    <input id="freeSearch" type="text" placeholder="Keresés cím, szerző, város…">
    <div class="muted"><span id="cnt"><?= count($books) ?></span> találat</div>
  </div>

  <?php if (!$books): ?>
    <div class="empty">Még nincs felajánlott könyv. Légy te az első! 🙂</div>
  <?php else: ?>
    <div id="freeList" class="grid">
      <?php foreach ($books as $b): ?>
        <div class="card free-card" data-text="<?= htmlspecialchars(strtolower(($b['title']??'').' '.($b['author']??'').' '.($b['city']??'').' '.($b['description']??'')), ENT_QUOTES) ?>">
          <?php if (!empty($b['image_url'])): ?>
            <img class="thumb" src="<?= htmlspecialchars($b['image_url']) ?>" alt="borító">
          <?php else: ?>
            <div class="thumb" style="display:flex;align-items:center;justify-content:center;color:#777;">Nincs kép</div>
          <?php endif; ?>

          <div class="title"><?= htmlspecialchars($b['title']) ?></div>
          <div class="muted"><?= htmlspecialchars($b['author'] ?? 'Ismeretlen szerző') ?></div>
          <div class="muted"><?= htmlspecialchars($b['city'] ?? '') ?></div>
          <div class="muted" style="min-height:40px;"><?= htmlspecialchars($b['description'] ?? '') ?></div>

          <!-- 7/B – Jelvények a gombok ELŐTT -->
          <?php if (!empty($b['org_only'])): ?>
            <div class="row" style="gap:8px;margin:6px 0;">
              <span class="badge" style="background:#111;color:#ffa500;border-color:#333;">Szervezeti adomány</span>
              <?php if (!empty($b['recipient_org_id'])): ?>
                <span class="badge">Cél: kijelölt szervezet</span>
              <?php else: ?>
                <span class="badge">Cél: bármely szervezet</span>
              <?php endif; ?>
            </div>
          <?php endif; ?>

          <!-- 7/C – Gombfeltételek -->
          <?php
            $onlyOrg  = (int)($b['org_only'] ?? 0);
            $targetId = (int)($b['recipient_org_id'] ?? 0);
            $canTake = true; $msg = '';

            if ($onlyOrg) {
              if (!$isLogged) { $canTake=false; $msg='Csak bejelentkezett szervezetek igényelhetik!'; }
              elseif (!$isOrg){ $canTake=false; $msg='Magánszemélyként nem igényelhető szervezeti adomány.'; }
              elseif ($targetId && (int)$_SESSION['uid'] !== $targetId){
                $canTake=false; $msg='Ez az adomány csak a kijelölt szervezetnek szól.';
              }
            }
          ?>
          <div class="row" style="justify-content:space-between;">
            <span class="badge">Elvihető</span>
            <?php if ($canTake): ?>
              <a class="btn btn-primary" href="./?p=ingyen_konyv_igenyles&id=<?= (int)$b['id'] ?>">Elviszem</a>
            <?php else: ?>
              <a class="btn btn-primary" href="javascript:void(0)" onclick="alert('<?= htmlspecialchars($msg,ENT_QUOTES) ?>')">Elviszem</a>
            <?php endif; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>
</div>

<script>
// élő kereső
const input = document.getElementById('freeSearch');
const cards = Array.from(document.querySelectorAll('.free-card'));
const cnt = document.getElementById('cnt');
input.addEventListener('input', () => {
  const q = input.value.trim().toLowerCase();
  let vis = 0;
  cards.forEach(c => {
    const t = c.getAttribute('data-text') || '';
    const show = !q || t.includes(q);
    c.style.display = show ? '' : 'none';
    if (show) vis++;
  });
  cnt.textContent = vis;
});
</script>
<?php
// ingyen_konyvek.php – 7. pont (A+B+C) egyben
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

// 7/A – a lekérdezésben legyen org_only és recipient_org_id
$books = [];
$res = mysqli_query(
  $adb,
  "SELECT id, title, author, description, city, image_url, status, org_only, recipient_org_id
   FROM free_books
   WHERE status='available'
   ORDER BY created_at DESC"
);
while ($res && ($r = mysqli_fetch_assoc($res))) { $books[] = $r; }

// bejelentkezés és szervezeti státusz a 7/C-hez
$isLogged = isset($_SESSION['uid']);
$isOrg    = $isLogged ? (int)($_SESSION['is_org'] ?? 0) : 0;
?>
<div style="max-width:1100px;margin:0 auto;padding:20px;" class="free-container">
  <h1>Ingyen könyvek</h1>

  <style>
    :root {
      --accent: #ff6b6b;
      --accent2: #e65959;
      --card: #fff;
      --border: #eaeaea;
      --ring: rgba(255, 107, 107, .25);
    }
    body { color:#000; }
    .row { display:flex; gap:12px; align-items:center; flex-wrap:wrap; }
    .grid { display:grid; grid-template-columns:repeat(auto-fill, minmax(260px,1fr)); gap:14px; }
    .card { background:var(--card); border:1px solid var(--border); border-radius:14px; padding:14px; display:flex; flex-direction:column; gap:8px; }
    .title { font-weight:700; }
    .muted { color:#333; font-size:13px; }
    .btn { padding:10px 14px; border-radius:10px; cursor:pointer; border:1px solid #dcdcdc; background:#fff; color:#000; }
    .btn-primary { background:linear-gradient(180deg,var(--accent),var(--accent2)); color:#fff; border:none; }
    input[type="text"]{ padding:10px 12px; border:1px solid var(--border); border-radius:10px; outline:none; min-width:280px; }
    input[type="text"]:focus{ box-shadow:0 0 0 4px var(--ring); }
    .thumb{ width:100%; height:160px; object-fit:cover; border-radius:10px; background:#f3f3f3; }
    .badge{ display:inline-block; background:#f7f7f7; border:1px solid #eee; border-radius:999px; padding:2px 8px; font-size:12px; color:#444; }
    .empty{ padding:10px; border:1px dashed #ddd; border-radius:10px; background:#fff; }
    #freeSearch + .muted { color:#ffa500; }
    #freeSearch + .muted #cnt { color:#ffa500; font-weight:600; }

    .free-container{ max-width:1200px; margin:0 auto; padding:20px; }

    /* KÉT OSZLOP FIXEN, stabil hézaggal */
    #freeList{ display:grid !important; grid-template-columns:repeat(2, minmax(0,1fr)) !important; gap:40px !important; }
    #freeList .card{ width:100%; }

    /* Mobilon 1 oszlop */
    @media (max-width:800px){
      #freeList{ grid-template-columns:1fr !important; }
    }
  </style>

  <?php if (isset($_SESSION['uid'])): ?>
    <div class="row" style="gap:8px;margin:8px 0 14px;">
      <a class="btn" href="./?p=ingyen_konyv_feladas">+ Könyv felajánlása</a>
      <a class="btn" href="./?p=ingyen_konyveim">Saját felajánlásaim</a>
      <a class="btn" href="./?p=ingyen_konyv_kereseim">Saját igényléseim</a>
    </div>
  <?php endif; ?>

  <div class="row" style="justify-content:space-between;margin:8px 0 14px;">
    <input id="freeSearch" type="text" placeholder="Keresés cím, szerző, város…">
    <div class="muted"><span id="cnt"><?= count($books) ?></span> találat</div>
  </div>

  <?php if (!$books): ?>
    <div class="empty">Még nincs felajánlott könyv. Légy te az első! 🙂</div>
  <?php else: ?>
    <div id="freeList" class="grid">
      <?php foreach ($books as $b): ?>
        <div class="card free-card" data-text="<?= htmlspecialchars(strtolower(($b['title']??'').' '.($b['author']??'').' '.($b['city']??'').' '.($b['description']??'')), ENT_QUOTES) ?>">
          <?php if (!empty($b['image_url'])): ?>
            <img class="thumb" src="<?= htmlspecialchars($b['image_url']) ?>" alt="borító">
          <?php else: ?>
            <div class="thumb" style="display:flex;align-items:center;justify-content:center;color:#777;">Nincs kép</div>
          <?php endif; ?>

          <div class="title"><?= htmlspecialchars($b['title']) ?></div>
          <div class="muted"><?= htmlspecialchars($b['author'] ?? 'Ismeretlen szerző') ?></div>
          <div class="muted"><?= htmlspecialchars($b['city'] ?? '') ?></div>
          <div class="muted" style="min-height:40px;"><?= htmlspecialchars($b['description'] ?? '') ?></div>

          <!-- 7/B – Jelvények a gombok ELŐTT -->
          <?php if (!empty($b['org_only'])): ?>
            <div class="row" style="gap:8px;margin:6px 0;">
              <span class="badge" style="background:#111;color:#ffa500;border-color:#333;">Szervezeti adomány</span>
              <?php if (!empty($b['recipient_org_id'])): ?>
                <span class="badge">Cél: kijelölt szervezet</span>
              <?php else: ?>
                <span class="badge">Cél: bármely szervezet</span>
              <?php endif; ?>
            </div>
          <?php endif; ?>

          <!-- 7/C – Gombfeltételek -->
          <?php
            $onlyOrg  = (int)($b['org_only'] ?? 0);
            $targetId = (int)($b['recipient_org_id'] ?? 0);
            $canTake = true; $msg = '';

            if ($onlyOrg) {
              if (!$isLogged) { $canTake=false; $msg='Csak bejelentkezett szervezetek igényelhetik!'; }
              elseif (!$isOrg){ $canTake=false; $msg='Magánszemélyként nem igényelhető szervezeti adomány.'; }
              elseif ($targetId && (int)$_SESSION['uid'] !== $targetId){
                $canTake=false; $msg='Ez az adomány csak a kijelölt szervezetnek szól.';
              }
            }
          ?>
          <div class="row" style="justify-content:space-between;">
            <span class="badge">Elvihető</span>
            <?php if ($canTake): ?>
              <a class="btn btn-primary" href="./?p=ingyen_konyv_igenyles&id=<?= (int)$b['id'] ?>">Elviszem</a>
            <?php else: ?>
              <a class="btn btn-primary" href="javascript:void(0)" onclick="alert('<?= htmlspecialchars($msg,ENT_QUOTES) ?>')">Elviszem</a>
            <?php endif; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>
</div>

<script>
// élő kereső
const input = document.getElementById('freeSearch');
const cards = Array.from(document.querySelectorAll('.free-card'));
const cnt = document.getElementById('cnt');
input.addEventListener('input', () => {
  const q = input.value.trim().toLowerCase();
  let vis = 0;
  cards.forEach(c => {
    const t = c.getAttribute('data-text') || '';
    const show = !q || t.includes(q);
    c.style.display = show ? '' : 'none';
    if (show) vis++;
  });
  cnt.textContent = vis;
});
</script>
