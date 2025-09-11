<?php

if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

$targetId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($targetId <= 0) {
  $_SESSION['flash'] = ["type"=>"err","msg"=>"Érvénytelen célpont."];
  header("Location: ./?p=adomanyozz"); exit;
}

if (!isset($_SESSION['uid'])) {
  $_SESSION['flash'] = ["type"=>"warn","msg"=>"Támogatni csak bejelentkezve lehet. Kérjük, jelentkezz be!"];
  header("Location: ./?p=adomanyozz"); exit;
}

$stmt = mysqli_prepare($adb, "SELECT donate_url FROM donation_targets WHERE id=? AND verified=1");
mysqli_stmt_bind_param($stmt, "i", $targetId);
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);
$row = mysqli_fetch_assoc($res);
mysqli_stmt_close($stmt);

if (!$row || empty($row['donate_url'])) {
  $_SESSION['flash'] = ["type"=>"err","msg"=>"A kiválasztott célpont nem elérhető."];
  header("Location: ./?p=adomanyozz"); exit;
}

$donateUrl = $row['donate_url'];

$uid = (int)$_SESSION['uid'];
$ip  = $_SERVER['REMOTE_ADDR'] ?? null;
$ua  = substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 250);

$stmt = mysqli_prepare($adb, "INSERT INTO donation_clicks (user_id, target_id, ip, user_agent) VALUES (?,?,?,?)");
if ($stmt) {
  mysqli_stmt_bind_param($stmt, "iiss", $uid, $targetId, $ip, $ua);
  mysqli_stmt_execute($stmt);
  mysqli_stmt_close($stmt);
}

header("Location: ".$donateUrl);
exit;
?>