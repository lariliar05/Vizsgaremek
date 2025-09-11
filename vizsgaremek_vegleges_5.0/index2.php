<?php
	session_start() ;
    include("kapcsolat.php");

    
    $ip = $_SERVER['REMOTE_ADDR'];
    $sess = substr(session_id(), 0 , 8);
    if(isset($_SESSION['uid'])) $uid = $_SESSION['uid'];
    else                        $uid = 0               ;
    $url = $_SERVER['REQUEST_URI'];

    mysqli_query($adb, 
    " INSERT INTO naplo (nid, ndate,   nip,  nsession,  nuid,   nurl) 
      VALUES            (NULL,NOW(), '$ip',   '$sess','$uid', '$url')");

    
?>
<html>
<head>
<style>

/* Alapértelmezett stílusok */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f2f5;
    color: #333;
}



/* Fejléc és bejelentkezés */
div#login {
    text-align: right;
    background-color: #fff;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#login a {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
    margin-left: 15px;
}

#login img {
    vertical-align: middle;
    border-radius: 50%;
    width: 40px;
    height: 40px;
}

#login input[type="button"] {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    margin-left: 10px;
    cursor: pointer;
    border-radius: 5px;
}

#login input[type="button"]:hover {
    background-color: #0056b3;
}

/* Gombok stílusa */
button, input[type="button"] {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 15px;
    cursor: pointer;
    font-size: 14px;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

button:hover, input[type="button"]:hover {
    background-color: #0056b3;
}

/* Tartalom központozása */
.main-content {
    text-align: center;
    margin-top: 50px;
}

h1 {
    color: #333;
    font-size: 36px;
    margin-bottom: 20px;
}



/* 404 oldal stílus */
.error-page {
    text-align: center;
    margin-top: 100px;
    font-size: 24px;
    color: #ff6b6b;
}

/* Iframe keret eltüntetése */
iframe {
    border: none;
    width: 100%;
    height: 400px;
    margin-top: 20px;
    display:none;
}

/* Profilkép méretezése és igazítása */
#login img {
    height: 50px;
    width: 50px;
    border-radius: 50%;
    margin-right: 10px;
}



</style>

</head>



<body>


<div id="login" style="<?php echo (isset($_GET['p']) && $_GET['p'] == 'adatlapom') ? 'display:none;' : ''; ?>">
    <?php
    if (!isset($_SESSION['uid']) && (!isset($_GET['p']) || $_GET['p'] != 'login')) {
        print "<input type='button' value='Belépés' id='belepes' onclick='location.href=\"./?p=login\"'>";
    } else if (isset($_SESSION['uid'])) {
        $user = mysqli_fetch_array(mysqli_query($adb, "SELECT * FROM user WHERE uid='$_SESSION[uid]'"));
        if ($user['uprofkepnev'] != "") $profkep = "./profilkepek/" . $user['uprofkepnev_eredetinev'];
        else $profkep = "./profilkepek/alapprofilkep.jfif";

        print "<img src='$profkep'>
               <a href='./?p=adatlapom'>" . htmlspecialchars($_SESSION['username']) . "</a>
               <input type='button' value='Kilépés' onclick='kisablak.location.href=\"logout.php\"'>";
    }
    ?>
</div>

</div>

        <br><br>
        
        <iframe name="kisablak"></iframe>
<!--
         <footer>
            <p>&copy; 2024 YourWebsite. Minden jog fenntartva.</p>
        </footer> -->



<?php

    if( isset( $_GET['p'] ) )  $p = $_GET['p'] ;
    else                       $p = ""         ;


    if( !isset( $_SESSION['uid']) ){
        if( $p==""             )  include("kezdolap.php"); else 
        if( $p=="regisztracio" )  include( "vizsgaremek.html"   ) ; else
        if( $p=="login"        )  include( "login_form.php" ) ; else
                                  include("404_kulso.php"); 
    }

    else{
        if($p=="")                include("belsolap.php"); else
        if($p=="adatlapom")       include("adatlap_form.php"); else
        if($p=="jelszomodositas") include("jelszomodositas.php"); else
                                  include("404_belso.php");
    }
    


?>


</body>

</html>