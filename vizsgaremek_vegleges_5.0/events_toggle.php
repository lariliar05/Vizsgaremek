<?php
if (session_status()===PHP_SESSION_NONE) session_start();
require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");

if (!isset($_SESSION['uid'])) { header("Location: ./?p=login"); exit; }

$uid    = (int)$_SESSION['uid'];
$eventId= isset($_POST['event_id']) ? (int)$_POST['event_id'] : 0;
$action = $_POST['action'] ?? '';
$page   = max(1, (int)($_POST['page'] ?? 1));

if ($eventId<=0 || !in_array($action, ['join','leave'], true)) {
  header("Location: ./?p=esemenyek&page=$page"); exit;
}

// esemény ellenőrzés
$stmt = mysqli_prepare($adb, "SELECT id, start_at, end_at, capacity, is_cancelled FROM events WHERE id=? LIMIT 1");
mysqli_stmt_bind_param($stmt,"i",$eventId);
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);
$e = $res ? mysqli_fetch_assoc($res) : null;
mysqli_stmt_close($stmt);

if (!$e || (int)$e['is_cancelled']===1) { header("Location: ./?p=esemenyek&page=$page"); exit; }

$now   = time();
$start = strtotime($e['start_at']);
$end   = strtotime($e['end_at']);

if ($action==='join') {
  // csak kezdés előtt lehet
  if ($now >= $start) { header("Location: ./?p=esemenyek&page=$page"); exit; }

  // kapacitás ellenőrzés
  $cap = is_null($e['capacity']) ? null : (int)$e['capacity'];
  if (!is_null($cap)) {
    $cRes = mysqli_query($adb, "SELECT COUNT(*) AS c FROM event_registrations WHERE event_id=".$eventId);
    $cur  = ($cRes && ($r=mysqli_fetch_assoc($cRes))) ? (int)$r['c'] : 0;
    if ($cur >= $cap) { header("Location: ./?p=esemenyek&page=$page"); exit; }
  }

  // beszúrás (idempotens az UNIQUE miatt)
  $stmt = mysqli_prepare($adb, "INSERT IGNORE INTO event_registrations (event_id, user_id) VALUES (?,?)");
  mysqli_stmt_bind_param($stmt,"ii",$eventId,$uid);
  mysqli_stmt_execute($stmt);
  mysqli_stmt_close($stmt);

} else { // leave
  // még kezdés előtt lehessen lemondani
  if ($now < $start) {
    $stmt = mysqli_prepare($adb, "DELETE FROM event_registrations WHERE event_id=? AND user_id=?");
    mysqli_stmt_bind_param($stmt,"ii",$eventId,$uid);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
  }
}

header("Location: ./?p=esemenyek&page=$page");
exit;
