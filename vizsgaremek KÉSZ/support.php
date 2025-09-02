<?php
    include("kapcsolat.php");
    $kerdesek = mysqli_query($adb , "SELECT * FROM support ORDER BY sdatum DESC");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div id="tartalom">
        <h2>Support</h2>
        <div class="writing-section">
            <form action="support_handler.php" target="kisablak" method="post">
                <textarea name="supportMessage" id="supportMessage" placeholder="Írja le a kérdését..." rows="5" cols="30"></textarea>
                <input type="submit" value="Küldés">
            </form>
        </div>

        <div class="answer-section">
        <h3>Előző kérdéseid</h3>
    
        <?php
            if ($kerdesek) {
                if (mysqli_num_rows($kerdesek) > 0) {
                    while ($kerdes = mysqli_fetch_array($kerdesek, MYSQLI_ASSOC)) {
                        if ($kerdes['sstatusz'] == 1) {
                            $stat = "aktiv";
                            echo "<div class='support-card'>";
                                echo "<div class='username'>Te:</div>";
                                echo "<div class='question'>" . htmlspecialchars($kerdes['sszoveg']) . "</div>";
                                echo "<div class='status'>" . htmlspecialchars($stat) . "</div>";
                                echo "<div class='time'>" . htmlspecialchars($kerdes['sdatum']) . "</div>";
                            echo "</div>";
                        }else {
                            $stat = "megválaszolt";
                            echo "<div class='support-card'>";
                                echo "<div class='username'>Te:</div>";
                                echo "<div class='question'>" . htmlspecialchars($kerdes['sszoveg']) . "</div>";
                                echo "<div class='status'>" . htmlspecialchars($stat) . "</div>";
                                echo "<div class='time'>" . htmlspecialchars($kerdes['sdatum']) . "</div>";

                                echo "<br>";

                                echo "<div class='username'>Wallenc:</div>";
                                echo "<div class='answer'>" . htmlspecialchars($kerdes['svalasz']) . "</div>";
                                echo "<div class='ctime'>" . htmlspecialchars($kerdes['slezar']) . "</div>";
                            echo "</div>";
                        }
                        echo "<br>";
                    }
                }else {
                    echo 'Még nincs feltet kérdésed';
                }
            }else {
                echo 'Valami félre ment a adatbázisban';
            }
        ?>
        </div>
    </div>
</body>
</html>