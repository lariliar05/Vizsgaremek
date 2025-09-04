<?php
include("header.php");
require_once 'kapcsolat.php'; // Az adatbázis kapcsolatot biztosító fájl

if (!isset($_SESSION['uid'])) {
    echo "<p>Kérjük, jelentkezz be a kedvenceid megtekintéséhez.</p>";
    exit;
}

$uid = $_SESSION['uid'];

try {
    // Lekérdezés a felhasználó kedvenceire
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

    if (empty($favorites)) {
        echo "<p>Nincsenek kedvencek.</p>";
        exit;
    }
} catch (Exception $e) {
    echo "<p>Hiba történt: " . htmlspecialchars($e->getMessage()) . "</p>";
    exit;
}
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kedvencek</title>
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
        .book-card {
            position: relative;
            background-color: #2a2c2f;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            text-align: center;
            padding: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
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
        }
        .book-author {
            color: #fd7015;
            font-size: 13px;
            margin-bottom: 4px;
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
    </style>
</head>
<body>
<div class="main-content">
    <h1>Kedvenceid</h1>
    <div class="book-grid">
    <?php
    // Google Books API kulcs
    $apiKey = 'AIzaSyCp1jq9ZMp5iqoDA1gBrMBJr8d4UNk11gg';

    foreach ($favorites as $kgid) {
        $url = "https://www.googleapis.com/books/v1/volumes/" . urlencode($kgid) . "?key=$apiKey";
        $response = file_get_contents($url);
        $book = json_decode($response, true);

        $title = $book['volumeInfo']['title'] ?? 'N/A';
        $author = implode(', ', $book['volumeInfo']['authors'] ?? ['Ismeretlen szerző']);
        $cover = $book['volumeInfo']['imageLinks']['thumbnail'] ?? 'nincs_kep.jpeg';

        // Ellenőrizzük, hogy a könyv már a kedvencek között van
        $isFavorite = in_array($kgid, $favorites) ? '💖' : '❤️'; // Ha kedvenc, akkor 💖

        echo "<div class='book-card' data-book-id='" . htmlspecialchars($kgid) . "'>";
        echo "<div class='heart-icon' title='Eltávolítás a kedvencekből' data-favorite='" . $isFavorite . "'>" . $isFavorite . "</div>";
        echo "<img src='" . htmlspecialchars($cover) . "' alt='" . htmlspecialchars($title) . "' class='book-cover'>";
        echo "<div class='book-title'>" . htmlspecialchars($title) . "</div>";
        echo "<div class='book-author'>" . htmlspecialchars($author) . "</div>";
        echo "</div>";
    }
    ?>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const heartIcons = document.querySelectorAll('.heart-icon');
    heartIcons.forEach(icon => {
        const initialIcon = icon.getAttribute('data-favorite');
        icon.textContent = initialIcon; // Beállítjuk az ikont az oldal betöltésekor

        icon.addEventListener('click', (event) => {
            event.stopPropagation(); // Az esemény ne propagálódjon a szülőhöz
            const bookCard = event.target.closest('.book-card');
            const bookId = bookCard.getAttribute('data-book-id');
            const iconText = event.target.textContent;

            // Az ikon aktív állapota (💖)
            if (iconText === '💖') {
                // Eltávolítás a kedvencekből
                fetch('add_to_favorites.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ bookId, action: 'remove' }) // Könyv azonosító és művelet
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        icon.textContent = '❤️'; // Visszaállítjuk az inaktív ikont
                        bookCard.remove(); // A könyv eltávolítása a képernyőről
                    } else {
                        alert(data.message || 'Hiba történt a kedvencek eltávolításánál.');
                    }
                })
                .catch(error => console.error('Hálózati hiba:', error));
            } else {
                // Hozzáadás a kedvencekhez
                fetch('add_to_favorites.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ bookId, action: 'add' }) // Könyv azonosító és művelet
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        icon.textContent = '💖'; // Beállítjuk az aktív ikont
                    } else {
                        alert(data.message || 'Hiba történt a kedvencekhez adás során.');
                    }
                })
                .catch(error => console.error('Hálózati hiba:', error));
            }
        });
    });
});
</script>

</body>
</html>
