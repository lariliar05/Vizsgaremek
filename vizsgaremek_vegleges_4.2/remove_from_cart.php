<?php
session_start();
require_once 'kapcsolat.php';

if (!isset($_SESSION['uid'])) {
    echo "<script> alert('Jelentkezz be először!')</script>";
}else{
    if (!$_POST['id']) {
        echo  "<script> alert('nem létezik ilyen könyv!')</script>";
    }else {
        echo'lefut';
        $uid = $_SESSION['uid'];
        $query = "UPDATE kosar SET `statusz`= 0 WHERE uid = ? AND kid = ? AND statusz = 1 LIMIT 1";
        $stmt = mysqli_prepare($adb, $query);
        mysqli_stmt_bind_param($stmt, "is", $uid, $_POST['id']);
        mysqli_stmt_execute($stmt);
    }
}
print "<script> parent.location.href = parent.location.href </script>" ;
?>
