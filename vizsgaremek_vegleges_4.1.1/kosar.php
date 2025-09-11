<?php
require 'kapcsolat.php'; // Az adatbázis kapcsolatot biztosító fájl

if (!isset($_SESSION['uid'])) {
    echo "<h2>Kérjük, jelentkezz be a kosár megtekintéséhez!</h2>";
    exit;
}

$uid = $_SESSION['uid'];

// Lekérjük a felhasználó kosárba tett könyveit
$query = "SELECT * FROM kosar INNER JOIN konyvek ON kosar.kid = konyvek.konyvid  WHERE kosar.uid = ? AND kosar.statusz = 1";
$stmt = mysqli_prepare($adb, $query);
mysqli_stmt_bind_param($stmt, "i", $uid);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

$cartItems = [];
while ($row = mysqli_fetch_assoc($result)) {
    $cartItems[] = [
        'id' => $row['koid'],
        'kid' => $row['kid'],
        'title' => $row['kcim'], 
        'author' => $row['iro'],   
        'cover' => $row['borito'], 
        'price' => $row['ar']
    ];
}
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kosár</title>
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
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #2a2c2f;
            border-radius: 8px;
            padding: 15px;
            margin: 10px 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        .book-details {
            display: flex;
            align-items: center;
        }
        .book-details img {
            width: 50px;
            height: auto;
            border-radius: 4px;
            margin-right: 15px;
        }
        .book-title {
            color: #ff6b6b;
            font-size: 16px;
            font-weight: bold;
        }
        .book-author {
            color: #fd7015;
            font-size: 13px;
        }
        .actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn {
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #e63946;
        }
        .btn-secondary {
            background-color: #fd7015;
        }
        .btn-secondary:hover {
            background-color: #d95c00;
        }

        /* Modális ablak stílusa */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background-color: #2a2c2f;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            text-align: center;
            color: #e0e0e0;
        }
        .modal-content input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #555;
        }
        .modal-content .btn {
            width: 100%;
        }
        .modal-close {
            background: none;
            color: #ff6b6b;
            border: none;
            font-size: 20px;
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }
        /* Korábbi stílusok itt */
        .step-hidden {
            display: none;
        }
    </style>
</head>
<body>
<div class="main-content">
    <h1>Kosár tartalma</h1>
    <ul id="cart-items">
        <?php foreach ($cartItems as $item): ?>
            <li data-id="<?= $item['id'] ?>">
                <div class="book-details">
                    <img src="<?= htmlspecialchars($item['cover']) ?>" alt="<?= htmlspecialchars($item['title']) ?>">
                    <div>
                        <div class="book-title"><?= htmlspecialchars($item['title']) ?></div>
                        <div class="book-author"><?= htmlspecialchars($item['author']) ?></div>
                    </div>
                </div>
                <div class="actions">
                    <div class="book-price"><?= htmlspecialchars($item['price']) ?> Ft</div>
                    <form action="remove_from_cart.php" target="kisablak" method="post">
                        <button class="btn remove-item" type="submit">Eltávolítás</button>
                        <input type="hidden" name="id" value="<?=htmlspecialchars($item['kid'])?>">
                    </form>
                </div>
            </li>
        <?php endforeach; ?>
    </ul>

    <a href="./?p=konyvek" class="btn btn-secondary">Vásárlás folytatása</a>
    <?php $teljes = mysqli_fetch_array(mysqli_query($adb,"SELECT SUM(ar) AS total FROM konyvek INNER JOIN kosar ON konyvek.konyvid = kosar.kid WHERE kosar.statusz = 1 AND kosar.uid = '$uid'") ,MYSQLI_ASSOC);
        if (isset($teljes['total'])) {
            echo'<button class="btn" id="checkout">Fizetés</button>';
            echo"<span>Teljes összeg:".$teljes['total']."Ft</span>" ;
        }
    ?>

    
</div>

<!-- Modális ablak -->
<div class="modal" id="payment-modal">
    <div class="modal-content">
        <button class="modal-close" id="close-modal">&times;</button>
        <div id="payment-step-1">
            <h2>Kártyaadatok</h2>
            <form id="payment-form" action="process_payment.php" target="kisablak" method="POST">
                <input type="text" name="name" placeholder="Teljes név" required>
                <input type="text" name="card_number" placeholder="Kártyaszám" required>
                <input type="text" name="expiry" placeholder="Lejárati dátum (MM/YY)" required>
                <input type="text" name="cvv" placeholder="CVV" required>
                <button type="submit" class="btn">Fizetés</button>
            </form>
        </div>
    </div>
</div>

<script>
    // Fizetési modal
    const checkoutButton = document.getElementById('checkout');
    const paymentModal = document.getElementById('payment-modal');
    const closeModal = document.getElementById('close-modal');
    const paymentStep1 = document.getElementById('payment-step-1');

    checkoutButton.addEventListener('click', () => {
        paymentModal.style.display = 'flex';
    });

    closeModal.addEventListener('click', () => {
        paymentModal.style.display = 'none';
        resetModal();
    });

    window.addEventListener('click', (event) => {
        if (event.target === paymentModal) {
            paymentModal.style.display = 'none';
            resetModal();
        }
    });

    function resetModal() {
        paymentStep1.style.display = 'block';
    }
</script>
</body>
</html>