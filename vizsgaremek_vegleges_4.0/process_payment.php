<?php
session_start();

if ($_POST['name'] == "") {
    die("<script> alert('Nem adtad meg a neved!') </script>");
}

if ($_POST['card_number'] == "") {
    die("<script> alert('Nem adtad meg az kártyaszámod!') </script>");
}

if ($_POST['expiry'] == "") {
    die("<script> alert('Nem adtad meg a lejárati dátumot!') </script>");
}

if ($_POST['cvv'] == "") {
    die("<script> alert('Nem adtad meg a cvv!') </script>");
}

include('kapcsolat.php');

$uid = $_SESSION['uid'];
$konyvek = mysqli_query($adb, "SELECT * FROM kosar WHERE uid = '$uid' AND statusz = 1");

if (mysqli_num_rows($konyvek) > 0) {
    while ($konyv = mysqli_fetch_array($konyvek, MYSQLI_ASSOC)) {
        mysqli_query($adb, "INSERT INTO `vasarlas`(`vid`, `koid`, `nev`, `cardnumber`, `ldatum`, `cvv`, `statusz`, `datum`) 
        VALUES (null, '{$konyv['koid']}', '{$_POST['name']}', '{$_POST['card_number']}', '{$_POST['expiry']}', '{$_POST['cvv']}', 1, NULL)");

        $query = "UPDATE kosar SET `statusz`= 0 WHERE uid = ? AND koid = ? AND statusz = 1 LIMIT 1";
        $stmt = mysqli_prepare($adb, $query);
        mysqli_stmt_bind_param($stmt, "is", $uid, $konyv['koid']);
        mysqli_stmt_execute($stmt);
    }
    //print "<script> alert('Sikeres vásárlás!') </script>";
    //print "<script> parent.location.href = './?p=konyvek' </script>" ;
} else {
    die("<script> alert('Üres a kosár!') </script>");
}

?>