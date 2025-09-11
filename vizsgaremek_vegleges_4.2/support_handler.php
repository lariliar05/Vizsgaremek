<?php
session_start();
include("kapcsolat.php");

// Ellenőrizni, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['uid'])) {
    echo "<script>alert('Először jelentkez be!')</script>";
}else{
    $input = $_POST['supportMessage'];
    if (!isset($input) || trim($input) === '') {
        echo "<script>alert('Nem lehet üres a üzenet!')</script>";
    }else{
        $uid = $_SESSION['uid'];
        $sszoveg = mysqli_real_escape_string($adb, $input);

        // Üzenet mentése az adatbázisba
        $query = "INSERT INTO support (uid, sszoveg, sstatusz) VALUES ('$uid', '$sszoveg', 1)";
        if (mysqli_query($adb, $query)) {
            echo "<script>alert('Sikeresen volt a üzenet küldés!')</script>";
        } else {
            echo "<script>alert('Sikertelen volt a üzenet küldés!')</script>";
        }
    }
    echo "<script>parent.location.href=parent.location.href</script>";
}
?>
