<?php
if (!isset($adb)) { die("DB kapcsolat hianyzik."); }
mysqli_set_charset($adb, "utf8mb4");

// Klubok lekérdezése
$clubs = [];
$q = mysqli_query($adb, "SELECT id, name, description, latitude, longitude FROM book_clubs ORDER BY id");
if ($q) {
    while ($r = mysqli_fetch_assoc($q)) { $clubs[] = $r; }
}

// Eldönti, hogy a bejelentkezett felhasználó tag-e
function userJoinedClub(mysqli $adb, int $userId, int $clubId): bool {
    $stmt = mysqli_prepare($adb, "SELECT 1 FROM book_club_members WHERE user_id=? AND club_id=?");
    mysqli_stmt_bind_param($stmt, "ii", $userId, $clubId);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_store_result($stmt);
    $ok = mysqli_stmt_num_rows($stmt) > 0;
    mysqli_stmt_close($stmt);
    return $ok;
}
?>
<div style="padding:20px;">
  <h1>Könyvklubok</h1>

  <div id="map" style="height:500px;width:100%;margin:20px 0;border:1px solid #ddd;border-radius:8px;"></div>

  <?php if (empty($clubs)): ?>
    <p>Nincs még felvitt könyvklub.</p>
  <?php else: ?>
    <?php foreach ($clubs as $c): ?>
      <div class="club" style="display:flex;gap:16px;align-items:center;border:1px solid #ddd;border-radius:8px;padding:12px;margin-bottom:12px;">
        <div class="club-info" style="flex:1;">
          <h2 style="margin:0 0 6px;font-size:18px;">
            <?= htmlspecialchars($c['name']) ?> (ID: <?= (int)$c['id'] ?>)
          </h2>
          <p style="margin:2px 0;"><?= htmlspecialchars($c['description']) ?></p>
          <p style="margin:2px 0;">Koordináták: <?= $c['latitude'] ?>, <?= $c['longitude'] ?></p>
        </div>

        <?php if (isset($_SESSION['uid'])): ?>
          <?php
            $joined = userJoinedClub($adb, (int)$_SESSION['uid'], (int)$c['id']);
            $action = $joined ? 'leave' : 'join';
            $label  = $joined ? 'LEAVE' : 'JOIN';
          ?>
          <form method="post" action="toggle_membership.php" style="margin-left:auto;">
            <input type="hidden" name="club_id" value="<?= (int)$c['id'] ?>">
            <button type="submit" name="action" value="<?= $action ?>" style="padding:6px 12px;border:1px solid #999;border-radius:6px;cursor:pointer;">
              <?= $label ?>
            </button>
          </form>
        <?php endif; ?>
      </div>
    <?php endforeach; ?>
  <?php endif; ?>
</div>

<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY"></script>
<script>
  const clubs = <?= json_encode($clubs, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?>;

  function initMap() {
    const center = clubs.length
      ? { lat: parseFloat(clubs[0].latitude), lng: parseFloat(clubs[0].longitude) }
      : { lat: 47.497913, lng: 19.040236 }; // Budapest

    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 12,
      center
    });

    clubs.forEach(c => {
      const pos = { lat: parseFloat(c.latitude), lng: parseFloat(c.longitude) };
      const m = new google.maps.Marker({ position: pos, map, title: c.name });
      const info = new google.maps.InfoWindow({ content: `<strong>${c.name}</strong>` });
      m.addListener("click", () => info.open(map, m));
    });
  }
  window.addEventListener('load', initMap);
</script>
