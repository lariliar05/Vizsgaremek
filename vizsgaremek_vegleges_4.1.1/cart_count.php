<?php
session_start();
require_once('kapcsolat.php'); // Adatbázis kapcsolat

if (isset($_SESSION['uid'])) {
    $uid = $_SESSION['uid'];

    $query = "SELECT COUNT(*) AS cart_count FROM kosar WHERE uid = ? AND statusz = 1";
    $stmt = mysqli_prepare($adb, $query);
    mysqli_stmt_bind_param($stmt, "i", $uid);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if ($row = mysqli_fetch_assoc($result)) {
        $response['success'] = true;
        $response['cartCount'] = $row['cart_count'];
    } else {
        $response['message'] = 'Nem sikerült lekérni a kosár számát.';
    }

    mysqli_stmt_close($stmt);
} else {
    $response['message'] = 'Nincs bejelentkezve.';
}

header('Content-Type: application/json');
echo json_encode($response);
