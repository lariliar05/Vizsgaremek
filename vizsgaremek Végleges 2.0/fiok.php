<?php
    include("kapcsolat.php");
    if (isset($_GET['id']) && $_SESSION['uid']!=$_GET['id']) {
        $user = mysqli_fetch_array(mysqli_query($adb,"SELECT * FROM user WHERE uid ='$_GET[id]'"));
        $profkep = !empty($user['uprofkepnev_eredetinev']) ? "./profilkepek/" . $user['uprofkepnev_eredetinev'] : "./profilkepek/picon2.png";
        
        $velemenyek = mysqli_query($adb , "SELECT * FROM ertekelesek WHERE uid = '$_GET[id]' AND status = 'a'");
        if ($velemenyek) {
            $velemeny = mysqli_fetch_array($velemenyek, MYSQLI_ASSOC);
        }else{
            $velemeny = null;
        }

        $konyvek = mysqli_query($adb,"SELECT * FROM `konyvek` INNER JOIN klista ON konyvek.konyvid = klista.kid WHERE klista.uid ='$_GET[id]' LIMIT 10");
    }else {
        $user = mysqli_fetch_array(mysqli_query($adb,"SELECT * FROM user WHERE uid ='$_SESSION[uid]'"));
        $profkep = !empty($user['uprofkepnev_eredetinev']) ? "./profilkepek/" . $user['uprofkepnev_eredetinev'] : "./profilkepek/picon2.png";
        
        $velemenyek = mysqli_query($adb , "SELECT * FROM ertekelesek WHERE uid = '$_SESSION[uid]' AND status = 'a'");
        if ($velemenyek) {
            $velemeny = mysqli_fetch_array($velemenyek, MYSQLI_ASSOC);
        }else{
            $velemeny = null;
        }

        $konyvek = mysqli_query($adb,"SELECT * FROM `konyvek` INNER JOIN klista ON konyvek.konyvid = klista.kid WHERE klista.uid ='$_SESSION[uid]' LIMIT 10");
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
    body{
        background-color: #1d1f21;
        color: #e0e0e0;
    }
</style>
</head>
<body>
    <div class="text-container row">
        <div class="col-4">
        <form action="kep_modositas.php" method="post" enctype='multipart/form-data'  target="kisablak">
            <h2>Fiók</h2>
            <div class="profile-container">
                <img id="fiokkep" src="<?= htmlspecialchars($profkep); ?>" alt="Profilkép">
            </div>
            <?php
                if (!isset($_GET['id'])){
                    echo'<input type="file" name="pkep" id="pkep">';
                    echo'<input type="submit" value="kép változtatása">';
                    echo'<input type="hidden" name="uid" id="uid" value="'. $_SESSION["uid"]. '">';
                    echo'<input type="button" value="felhasználói adatok modositása" onclick="location.href=\'./?p=adatmodositas\'">';
                }
            ?>
        </form>
        
        </div>

        <div class="col-8">
        <h3>Felhasználó listája</h3>
        <?php
        if ($konyvek != null){
            if (mysqli_num_rows($konyvek) > 0) {
                while ($konyv = mysqli_fetch_array($konyvek, MYSQLI_ASSOC)) {
                    $ertek = mysqli_fetch_array(mysqli_query($adb,"SELECT ROUND(AVG(ertek),1) AS avgertek FROM `klista` WHERE kid ='$konyv[konyvid]'") ,MYSQLI_ASSOC);
                    echo "<a href='./?p=konyvreszletek&id=".$konyv['konyvid']."' style='text-decoration: none; color: inherit;'>";
                    echo'<div class="book-item">';

                    echo'<img id="fiok-book-cover" src=" '.htmlspecialchars($konyv["borito"]).'" alt ="hiba">';

                    echo'<div class="book-details">';
                    echo'    <div class="book-title">'.htmlspecialchars($konyv['kcim']) .'</div>';
                    echo'    <div class="book-author">'. ($konyv['iro'] != NULL ? htmlspecialchars($konyv['iro']) : 'nem ismert/nem talált').'</div>';
                    echo'    <div class="book-score">'. htmlspecialchars($ertek['avgertek']).' </div>';
                    echo'</div>';
                    echo'</div>';
                    echo'</a>';
                }
            }else{
                echo "nincs találat / nincs még felvéve könyv";
            }
        }else{
            echo "adatbázis hiba";
        }
        ?>
        <h3>Felhasználó hozzászólásai</h3>
    <?php 
        if(!isset($velemeny)){
            echo 'Még nincsenek hozzászólásai a fióknak.';
        }
        else{
            if (isset($_GET['id']) && $_SESSION['uid']!=$_GET['id']) {
                $ab = mysqli_query($adb , "SELECT * FROM ertekelesek INNER JOIN user ON ertekelesek.uid = user.uid INNER JOIN konyvek ON ertekelesek.kid = konyvek.konyvid WHERE ertekelesek.uid = '$_GET[id]' AND ertekelesek.status = 'a' ORDER BY edatum DESC LIMIT 10 ");
            }else {
                $ab = mysqli_query($adb , "SELECT * FROM ertekelesek INNER JOIN user ON ertekelesek.uid = user.uid INNER JOIN konyvek ON ertekelesek.kid = konyvek.konyvid WHERE ertekelesek.uid = '$_SESSION[uid]' AND ertekelesek.status = 'a' ORDER BY edatum DESC LIMIT 10 ");
            }
            while ($a = mysqli_fetch_array($ab, MYSQLI_ASSOC)) {
                echo'<div class="review">';
                    echo'<a href="./?p=konyvreszletek&id='.$a["kid"].'" style="text-decoration: none; color: inherit;"> <img src="'. htmlspecialchars($a["borito"]) .'" alt="boritó" class="fiok-book-cover">';
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
