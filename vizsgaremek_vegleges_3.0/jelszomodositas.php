<?php 
    include("kapcsolat.php");
    $user = mysqli_fetch_array(mysqli_query($adb,"SELECT * FROM user WHERE uid ='$_SESSION[uid]'"));
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jelszó Módosítása</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
        }
    </style>
</head>
<body>
    <div id="jelszo-mod">
        <form action="jelszomodositas_ir.php" method="post" target="kisablak">
            <h1>Jelszó Módosítása</h1>
            <div id="form-group">
                <label for="pw">Régi jelszó:</label>
                <input type="password" name="pw" id="pw" placeholder="Régi jelszó">
            </div>
            <div id="form-group">
                <label for="pw2">Új jelszó:</label>
                <input type="password" name="pw2" id="pw2" placeholder="Új jelszó">
            </div>

            <input type="submit" value="Jelszó módosítása">

            <?php echo'<input type="hidden" name="uid" value="'.$user['uid'].'">';?>
        </form>
    </div>
</body>
</html>
