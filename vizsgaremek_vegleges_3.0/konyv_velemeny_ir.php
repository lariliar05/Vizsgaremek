<?php
    session_start() ;
    include("kapcsolat.php");
    if (isset($_SESSION['uid'])) {
        if (!empty($_POST['comment'])) {
            $time = date('Ymd');
            $comment = mysqli_real_escape_string($adb, $_POST['comment']);
            mysqli_query($adb, "INSERT INTO `ertekelesek`(`eid`, `uid`, `kid`, `eszoveg`, `edatum`, `status`) 
                        VALUES (NULL, $_SESSION[uid], $_POST[id], '$comment', '$time', 'a')");
            print "<script> parent.location.href = parent.location.href </script>" ;
        }else{
            print "<script>alert('írj a mezőbe')</script>";
        }
    }else{
        print "<script> parent.location.href = './?p=login' </script>" ;
    }
    mysqli_close($adb);
?>