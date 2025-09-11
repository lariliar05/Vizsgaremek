<?php
session_start();
include('kapcsolat.php');

$pw = md5($_POST["pw"]);
$jelszo = mysqli_fetch_array(mysqli_query($adb,"SELECT * FROM user WHERE uid = '$_POST[uid]'"));
if ($_POST['username']=='') {
    die("<script>alert('Nem megfelelő a felhasználó nevedet!')</script>");
}
if (!filter_var($_POST['email'],FILTER_VALIDATE_EMAIL)) {
    die("<script>alert('Nem megfelelő email-cím!')</script>");
}
if ($_POST['pw']=='') {
    die("<script>alert('jelszó kell a modositáshoz')</script>");
}
if ($jelszo['upassword']!==$pw) {
    die("<script>alert('hibás jelszó')</script>");
}

mysqli_query($adb, "UPDATE user SET uemail = '$_POST[email]', username = '$_POST[username]' WHERE uid = '$_POST[uid]'");

$_SESSION['unick']=$_POST['user'];
print"<script>alert('Módositotuk adatait') </script>";
print"<script>parent.location.href=parent.location.href</script>";
mysqli_close($adb);
?>