<?php
session_start();
include('kapcsolat.php');

if (!isset($_SESSION['uid'])) {
    print "<script> alert('Jelentkez be!')</script>" ;
}else{
    $konyvek = mysqli_query($adb , "SELECT * FROM kosar WHERE uid = '$_SESSION[uid]' AND statusz = '1' AND kid = '$_POST[id]'");
    if (mysqli_num_rows($konyvek) > 0) {
        print "<script> alert('Már a kosárban van a könyv!')</script>" ;
    }else{
        mysqli_query($adb, "INSERT INTO `kosar` (`koid`, `uid`, `kid`, `statusz`) 
        VALUES (  NULL, $_SESSION[uid], $_POST[id], 1)");
    }
}
print"<script>parent.location.href=parent.location.href</script>";
?>
