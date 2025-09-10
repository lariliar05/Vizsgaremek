<?php
header('Content-Type: application/json; charset=utf-8');

include("kapcsolat.php");

if (!isset($_GET['id']) || empty($_GET['id'])) {
    echo "<script>alert('nincs id megadva!')</script>";
    exit; 
}

$id = mysqli_real_escape_string($adb, $_GET['id']);
$konyvek = mysqli_query($adb, "SELECT * FROM konyvek WHERE konyvid = '$id'");

if (!$konyvek) {
    echo "<script>alert('valami hiba történt!')</script>";
    exit;
}

$konyv = mysqli_fetch_array($konyvek, MYSQLI_ASSOC);

if (!$konyv) {
    echo json_encode(['error' => 'nincs ilyen könyv']);
    exit;
}

$tomb = array(
    'id'     => $konyv['konyvid'],
    'cim'    => $konyv['kcim'],
    'iro'    => $konyv['iro'],
    'borito' => $konyv['borito'],
    'oldal'  => $konyv['oldal'],
    'mufaj'  => $konyv['mufaj'],
    'kdatum'  => $konyv['kdatum'],
    'kiado'  => $konyv['kiado'],
    'leiras' => $konyv['leiras'],
);

$json = json_encode($tomb, JSON_UNESCAPED_UNICODE);
echo $json;
?>