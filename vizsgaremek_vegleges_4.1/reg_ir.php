<?php
if($_POST['username'] =="" ) {
    print "<script> alert('Nem adtad meg a felhasználóneved!')</script>";
    die("<script> parent.location.href = './?p=reg' </script>");
}

if($_POST['email']=="" ) {
    print "<script> alert('Nem adtad meg az email címed!')</script>";
    die("<script> parent.location.href = './?p=reg' </script>");
}

if($_POST['password']=="" ) {
    print "<script> alert('Nem adtad meg a jelszavad!') </script>";
    die("<script> parent.location.href = './?p=reg' </script>");
}
if ($_POST['checkbox']==false) {
    print "<script> alert('Nem fogadtad el a feltételeket!') </script>";
    die("<script> parent.location.href = './?p=reg' </script>");
}
include("kapcsolat.php");

$upw = md5($_POST['password']);
mysqli_query($adb , "
INSERT INTO user ( uid, username, uemail, upassword, udatum, uip, usession, ustatusz, ukomment) 
VALUES           (NULL, '$_POST[username]', '$_POST[email]', '$upw',  NOW(), '',  '', 'a', '')
");
mysqli_close($adb);
print "<script> alert('sikeres regisztárás')</script>";
print "<script> parent.location.href = './?p=login' </script>";
?>
