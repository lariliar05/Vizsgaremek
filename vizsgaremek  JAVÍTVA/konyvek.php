<?php
    include("kapcsolat.php");
    $konyvek = mysqli_query($adb , "SELECT * FROM konyvek WHERE statusz = 'a'");
?>
<!DOCTYPE html>
<html lang="hu">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Könyvek</title>
<style>
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
    .main-content {
        text-align: center;
        margin-top: 5px;
        padding: 0 20px;
        flex: 1;
    }
    .book-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 15px;
        margin-top: 20px;
    }
    .book-card {
        background-color: #2a2c2f;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        text-align: center;
        padding: 10px;
        transition: transform 0.2s, box-shadow 0.2s;
        cursor: pointer;
    }
    .book-card:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
    }
    .book-cover {
        width: 100%;
        height: auto;
        max-height: 180px;
        object-fit: cover;
        border-radius: 4px;
    }
    .book-title {
        color: #B21031;
        font-size: 16px;
        margin: 8px 0 4px;
        font-weight: bold;
    }
    .book-author {
        color: #fd7015;
        font-size: 13px;
        margin-bottom: 4px;
    }
    .book-subtitle {
        color: orange;
        font-size: 14px;
        font-weight: bold;
        margin-top: 6px;
    }
</style>
</head>
<body>
<div class="main-content">
    <form action="" method="post">
        <input type="text" name="kereses" id="kereses" placeholder="pl: cím, szerző ...">
        <input type="submit" value="Keresés">
    </form>
    <div class="book-grid">
    <?php
        if ($konyvek) {
            if (isset($_POST['kereses']) || !empty($_POST['kereses'])) {
                $kereses = mysqli_query($adb , "SELECT * FROM konyvek WHERE kcim LIKE '%$_POST[kereses]%' OR mufaj LIKE '%$_POST[kereses]%' AND statusz = 'a'");
                if ($kereses) {
                    if (mysqli_num_rows($kereses) > 0) {
                        while ($konyv = mysqli_fetch_array($kereses, MYSQLI_ASSOC)) {
                            echo "<a href='./?p=konyvreszletek&id=".$konyv['konyvid']."' style='text-decoration: none; color: inherit;'>";
                                echo "<div class='book-card'>";
                                    echo "<img src='" . htmlspecialchars($konyv['borito']) . "' alt='" . htmlspecialchars($konyv['kcim']) . "' class='book-cover'>";
                                    echo "<div class='book-title'>" . htmlspecialchars($konyv['kcim']) . "</div>";
                                    echo "<div class='book-author'>" . ($konyv['iro'] != NULL ? htmlspecialchars($konyv['iro']) : 'nem ismert/nem talált') . "</div>";
                                    echo "<div class='book-subtitle'>" . htmlspecialchars($konyv['alcim']) . "</div>";
                                echo "</div>";
                            echo "</a>";
                        }
                    }else{
                        echo "nincs találat";
                    }
                }else {
                    echo "valami félre ment a keresés közben";
                }
            }
            elseif(mysqli_num_rows($konyvek) > 0) {
                while ($konyv = mysqli_fetch_array($konyvek, MYSQLI_ASSOC)) {
                    echo "<a href='./?p=konyvreszletek&id=".$konyv['konyvid']."' style='text-decoration: none; color: inherit;'>";
                        echo "<div class='book-card'>";
                            echo "<img src='" . htmlspecialchars($konyv['borito']) . "' alt='" . htmlspecialchars($konyv['kcim']) . "' class='book-cover'>";
                            echo "<div class='book-title'>" . htmlspecialchars($konyv['kcim']) . "</div>";
                            echo "<div class='book-author'>" . ($konyv['iro'] != NULL ? htmlspecialchars($konyv['iro']) : 'nem ismert/nem talált') . "</div>";
                            echo "<div class='book-subtitle'>" . htmlspecialchars($konyv['alcim']) . "</div>";
                        echo "</div>";
                    echo "</a>";
                }
            }else{
                echo "nincsenek könyvek az adatbázisban";
            }
        } else {
            echo "valami félre ment az adatbázisban";
        }
        ?>
    </div>
</div>
</body>
</html>
