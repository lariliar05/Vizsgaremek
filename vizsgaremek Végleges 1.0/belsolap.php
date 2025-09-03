<?php 
include("header.php");
require_once 'kapcsolat.php'; // Az adatbázis kapcsolatot biztosító fájl

// Ha nincs bejelentkezve a felhasználó, nem lehet hozzáférni a kedvencekhez
if (!isset($_SESSION['uid'])) {
    echo "<p>Kérjük, jelentkezz be a könyvek kedvencekhez adásához.</p>";
    exit;
}

$uid = $_SESSION['uid'];

// Lekérjük a felhasználó kedvenc könyveit
$query = "SELECT kgid FROM kedvencek WHERE uid = ?";
$stmt = mysqli_prepare($adb, $query);
mysqli_stmt_bind_param($stmt, "i", $uid);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

$favorites = [];
while ($row = mysqli_fetch_assoc($result)) {
    $favorites[] = $row['kgid'];
}
mysqli_stmt_close($stmt);
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
            margin-top: 50px;
            padding: 0 20px;
            flex: 1;
        }
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
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
            color: #ff6b6b;
            font-size: 16px;
            margin: 8px 0 4px;
            font-weight: bold;
            white-space: nowrap; /* A szöveg ne törjön új sorba */
            overflow: hidden;    /* A túlcsorduló szöveget rejtse el */
            text-overflow: ellipsis; /* Túl hosszú szöveg esetén ... jelenjen meg */
        }

        .book-author {
            color: #fd7015;
            font-size: 13px;
            margin-bottom: 4px;
        }
        .book-price {
            color: #a3e635;
            font-size: 14px;
            font-weight: bold;
            margin-top: 6px;
        }

        .heart-icon {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            color: #ff6b6b;
            cursor: pointer;
            transition: transform 0.2s, color 0.2s;
            z-index: 10;
        }

        .heart-icon:hover {
            transform: scale(1.2);
            color: #e63946;
        }

        .book-card {
            position: relative;
            background-color: #2a2c2f;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            text-align: center;
            padding: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }

        .book-card:hover .add-to-cart {
            opacity: 1;
            transform: translateY(0);
        }

        .add-to-cart {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%) translateY(20px);
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
            opacity: 0;
            transition: opacity 0.3s ease, transform 0.3s ease;
            cursor: pointer;
        }

        .add-to-cart:hover {
            background-color: rgba(255, 255, 255, 0.8);
            color: black;
        }

        /* Kosár hover tartalom */
        #cart-dropdown {
            position: absolute;
            top: 25px;
            right: 0;
            display: none;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 10px;
            width: 300px;
            border-radius: 8px;
            z-index: 1000; /* A könyvek kártyái fölé kerüljön */
        }
    </style>
</head>
<body>
<div class="main-content">
    <h1>Könyvek Google Books API alapján</h1>
    <div class="book-grid">
    <?php
    // Google Books API kulcs és URL
    $apiKey = 'AIzaSyCp1jq9ZMp5iqoDA1gBrMBJr8d4UNk11gg';
    $query = 'marvel'; // A keresett kifejezés
    $url = "https://www.googleapis.com/books/v1/volumes?q=" . urlencode($query) . "&key=$apiKey&maxResults=40";

    // API hívás és válasz kezelése
    $response = file_get_contents($url);
    $data = json_decode($response, true);

    // Könyvek megjelenítése
    if (isset($data['items']) && count($data['items']) > 0) {
        foreach ($data['items'] as $book) {
            $id = $book['id']; // Egyedi azonosító az API válaszából
            $title = $book['volumeInfo']['title'] ?? 'N/A';
            $author = implode(', ', $book['volumeInfo']['authors'] ?? ['Ismeretlen szerző']);
            $cover = $book['volumeInfo']['imageLinks']['thumbnail'] ?? 'nincs_kep.jpeg';
            $price = $book['saleInfo']['listPrice']['amount'] ?? 'Ár nem elérhető';

            // Ellenőrizzük, hogy a könyv kedvenc-e
            $isFavorite = in_array($id, $favorites) ? '💖' : '❤️';

            echo "<div class='book-card' data-book-id='" . htmlspecialchars($id) . "'>";
            echo "<div class='heart-icon' title='Hozzáadás a kedvencekhez'>" . $isFavorite . "</div>";
            echo "<div class='add-to-cart' onclick='addToCart(\"" . htmlspecialchars($id) . "\", \"add\")'>Kosárhoz adás</div>";
            echo "<a href='./?p=konyvreszletek&id=" . urlencode($id) . "' style='text-decoration: none; color: inherit;'>";
            echo "<img src='" . htmlspecialchars($cover) . "' alt='" . htmlspecialchars($title) . "' class='book-cover'>";
            echo "<div class='book-title'>" . htmlspecialchars($title) . "</div>";
            echo "<div class='book-author'>" . htmlspecialchars($author) . "</div>";
            echo "<div class='book-price'>" . htmlspecialchars($price) . " Ft</div>";
            echo "</a>";
            echo "</div>";
        }
    } else {
        echo "<p>Nincs találat.</p>";
    }
    ?>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const heartIcons = document.querySelectorAll('.heart-icon');
    heartIcons.forEach(icon => {
        icon.addEventListener('click', (event) => {
            event.stopPropagation(); // Az esemény ne propagálódjon a szülőhöz
            const bookCard = event.target.closest('.book-card');
            const bookId = bookCard.getAttribute('data-book-id');
            const isFavorited = icon.textContent === '💖'; // Ellenőrizzük, hogy már kedvenc-e

            const action = isFavorited ? 'remove' : 'add'; // Ha kedvenc, akkor eltávolítjuk, ha nem, akkor hozzáadjuk

            fetch('add_to_favorites.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ bookId, action }) // Könyv azonosító és művelet
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    icon.textContent = isFavorited ? '❤️' : '💖'; // Változtatjuk az ikont
                } else {
                    alert(data.message || 'Hiba történt a kedvencekhez adás/eltávolítás során.');
                }
            })
            .catch(error => console.error('Hálózati hiba:', error));
        });
    });
});

function addToCart(bookId, action) {
    fetch('add_to_cart.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ bookId, action })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Kosár szám frissítése
            const cartCountElement = document.getElementById('cart-count');
            const currentCount = parseInt(cartCountElement.textContent, 10) || 0;
            cartCountElement.textContent = currentCount + 1;
            alert('A könyv hozzáadva a kosárhoz!');
        } else {
            alert(data.message || 'Hiba történt a könyv hozzáadásakor.');
        }
    })
    .catch(error => console.error('Hálózati hiba:', error));
}
</script>

</body>
</html>
