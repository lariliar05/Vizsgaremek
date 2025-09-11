<?php
session_start();
include('kapcsolat.php'); // Adatbázis kapcsolat

if (isset($_SESSION['uid'])) {
    $query = mysqli_query($adb, "SELECT * FROM kosar INNER JOIN konyvek ON kosar.kid = konyvek.konyvid WHERE uid= '$_SESSION[uid]' AND kosar.statusz = 1");

    if (mysqli_num_rows($query) > 0) {
        while ($konyv = mysqli_fetch_array($query, MYSQLI_ASSOC)) {

            echo "<div class='cart-item' style='display: flex; align-items: center; gap: 10px;'>";
            echo "<a href='./?p=konyvreszletek&id=" .$konyv['konyvid']. "' style='text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;'>";
            echo "<img src='".$konyv['borito']."' alt='Borító' style='width: 50px; height: auto;'>";
            echo "<span class='book-title' style='color: black;'>".$konyv['kcim']."</span>";
            echo "<span class='book-title' style='color: black;'>".$konyv['ar']."Ft</span>";
            echo "</a>";
            echo "<form action='remove_from_cart.php' target='kisablak' method='post'>
                    <button type='submit'>X</button>
                    <input type='hidden' name='id' value='".$konyv['konyvid']."'>
                  </form>";
            echo "</div>";
        }
    } else {
        echo "<p>A kosár üres.</p>";
    }
} else {
    echo "<p>Kérlek, jelentkezz be a kosár megtekintéséhez.</p>";
}
?>
