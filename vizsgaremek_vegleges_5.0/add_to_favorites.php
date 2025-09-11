<?php
session_start();
require_once 'kapcsolat.php'; // Az adatbázis kapcsolatot biztosító fájl

if (!isset($_SESSION['uid'])) {
    echo json_encode(['success' => false, 'message' => 'Felhasználó nincs bejelentkezve.']);
    exit;
}

$uid = $_SESSION['uid'];
$data = json_decode(file_get_contents('php://input'), true);
$kgid = $data['bookId'] ?? '';
$action = $data['action'] ?? 'add'; // 'add' vagy 'remove'

if (empty($kgid)) {
    echo json_encode(['success' => false, 'message' => 'Hibás könyv azonosító.']);
    exit;
}

try {
    if ($action == 'remove') {
        // Eltávolítjuk a könyvet a kedvencek közül
        $query = "DELETE FROM kedvencek WHERE uid = ? AND kgid = ?";
        $stmt = mysqli_prepare($adb, $query);
        mysqli_stmt_bind_param($stmt, "is", $uid, $kgid);
        $result = mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);

        if ($result) {
            echo json_encode(['success' => true, 'message' => 'Könyv eltávolítva a kedvencekből.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Adatbázis hiba az eltávolítás során.']);
        }
    } else {
        // Ellenőrizzük, hogy a könyv már a kedvencek között van-e
        $query = "SELECT * FROM kedvencek WHERE uid = ? AND kgid = ?";
        $stmt = mysqli_prepare($adb, $query);
        mysqli_stmt_bind_param($stmt, "is", $uid, $kgid);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(['success' => false, 'message' => 'Ez a könyv már a kedvenceid között van.']);
        } else {
            // Ha nincs a kedvencek között, hozzáadjuk
            $insertQuery = "INSERT INTO kedvencek (uid, kgid) VALUES (?, ?)";
            $insertStmt = mysqli_prepare($adb, $insertQuery);
            mysqli_stmt_bind_param($insertStmt, "is", $uid, $kgid);

            if (mysqli_stmt_execute($insertStmt)) {
                echo json_encode(['success' => true, 'message' => 'Könyv hozzáadva a kedvencekhez.']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Adatbázis hiba a mentés során.']);
            }

            mysqli_stmt_close($insertStmt);
        }
        mysqli_stmt_close($stmt);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Szerverhiba: ' . $e->getMessage()]);
}

mysqli_close($adb);
?>
