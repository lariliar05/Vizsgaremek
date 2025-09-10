<?php
    session_start() ;
    include('kapcsolat.php');
    $stat =  (int)$_POST['krate'];
    $oldal = (int)$_POST['old'];
    $ertek = (int)$_POST['ertek'];

    if (isset($_SESSION['uid'])) {
        $listak = mysqli_query($adb , "SELECT * FROM klista WHERE uid = $_SESSION[uid] AND kid = $_POST[id]");
        if ($listak) {
            if (mysqli_num_rows($listak) > 0) {
                $lista = mysqli_fetch_array($listak, MYSQLI_ASSOC);
            }else {
               $lista = null;
            }
        }else {
            print die("<script>alert('hiba történt lekérdezés során')</script>") ;
        }

        if (isset($lista)) {
            mysqli_query($adb, "UPDATE klista SET status = $stat , oldal = $oldal , ertek = $ertek WHERE kid = $_POST[id]");
        } else{
            mysqli_query($adb, "INSERT INTO `klista` (`klid`, `uid`, `kid`, `status`, `oldal`, `ertek`) 
            VALUES (  NULL, $_SESSION[uid], $_POST[id], $ertek, $oldal, $stat)");
        }
    }else{
        print "<script> alert('be kell hogy jelentkezve legyél')</script>" ;
        print "<script> parent.location.href = './?p=login' </script>" ;
    }
    mysqli_close($adb);
?>