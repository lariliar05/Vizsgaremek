<?php
    include("kapcsolat.php");
    $user = mysqli_fetch_array(mysqli_query($adb,"SELECT * FROM user WHERE uid ='$_SESSION[uid]'"));
    $profkep = !empty($user['uprofkepnev_eredetinev']) ? "./profilkepek/" . $user['uprofkepnev_eredetinev'] : "./profilkepek/picon2.png";
    
    $velemenyek = mysqli_query($adb , "SELECT * FROM ertekelesek WHERE uid = '$_SESSION[uid]' AND status = 'a'");
    if ($velemenyek) {
    $velemeny = mysqli_fetch_array($velemenyek, MYSQLI_ASSOC);
    }else{
    $velemeny = null;
    }
?>

<!DOCTYPE html>
<html lang="hu">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Adatmódosítás</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
    img{
        height: 200px;
        width: 200px;
    }
    body{
        background-color: #1d1f21;
        color: #e0e0e0;
    }
    .review {
            margin-bottom: 15px;
    }
    .review strong {
            color: #ff6b6b;
    }
    .review small {
            display: block;
            color: #aaa;
            margin-top: 5px;
    }
    .book-cover {
            max-width: 70px;
            height: auto;
            max-height: 100px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }
    .profile-container{
        border-radius: 50%;
    }
</style>
</head>
<body>
    <div class="text-container row">
        <form action="kep_modositas.php" method="post" enctype='multipart/form-data' class="col-4" target="kisablak">
            <h2>Fiók</h2>
            <div class="profile-container">
                <img src="<?= htmlspecialchars($profkep); ?>" alt="Profilkép">
            </div>
            <input type="file" name="pkep" id="pkep">
            <input type="submit" value="kép változtatása">
            <?php echo '<input type="hidden" name="uid" id="uid" value="'. $_SESSION["uid"]. '">';?>
        </form>

        <div class="col-8">
        <h3>Felhasználói értékelések</h3>
    <?php 
        if(!isset($velemeny)){
            echo 'Még nincsenek hozzászolás ehhez a könyvhöz.';
        }
        else{
            $ab = mysqli_query($adb , "SELECT * FROM ertekelesek INNER JOIN user ON ertekelesek.uid = user.uid INNER JOIN konyvek ON ertekelesek.kid = konyvek.konyvid WHERE ertekelesek.uid = '$_SESSION[uid]' AND ertekelesek.status = 'a'");
            while ($a = mysqli_fetch_array($ab, MYSQLI_ASSOC)) {
                echo'<div class="review">';
                    echo' <img src="'. htmlspecialchars($a["borito"]) .'" alt="boritó" class="book-cover">';
                    echo'<a href="./?p=konyv_lista&id='.$a["uid"].' " style="text-decoration: none; color: inherit;"><strong>'.htmlspecialchars($a["username"] ?? "Anonim").'</strong></a>';
                    echo'<p>'. htmlspecialchars($a["eszoveg"]) .'</p>';
                    echo'<small>'. htmlspecialchars($a["edatum"]) .'</small>';
                echo'</div>';
            }
        }
    ?>
        </div>
    </div>
</body>
</html>
