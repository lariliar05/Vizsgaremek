<?php

if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";                 
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");    


$cats = ['háborús-sebesültek','egészség','oktatás','állatvédelem','környezet','szociális','kultúra','egyéb'];
$q   = trim($_GET['q'] ?? "");
$cat = $_GET['cat'] ?? 'háborús-sebesültek';
if (!in_array($cat, $cats, true)) $cat = 'háborús-sebesültek';


$sql = "SELECT id, name, description, category, website_url, donate_url, city, country
        FROM donation_targets
        WHERE verified=1";
$params = []; $types = "";
if ($q !== "") {
  $sql .= " AND (name LIKE ? OR COALESCE(city,'') LIKE ? OR COALESCE(country,'') LIKE ? OR COALESCE(description,'') LIKE ?)";
  for ($i=0; $i<4; $i++) { $params[]="%$q%"; $types.="s"; }
}
if ($cat !== "") { $sql .= " AND category=?"; $params[]=$cat; $types.="s"; }
$sql .= " ORDER BY name LIMIT 100";

$stmt = mysqli_prepare($adb, $sql);
if ($params) { mysqli_stmt_bind_param($stmt, $types, ...$params); }
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);
$targets = [];
while ($res && ($r = mysqli_fetch_assoc($res))) { $targets[] = $r; }
mysqli_stmt_close($stmt);
?>
<div style="max-width:1000px;margin:0 auto;padding:20px;">
  <h1>Adományozz szervezeteknek</h1>

  <style>
    :root{--accent:#ff6b6b; --accent2:#e65959; --ink:#000; --muted:#000;--card:#fff; --border:#eaeaea; --ring:rgba(255,107,107,.25);}
    body { color:#000; }
    .row{display:flex;gap:12px;align-items:center;flex-wrap:wrap;}
    .grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:14px;}
    .card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:14px;display:flex;flex-direction:column;gap:8px;}
    input[type="text"]{padding:10px 12px;border:1px solid var(--border);border-radius:10px;outline:none;width:260px;}
    input[type="text"]:focus{box-shadow:0 0 0 4px var(--ring);}
    .pill{padding:8px 12px;border:1px solid var(--border);border-radius:999px;cursor:pointer;user-select:none;color: #fff;}
    .pill.active{background:linear-gradient(180deg,var(--accent),var(--accent2));color: #fff;;border-color:transparent;}
    .btn{padding:10px 14px;border-radius:10px;cursor:pointer;border:1px solid rgba(255, 170, 170, 1);background:#fff;}
    .btn-primary{background:linear-gradient(180deg,var(--accent),var(--accent2));color:#fff;border:none;}
    .tags{display:flex;gap:8px;flex-wrap:wrap;font-size:12px;color:#555;}
    .tag{background:#f3f3f3;border:1px solid #ececec;border-radius:999px;padding:2px 8px;}
    .muted{color:var(--muted);font-size:13px;}
    .alert{padding:10px 12px;border-radius:10px;margin:10px 0;}
    .alert-ok{background:#e6ffea;border:1px solid #b5f5c9;}
    .alert-err{background:#ffe0e0;border:1px solid rgba(255, 170, 170, 1);}

  </style>

  <?php if (!empty($_SESSION['flash'])): $f = $_SESSION['flash']; unset($_SESSION['flash']); ?>
    <div class="alert <?= $f['type']==='err'?'alert-err':($f['type']==='warn'?'alert-err':'alert-ok') ?>">
      <?= htmlspecialchars($f['msg']) ?>
    </div>
  <?php endif; ?>

  <?php if (!isset($_SESSION['uid'])): ?>
    <div class="alert alert-err" style="margin-top:10px;">
      Támogatni csak bejelentkezve lehet. A <strong>Támogatom</strong> gomb megnyomásakor nem indítunk átirányítást.
    </div>
  <?php endif; ?>

  <?php if ($cat === 'háborús-sebesültek'): ?>
    <div class="alert alert-ok" style="margin-top:10px;">
      Kiemelt téma: <strong>Háborús sebesültek</strong>. A fenti kategóriákkal válthatsz más ügyekre is.
    </div>
  <?php endif; ?>

 
  <form method="get" action="./" class="row" style="justify-content:space-between;margin-bottom:12px;">
    <input type="hidden" name="p" value="adomanyozz">
    <div class="row">
      <input type="text" name="q" value="<?= htmlspecialchars($q) ?>" placeholder="Keresés név, város, leírás…">
      <div class="row" id="catpills">
        <input type="hidden" id="cat" name="cat" value="<?= htmlspecialchars($cat) ?>">
        <?php foreach ($cats as $c): ?>
          <span class="pill <?= $cat===$c?'active':'' ?>" data-cat="<?= htmlspecialchars($c) ?>"><?= htmlspecialchars(ucfirst($c)) ?></span>
        <?php endforeach; ?>
      </div>
      <button class="btn" type="submit">Keresés</button>
    </div>
    <div class="muted"><?= count($targets) ?> találat</div>
  </form>


  <div class="grid">
    <?php foreach ($targets as $t): ?>
      <div class="card">
        <h3 style="margin:0;"><?= htmlspecialchars($t['name']) ?></h3>
        <div class="muted"><?= htmlspecialchars($t['description'] ?? '') ?></div>
        <div class="tags">
          <span class="tag"><?= htmlspecialchars($t['category']) ?></span>
          <?php if (!empty($t['city'])): ?><span class="tag"><?= htmlspecialchars($t['city']) ?></span><?php endif; ?>
          <?php if (!empty($t['country'])): ?><span class="tag"><?= htmlspecialchars($t['country']) ?></span><?php endif; ?>
        </div>
        <div class="row" style="margin-top:6px;">
          <?php if (!empty($t['website_url'])): ?>
            <a class="btn" href="<?= htmlspecialchars($t['website_url']) ?>" target="_blank" rel="noopener">Honlap</a>
          <?php endif; ?>
       
          <a class="btn btn-primary" href="./go_donate.php?id=<?= (int)$t['id'] ?>">Támogatom</a>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
</div>

<script>
  // kategória pillék
  const pills = document.querySelectorAll('#catpills .pill');
  const catInput = document.getElementById('cat');
  pills.forEach(p => p.addEventListener('click', () => {
    pills.forEach(x => x.classList.remove('active'));
    p.classList.add('active');
    catInput.value = p.dataset.cat || '';
  }));
</script>
<?php