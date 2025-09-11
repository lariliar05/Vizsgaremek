<?php
session_start();
include("kapcsolat.php");

// Ha nincs bejelentkezve a felhasználó, akkor nem küldünk üzeneteket
if (!isset($_SESSION['uid'])) {
    echo json_encode(['messages' => []]);
    exit;
}

// Az új üzenetek lekérése
$query = "SELECT s.sszoveg, u.username FROM support s
          LEFT JOIN user u ON s.uid = u.uid
          WHERE s.sstatusz = 1
          ORDER BY s.sdatum DESC";

$result = mysqli_query($adb, $query);

$messages = [];
while ($row = mysqli_fetch_assoc($result)) {
    $messages[] = $row;
}

echo json_encode(['messages' => $messages]);
?>
