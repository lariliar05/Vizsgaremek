<?php
ob_start();
?>
<!DOCTYPE html>
<html lang="hu">
<head>
    <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
<div id="login">
    <div id="menu-left">
        <a href="./?p="><button>Kezdőlap</button></a> 
        <div id="genres-dropdown">
    <button id="genres-button">Műfajok</button>
    <div id="genres-content">
        <div class="genres-section">
            <h3>Ajánlott</h3>
            <a href="./?p=konyv_lista&mufaj=ajanlott">2024 Top 10</a>
            <a href="./?p=konyv_lista&mufaj=2025">2025</a>
        </div>
        <div class="genres-section">
            <h3>Legnépszerűbb</h3>
            <a href="./?p=konyv_lista&mufaj=regeny">Regény</a>
            <a href="./?p=konyv_lista&mufaj=fantasy">Fantasy</a>
            <a href="./?p=konyv_lista&mufaj=krimi">Krimi</a>
            <a href="./?p=konyv_lista&mufaj=sci-fi">Sci-fi</a>
        </div>
        <div class="genres-section">
            <h3>Egyéb</h3>
            <a href="./?p=konyv_lista&mufaj=konyv_klub">Könyv Klub</a>
            <a href="./?p=konyv_lista&mufaj=ajanlottak">Ajánlottak</a>
        </div>
    </div>
</div>

        <div id="favorites">
            <a href="./?p=kedvencek" title="Kedvencek">
                <span id="favorites-icon">❤️</span>
            </a>
        </div>

        <form action="./?p=konyv_lista" method="get" id="book-search">
            <input type="hidden" name="p" value="konyv_lista">
            <input type="text" name="kereses" placeholder="Keresés könyv címe szerint...">
            <input type="submit" value="Keresés">
        </form>
    </div>

    <div id="menu-right">
        <div id="cart-container" style="position: relative;">
            <div id="cart-icon" style="cursor: pointer; position: relative;">
                <button id="kosarbutton" onclick="location.href='./?p=kosar'">🛒 <span id="cart-count">0</span> </button>
            </div>
            <div id="cart-dropdown" style="position: absolute; top: 25px; right: 0; display: none; background: white; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); padding: 10px; width: 300px; border-radius: 8px;">
                <p style="color:black;"><strong>Kosár tartalma:</strong></p>
                <div id="cart-items" style="max-height: 200px; overflow-y: auto;">
                    <!-- Kosár elemek itt fognak megjelenni -->
                </div>
                <button id="kosarbutton" onclick="location.href='./?p=kosar'">Kosár megtekintése</button>
            </div>
        </div>

    <script>
    // Kosár ikon hover eseménye
    document.getElementById('cart-icon').addEventListener('mouseenter', function() {
        document.getElementById('cart-dropdown').style.display = 'block'; // Kosár megjelenítése
        loadCartItems(); // Kosár elemek betöltése
    });

    // Kosár tartalom hover eseménye, hogy ne tűnjön el gyorsan
    document.getElementById('cart-dropdown').addEventListener('mouseenter', function() {
        this.style.display = 'block'; // Kosár tartalom megjelenítése
    });

    // Kosár ikon eltűnése, ha az egér elhagyja az ikont és nem a tartalom fölött van
    document.getElementById('cart-icon').addEventListener('mouseleave', function() {
        setTimeout(function() {
            if (!document.getElementById('cart-dropdown').matches(':hover')) {
                document.getElementById('cart-dropdown').style.display = 'none'; // Kosár eltűnése
            }
        }, 200); // Kis késleltetés hozzáadása
    });

    // Kosár tartalom eltűnése, ha az egér elhagyja a tartalmat
    document.getElementById('cart-dropdown').addEventListener('mouseleave', function() {
        this.style.display = 'none'; // Kosár eltűnése
    });

    // Kosár elemek betöltése
    function loadCartItems() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'load_cart.php', true); // Kosár elemek lekérése egy külön fájlból (load_cart.php)
        xhr.onload = function() {
            if (xhr.status === 200) {
                document.getElementById('cart-items').innerHTML = xhr.responseText;
            }
        };
        xhr.send();
    }

    document.addEventListener('DOMContentLoaded', () => {
    updateCartCount();

    function updateCartCount() {
        fetch('cart_count.php')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('cart-count').textContent = data.cartCount;
                } else {
                    console.error('Hiba a kosár számának lekérésekor:', data.message);
                }
            })
            .catch(error => console.error('Hálózati hiba:', error));
    }
});

    </script>

    <?php
    if (isset($_SESSION['uid'])) {
        $userQuery = mysqli_query($adb, "SELECT * FROM user WHERE uid='$_SESSION[uid]'");
        $user = mysqli_fetch_assoc($userQuery);

        if (!empty($user['uprofkepnev'])) {
            $profkep = "./profilkepek/" . htmlspecialchars($user['uprofkepnev_eredetinev']);
        } else {
            $profkep = "./profilkepek/alapprofilkep.jfif";
        }

        // Kosárban lévő könyvek számának lekérdezése
        $cartCountQuery = mysqli_query($adb, "SELECT COUNT(*) AS cart_count FROM kosar WHERE uid='$_SESSION[uid]'");
        $cartCount = mysqli_fetch_assoc($cartCountQuery)['cart_count'] ?? 0;

        echo "<div id='profile-container'>";
        echo "    <img src='$profkep' alt='Profilkép'>";
        echo "    <span>" . htmlspecialchars($user['username']) . "</span>";
        echo "    <div id='dropdown-arrow'>▼</div>";
        echo "    <div id='profile-menu'>";
        echo "        <a href='./?p=adatlapom'>Profil szerkesztése</a>";
        echo "        <a href='logout.php' target='kisablak'>Kijelentkezés</a>";
        echo "    </div>";
        echo "</div>";

    } else {
        echo "<input type='button' value='Belépés' onclick='location.href=\"./?p=login\"'>";
    }
    ?>
</div>

</div>
</body>
</html>
