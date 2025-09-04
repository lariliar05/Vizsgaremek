<?php
session_start();
include("kapcsolat.php");

header('Content-Type: application/json');

// Kapcsoljuk ki a hibák megjelenítését
error_reporting(E_ALL); // Minden hibát megjelenítünk
ini_set('display_errors', 1);

// JSON bemenet beolvasása
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    error_log("Hiba: Érvénytelen JSON bemenet.", 3, '/path/to/your/logfile.log');
    echo json_encode(['success' => false, 'message' => 'Érvénytelen JSON bemenet.']);
    exit;
}

$action = $input['action'] ?? '';
$supportId = intval($input['supportid'] ?? 0);

if (!$action || !$supportId) {
    error_log("Hiba: Hiányzó paraméterek.", 3, '/path/to/your/logfile.log');
    echo json_encode(['success' => false, 'message' => 'Hiányzó paraméterek.']);
    exit;
}

if ($action === 'save') {
    $svalasz = mysqli_real_escape_string($adb, $input['svalasz'] ?? '');
    $query = "UPDATE support SET svalasz = '$svalasz', sstatusz = 0 WHERE supportid = $supportId";
    if (mysqli_query($adb, $query)) {
        echo json_encode(['success' => true]);
    } else {
        error_log("Hiba a válasz mentésekor: " . mysqli_error($adb), 3, '/path/to/your/logfile.log');
        echo json_encode(['success' => false, 'message' => 'Hiba történt a válasz mentésekor.']);
    }
} elseif ($action === 'delete') {
    $query = "DELETE FROM support WHERE supportid = $supportId";
    if (mysqli_query($adb, $query)) {
        echo json_encode(['success' => true]);
    } else {
        error_log("Hiba a kérdés törlésekor: " . mysqli_error($adb), 3, '/path/to/your/logfile.log');
        echo json_encode(['success' => false, 'message' => 'Hiba történt a kérdés törlésekor.']);
    }
} else {
    error_log("Hiba: Érvénytelen művelet.", 3, '/path/to/your/logfile.log');
    echo json_encode(['success' => false, 'message' => 'Érvénytelen művelet.']);
}

?>
