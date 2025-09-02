<?php
session_start();
include("kapcsolat.php");

$pw = md5($_POST["pw"]);
$pw2 = md5($_POST["pw2"]);
$regijelszo = mysqli_fetch_array(mysqli_query($adb,"SELECT * FROM user WHERE uid ='$_SESSION[uid]'"));

if($_POST['pw']==""){
    die("<script> alert('add meg a régi jelszavadat!')</script>");
} 
if($_POST['pw2']==""){
    die("<script> alert('add meg a új jelszavadat!')</script>");
}
if($pw!==$regijelszo["upassword"]){
    die("<script> alert('nem egyezik a régi jelszó')</script>");
} 

mysqli_query($adb , " UPDATE user SET upassword = '$pw2' WHERE uid = '$_POST[uid]'");
echo "<script>alert('Jelszavát sikeresen módosítottuk')</script>";
echo "<script>parent.location.href=parent.location.href</script>";
mysqli_close($adb);

?>