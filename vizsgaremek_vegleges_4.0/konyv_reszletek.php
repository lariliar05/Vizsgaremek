<?php
include("kapcsolat.php");
if (isset($_SESSION['uid'])) {
    $listak = mysqli_query($adb , "SELECT * FROM klista WHERE uid = $_SESSION[uid] AND kid = $_GET[id]");
    $lista = mysqli_fetch_array($listak, MYSQLI_ASSOC);
}else{
    $lista = null;
}

$url = 'https://bookli.zdt.hu/api.php?id=' . urlencode($_GET["id"]);
$response = file_get_contents($url);
$data = json_decode($response, true);

if (isset($data['error'])) {
    echo "Error: " . $data['error'];
    return;
}

$velemenyek = mysqli_query($adb , "SELECT * FROM ertekelesek INNER JOIN user ON ertekelesek.uid = user.uid WHERE kid = $_GET[id] AND ertekelesek.status = 'a'");
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title><?php echo htmlspecialchars($data['cim'] ?? 'N/A'); ?></title>
<style>
    textarea {
    width: 100%; /* 100%-os szélesség */
    max-width: 100%; /* Ne lépje túl a konténer szélességét */
    height: 120px; /* Fix magasság */
    padding: 10px;
    margin-top: 10px;
    border-radius: 5px;
    border: none;
    font-size: 16px;
    box-sizing: border-box; /* A padding is beletartozik a szélességbe */
    }

    button {
        color:white;
        background-color: #ff6b6b;
        font-weight:bold;
        width: 100%; /* 100%-os szélesség a gombnak is */
        max-width: 100%; /* Ne lépje túl a konténer szélességét */
    }
    button:hover{
        background-color: red;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #1d1f21;
        color: #e0e0e0;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    .book-details-container {
        margin: auto;
        display: flex;
        flex-direction: column;
        background-color: #2a2c2f;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
        width: 90%;
        max-width: 800px;
        margin-top: 20px;
    }

    .book-info-container {
            display: flex;
            flex-wrap: wrap;
    }

    .book-cover {
            max-width: 200px;
            height: auto;
            max-height: 200px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .book-info {
            margin-left: 20px;
            flex: 1;
    }

    .book-title {
            color: #ff6b6b;
            font-size: 28px;
            margin-bottom: 10px;
    }

    .book-detail {
            font-size: 16px;
            margin-bottom: 5px;
    }

    .book-price {
            margin-top: 10px;
            font-size: 20px;
            font-weight: bold;
            color: #a3e635;
    }
    .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
    }
    .actions button {
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
    }
    .actions button:hover {
            background-color: #e65a5a;
    }
    .rating-section {
            margin-top: 30px;
            background-color: #1f2123;
            padding: 20px;
            border-radius: 8px;
    }
    .rating-section h3 {
            color: #e0e0e0;
    }
    .rating-stars {
            display: flex;
            gap: 5px;
            cursor: pointer;
    }
    .rating-stars span {
            font-size: 30px;
            color: #888;
            transition: color 0.3s;
    }
    .rating-stars span:hover,
    .rating-stars span.active {
            color: #ff6b6b;
    }
    textarea, button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
            border: none;
            font-size: 16px;
    }
    .reviews-section {
            margin-top: 30px;
            padding: 20px;
            background-color: #1f2123;
            border-radius: 8px;
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
    hr {
            border: none;
            border-top: 1px solid #444;
            margin: 10px 0;
    }


</style>
</head>
<body>
    <div class="book-details-container">
    <div class="book-info-container">
            <img src="<?php echo htmlspecialchars($data['borito'] ?? 'nincs_kep.jpeg'); ?>" alt="<?php echo htmlspecialchars($konyv['kcim'] ?? 'N/A'); ?>" class="book-cover">
            <div class="book-info">
                <div class="book-title"><?php echo htmlspecialchars($data['cim'] ?? 'N/A'); ?></div>
                <div class="book-detail"><strong>Szerző:</strong> <?php echo htmlspecialchars($data['iro'] ?? 'Ismeretlen szerző'); ?></div>
                <div class="book-detail"><strong>Oldalszám:</strong> <?php echo htmlspecialchars($data['oldal'] ?? 'N/A'); ?></div>
                <div class="book-detail"><strong>Műfajok:</strong> <?php echo htmlspecialchars($data['mufaj'] ?? 'N/A'); ?></div>
                <div class="book-detail"><strong>Kiadás dátuma:</strong> <?php echo htmlspecialchars($data['kdatum'] ?? 'N/A'); ?></div>
                <div class="book-detail"><strong>Kiadó:</strong> <?php echo htmlspecialchars($data['kiado'] ?? 'N/A'); ?></div>
                <div class="book-detail"><strong>Leírás:</strong> <?php echo htmlspecialchars($data['leiras'] ?? 'N/A');?></div>
            </div>
        </div>

        <div class="actions">
            <form action="konyv_reszlet_ir.php" method="post" target="kisablak">
            <div class="upd">
                <?php
                    echo'<div class="stat">';
                    echo'Statusz:
                        <select name="krate" id="krate">';
                            if ($lista["status"]==1) {
                                echo'
                                    <option value="1" selected>reading</option>
                                    <option value="2">completed</option>
                                    <option value="3">plan to read</option>
                                    <option value="4">on hold</option>
                                    <option value="5">dropped</option>';
                            }elseif ($lista["status"]==2) {
                                echo' 
                                    <option value="1">reading</option>
                                    <option value="2" selected>completed</option>
                                    <option value="3">plan to read</option>
                                    <option value="4">on hold</option>
                                    <option value="5">dropped</option>';
                            }elseif ($lista["status"]==3) {
                                echo' 
                                    <option value="1">reading</option>
                                    <option value="2">completed</option>
                                    <option value="3" selected>plan to read</option>
                                    <option value="4">on hold</option>
                                    <option value="5">dropped</option>';
                            }elseif ($lista["status"]==4) {
                                echo' 
                                    <option value="1">reading</option>
                                    <option value="2">completed</option>
                                    <option value="3">plan to read</option>
                                    <option value="4" selected>on hold</option>
                                    <option value="5">dropped</option>';
                            }elseif ($lista["status"]==5) {
                                echo' 
                                    <option value="1">reading</option>
                                    <option value="2">completed</option>
                                    <option value="3">plan to read</option>
                                    <option value="4">on hold</option>
                                    <option value="5" selected>dropped</option>';
                            }else{
                                echo'
                                    <option value="0" selected>Select</option>
                                    <option value="1">reading</option>
                                    <option value="2">completed</option>
                                    <option value="3">plan to read</option>
                                    <option value="4">on hold</option>
                                    <option value="5">dropped</option>';
                            }
                        echo'</select>';
                    echo'</div>';
                    echo'<div class="rate">';
                    echo'Értékelés:
                        <select name="ertek" id="ertek">';
                            if ($lista["ertek"]==1) {
                                echo'
                                    <option value="5">nagyon jó</option>
                                    <option value="4">jó</option>
                                    <option value="3">közepes</option>
                                    <option value="2">rossz</option>
                                    <option value="1" selected>nagyon rossz</option>';
                            }elseif ($lista["ertek"]==2) {
                                echo' 
                                    <option value="5">nagyon jó</option>
                                    <option value="4">jó</option>
                                    <option value="3">közepes</option>
                                    <option value="2" selected>rossz</option>
                                    <option value="1">nagyon rossz</option>';
                            }elseif ($lista["ertek"]==3) {
                                echo' 
                                    <option value="5">nagyon jó</option>
                                    <option value="4">jó</option>
                                    <option value="3" selected>közepes</option>
                                    <option value="2">rossz</option>
                                    <option value="1">nagyon rossz</option>';
                            }elseif ($lista["ertek"]==4) {
                                echo' 
                                    <option value="5">nagyon jó</option>
                                    <option value="4" selected>jó</option>
                                    <option value="3">közepes</option>
                                    <option value="2">rossz</option>
                                    <option value="1">nagyon rossz</option>';
                            }elseif ($lista["ertek"]==5) {
                                echo' 
                                    <option value="5" selected>nagyon jó</option>
                                    <option value="4">jó</option>
                                    <option value="3">közepes</option>
                                    <option value="2">rossz</option>
                                    <option value="1">nagyon rossz</option>';
                            }else{
                                echo'
                                    <option value="0" selected></option>
                                    <option value="5">nagyon jó</option>
                                    <option value="4">jó</option>
                                    <option value="3">közepes</option>
                                    <option value="2">rossz</option>
                                    <option value="1">nagyon rossz</option>';
                            }
                        echo'</select>';     
                    echo'</div>';
                    echo'<div class="page">';
                        if (isset($lista["oldal"])) {
                            echo'Oldal:<input type="number" name="old" id="old" value="'.$lista["oldal"].'" max="'.$data["oldal"].'">/<span>'.$data["oldal"].'</span>';
                        }else{
                            echo'Oldal:<input type="number" name="old" id="old" value="0" max="'.$data["oldal"].'">/<span>'.$data["oldal"].'</span>';
                        }
                    echo'</div>';
                    echo' <input type="hidden" name="id" id="id" value='.$data['id'].'>';
                    if (!empty($lista)) {
                        echo'<input type="submit" value="frissités">';
                    }else{
                        echo'<input type="submit" value="add hozzá a listámhoz">';
                    }
                ?>
            </div>
            </form>

            <form action="add_to_cart.php" target="kisablak" method="post">
                <input type="submit" value="vásárlás">
                <?php echo' <input type="hidden" name="id" id="id" value='.$data['id'].'>';?>
            </form>
        </div>
            

        <div class="rating-section">
            <h3>Értékelje a könyvet</h3>
            <?php if (isset($error)) echo "<p style='color: red;'>$error</p>"; ?>
            <form action="konyv_velemeny_ir.php" method="POST" target="kisablak">
                <?php echo' <input type="hidden" name="id" id="id" value='.$data['id'].'>';?>
                <textarea name="comment" id="comment" rows="4" placeholder="Írja meg a véleményét..."></textarea>
                <input type="submit" value="Küldés"></input>
            </form>
        </div>

    <div class="reviews-section">
    <h3>Felhasználói értékelések</h3>
    <?php 
        if(!isset($velemeny)){
            echo 'Még nincsenek hozzászolás ehhez a könyvhöz.';
        }
        else{
            $ab = mysqli_query($adb , "SELECT * FROM ertekelesek INNER JOIN user ON ertekelesek.uid = user.uid WHERE kid = $_GET[id] AND ertekelesek.status = 'a'");
            while ($a = mysqli_fetch_array($ab, MYSQLI_ASSOC)) {
                echo'<div class="review">';
                if (isset($_SESSION['uid'])) {
                    echo'<a href="./?p=adatlapom&id='.$a["uid"].' " style="text-decoration: none; color: inherit;"><strong>'.htmlspecialchars($a["username"]).'</strong></a>';
                }else{
                    echo'<a href="./?p=login " style="text-decoration: none; color: inherit;"><strong>'.htmlspecialchars($a["username"]).'</strong></a>';
                }
                    
                    echo'<p>'. htmlspecialchars($a["eszoveg"]) .'</p>';
                    echo'<small>'. htmlspecialchars($a["edatum"]) .'</small>';
                echo'</div>';
            }
        }
    ?>
</div>
</body>
</html>
