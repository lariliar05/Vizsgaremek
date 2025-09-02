<?php
    include("kapcsolat.php");
    $user = mysqli_fetch_array(mysqli_query($adb, "SELECT * FROM user WHERE uid ='$_SESSION[uid]'"));
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adatmódosítás</title>
</head>
<body>
    <div id='ad_mod'>
    <form action='adatlap_ir.php' method='post' target='kisablak'>
        <h2>Adatok Módosítása</h2>

        <label for="username">Felhasználónév:</label>
        <input type="text" name="username" id="username" value="<?= htmlspecialchars($user['username']); ?>">

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" value="<?= htmlspecialchars($user['uemail']); ?>">

        <label for="pw">Jelszó:</label>
        <input type="password" name="pw" id="pw" placeholder="*****">

        <input type="submit" value="Adatok módosítása">
        <input type="button" id="jmodositas" name="jmodositas" value="Jelszó módosítása" onclick='location.href="./?p=jelszomodositas"'>
        <input type="hidden" name="uid" value="<?= htmlspecialchars($user['uid']); ?>">
    </form>
    </div>
</body>
</html>