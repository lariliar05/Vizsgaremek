<?php
if (session_status() === PHP_SESSION_NONE) session_start();
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

header('Content-Type: application/json; charset=utf-8');

function seed_upcoming_events(mysqli $adb, int $need = 10): void {
  // mennyi jövőbeli esemény van most?
  $q = mysqli_query($adb, "SELECT COUNT(*) c FROM events WHERE start_at >= NOW()");
  $row = $q ? mysqli_fetch_assoc($q) : ['c'=>0];
  $have = (int)($row['c'] ?? 0);
  if ($have >= $need) return;

  $titles = [
    "Olvasóklub – kortárs próza","Író–olvasó találkozó","Nyelvművelő est",
    "Könyvkötészeti bemutató","Könyvcsere piknik","Sci-fi film és könyv klub",
    "Képregény klub","Kreatív írás kezdőknek","Ismeretterjesztő előadás – űrkutatás",
    "Irodalmi kvíz est","Hangoskönyv klub","Utazós irodalom klub",
    "Drámaolvasó kör","Női írók estje","Helytörténeti est","Esszé workshop"
  ];
  $cities = ["Budapest","Debrecen","Szeged","Pécs","Győr","Miskolc","Kecskemét","Veszprém","Eger","Szombathely","Tatabánya","Sopron"];
  $times  = ["16:00:00","17:00:00","18:00:00","19:00:00"];
  $durMin = [60, 90, 120];

  $stmt = mysqli_prepare($adb, "INSERT INTO events(title,description,start_at,end_at,cities,capacity) VALUES(?,?,?,?,?,?)");
  while ($have++ < $need) {
    $t = $titles[array_rand($titles)];
    $c = $cities[array_rand($cities)];
    $startInDays = rand(2, 45); 
    $startTime   = $times[array_rand($times)];
    $dur         = $durMin[array_rand($durMin)];

    $startDate = new DateTime("now");
    $startDate->modify("+{$startInDays} days");
    $startAt = $startDate->format("Y-m-d") . " " . $startTime;

    $endAt = (new DateTime($startAt))->modify("+{$dur} minutes")->format("Y-m-d H:i:s");
    $cap   = rand(20, 80);

    $desc  = "Automatikusan generált mintaesemény. Téma: {$t}. Helyszín: {$c}.";
    mysqli_stmt_bind_param($stmt, "sssssi", $t, $desc, $startAt, $endAt, $c, $cap);
    @mysqli_stmt_execute($stmt);
  }
  if ($stmt) mysqli_stmt_close($stmt);
}


seed_upcoming_events($adb, 12);


$isLogged = isset($_SESSION['uid']);
$uid = $isLogged ? (int)$_SESSION['uid'] : 0;

$sql = "SELECT e.id, e.title, e.description, e.start_at, e.end_at, e.cities, e.capacity,
               (SELECT COUNT(*) FROM event_registrations r WHERE r.event_id = e.id) AS reg_cnt" .
       ($isLogged ? ",
               EXISTS(SELECT 1 FROM event_registrations r2 WHERE r2.event_id=e.id AND r2.user_id={$uid}) AS is_registered" : " , 0 AS is_registered") .
       " FROM events e
         WHERE e.start_at >= NOW()
         ORDER BY e.start_at ASC
         LIMIT 6";

$res = mysqli_query($adb, $sql);
$out = [];
while ($res && ($r = mysqli_fetch_assoc($res))) {
  $r['is_registered'] = (int)$r['is_registered'];
  $r['reg_cnt']       = (int)$r['reg_cnt'];
  $r['capacity']      = (int)$r['capacity'];
  $out[] = $r;
}

echo json_encode([
  'ok'      => true,
  'events'  => $out,
  'logged'  => $isLogged ? 1 : 0,
  'now'     => date('Y-m-d H:i:s')
], JSON_UNESCAPED_UNICODE);
