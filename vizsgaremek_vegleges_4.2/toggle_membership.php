<?php

error_reporting(E_ALL & ~E_DEPRECATED & ~E_STRICT);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

session_start();
if (!isset($_SESSION['uid'])) { header("Location: ./?p=login"); exit; }

include("kapcsolat.php");
//mysqli_select_db($adb, 'konyvklub');
mysqli_set_charset($adb, "utf8mb4");

$uid    = (int)$_SESSION['uid'];
$clubId = isset($_POST['club_id']) ? (int)$_POST['club_id'] : 0;
$action = $_POST['action'] ?? '';

if ($clubId <= 0 || ($action !== 'join' && $action !== 'leave')) {
    header("Location: ./?p=konyvklub"); exit;
}

if ($action === 'join') {
    $stmt = mysqli_prepare($adb, "INSERT IGNORE INTO book_club_members (user_id, club_id) VALUES (?, ?)");
    mysqli_stmt_bind_param($stmt, "ii", $uid, $clubId);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
} else { // leave
    $stmt = mysqli_prepare($adb, "DELETE FROM book_club_members WHERE user_id=? AND club_id=?");
    mysqli_stmt_bind_param($stmt, "ii", $uid, $clubId);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
}

header("Location: ./?p=konyvklub");
exit;