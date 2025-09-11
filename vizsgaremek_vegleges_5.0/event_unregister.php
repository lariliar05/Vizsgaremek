<?php
if (session_status()===PHP_SESSION_NONE) session_start();
if (!isset($_SESSION['uid'])) { http_response_code(401); exit("login-required"); }

require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");

$eventId = (int)($_POST['event_id'] ?? 0);
$uid     = (int)$_SESSION['uid'];
if ($eventId<=0) { http_response_code(400); exit("bad-event"); }

$stmt = mysqli_prepare($adb, "DELETE FROM event_registrations WHERE event_id=? AND user_id=?");
mysqli_stmt_bind_param($stmt,"ii",$eventId,$uid);
$ok = $stmt && mysqli_stmt_execute($stmt);
if ($stmt) mysqli_stmt_close($stmt);

echo $ok ? "ok" : "fail";
