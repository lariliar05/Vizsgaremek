<?php
if (session_status()===PHP_SESSION_NONE) session_start();
if (!isset($_SESSION['uid'])) { http_response_code(401); exit("login-required"); }

require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");

$eventId = (int)($_POST['event_id'] ?? 0);
$uid     = (int)$_SESSION['uid'];
if ($eventId<=0) { http_response_code(400); exit("bad-event"); }

// esemény + férőhely ellenőrzés (jövőben legyen)
$q = mysqli_query($adb, "SELECT id, capacity, start_at FROM events WHERE id={$eventId} LIMIT 1");
$ev = $q ? mysqli_fetch_assoc($q) : null;
if (!$ev) { http_response_code(404); exit("not-found"); }

if (strtotime($ev['start_at']) <= time()) { http_response_code(409); exit("already-started"); }

$cap = (int)$ev['capacity'];
$cntQ= mysqli_query($adb, "SELECT COUNT(*) c FROM event_registrations WHERE event_id={$eventId}");
$reg = $cntQ ? (int)mysqli_fetch_assoc($cntQ)['c'] : 0;
if ($reg >= $cap) { http_response_code(409); exit("full"); }

// upsert-szerű (dupla ne legyen)
$stmt = mysqli_prepare($adb, "INSERT IGNORE INTO event_registrations(event_id,user_id) VALUES(?,?)");
mysqli_stmt_bind_param($stmt,"ii",$eventId,$uid);
$ok = $stmt && mysqli_stmt_execute($stmt);
if ($stmt) mysqli_stmt_close($stmt);

echo $ok ? "ok" : "fail";
