<?php
    $adb = mysqli_connect("localhost", "root", "", "kl_registration");

    if (!$adb) {
        die("Hiba az adatbázis-kapcsolatnál: " . mysqli_connect_error());
    }
?>
