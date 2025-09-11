<?php
if (session_status() === PHP_SESSION_NONE) session_start();
require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");

$username = trim($_POST['username'] ?? '');
$email    = trim($_POST['email'] ?? '');
$pwPlain  = $_POST['password'] ?? '';
$is_org   = isset($_POST['is_org']) ? 1 : 0;
$org_name = trim($_POST['org_name'] ?? '');

if ($username==='' || $email==='' || $pwPlain==='' || !$is_org || $org_name==='') {
  die("<script>alert('Minden mező kötelező (szervezeti)!');location.href='./?p=reg_org';</script>");
}

$ck = mysqli_prepare($adb, "SELECT 1 FROM user WHERE uemail=? OR username=? LIMIT 1");
mysqli_stmt_bind_param($ck, "ss", $email, $username);
mysqli_stmt_execute($ck);
mysqli_stmt_store_result($ck);
if (mysqli_stmt_num_rows($ck)>0) {
  mysqli_stmt_close($ck);
  die("<script>alert('Már létező felhasználó vagy email!');location.href='./?p=reg_org';</script>");
}
mysqli_stmt_close($ck);

$pwHash = md5($pwPlain);
$now  = date('Y-m-d H:i:s');
$ip   = $_SERVER['REMOTE_ADDR'] ?? '';
$sess = substr(session_id(),0,8);

$stmt = mysqli_prepare($adb, "INSERT INTO user
  (username,uemail,upassword,is_org,org_name,udatum,uip,usession,ustatusz,ukomment)
  VALUES (?,?,?,?,?,?,?,?, 'a', '')");
mysqli_stmt_bind_param($stmt, "sssissss", $username, $email, $pwHash, $is_org, $org_name, $now, $ip, $sess);
$ok = $stmt && mysqli_stmt_execute($stmt);
if ($stmt) mysqli_stmt_close($stmt);

if (!$ok) {
  die("<script>alert('Hiba a mentésnél: ".addslashes(mysqli_error($adb))."');location.href='./?p=reg_org';</script>");
}

echo "<script>alert('Szervezeti regisztráció sikeres! Most jelentkezz be.');location.href='./?p=login';</script>";
