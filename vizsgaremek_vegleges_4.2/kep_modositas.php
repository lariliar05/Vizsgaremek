<?php
session_start();
include('kapcsolat.php');
function grs($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[random_int(0, $charactersLength - 1)];
    }
    return $randomString;
}

if (isset($_FILES)) {
    $kepnev = $_SESSION["uid"]."_".date("ymdHis")."_". grs(10) ;
    $kepadat = $_FILES["pkep"]; 

        if ($kepadat["type"]=="image/jpeg") $kiterj = ".jpg"; else
        if ($kepadat["type"]=="image/png") $kiterj = ".png"; else die("<script>alert('png vagy jpg legyen a kép kiterjesztése')</script>");
    
    $kepnev .= $kiterj;
    move_uploaded_file($kepadat["tmp_name"], "./profilkepek/".$kepnev);
    $eredetikepnev = $kepadat["name"];

    mysqli_query($adb, "UPDATE user SET uprofkepnev ='$kepnev', uprofkepnev_eredetinev='$eredetikepnev' WHERE uid = '$_POST[uid]'");
    print"<script>parent.location.href=parent.location.href</script>";
}else{
    echo'sikertelen volt a kép változtatás';
}

mysqli_close($adb);
?>