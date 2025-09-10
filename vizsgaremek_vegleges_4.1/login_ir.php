<?php
session_start();
require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");

$email = $_POST["email"] ?? '';
$pw    = $_POST["pw"] ?? '';

if ($email==='' || $pw==='') {
  die("<script>alert('Hiányzó belépési adatok.');history.back();</script>");
}

$pwHash = md5($pw);

$stmt = mysqli_prepare($adb, "
  SELECT uid, username, is_org, org_name
  FROM user
  WHERE (uemail=? OR username=?) AND upassword=?
  LIMIT 1
");
mysqli_stmt_bind_param($stmt, "sss", $email, $email, $pwHash);
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);
$user = $res ? mysqli_fetch_assoc($res) : null;
mysqli_stmt_close($stmt);

if (!$user) {
  die("<script>alert('Hibás belépési adatok!');location.href='./?p=login';</script>");
}

$_SESSION['uid']       = (int)$user['uid'];
$_SESSION['username']  = $user['username'];
$_SESSION['is_org']    = (int)($user['is_org'] ?? 0);
$_SESSION['org_name']  = $user['org_name'] ?? null;

$logip   = $_SERVER['REMOTE_ADDR'] ?? '';
$logsess = substr(session_id(), 0, 8);
$uid     = (int)$_SESSION['uid'];

mysqli_query($adb, "INSERT INTO login (logid, logdate, logip, logsession, luid)
                    VALUES (NULL, NOW(), '".mysqli_real_escape_string($adb,$logip)."',
                                   '".mysqli_real_escape_string($adb,$logsess)."',
                                   $uid)");

echo "<script>parent.location.href='./?p=konyvek';</script>";
