<?php
    session_start() ;
    include( "kapcsolat.php" ) ;
    $email = $_POST["email"];
    $pw = md5($_POST["pw"]);
    $userek = mysqli_query( $adb , "
                    SELECT * FROM user 
                    WHERE  (uemail='$email' OR username='$email') 
                    AND     upassword   =    '$pw'
    " ) ;

    if( mysqli_num_rows($userek)==0 )
    {
        print "<script> alert('Hibás belépési adatok!') </script>" ;
    }
    else
    {
        $user = mysqli_fetch_array($userek) ;
        $_SESSION['uid']  = $user['uid'] ;
            $_SESSION['username']  = $user['username'] ;
            $logip = $_SERVER['REMOTE_ADDR'];
            $logsess = substr(session_id(), 0 , 8);
            if (isset($_SESSION['uid'])) {
                    $uid = $_SESSION['uid'];
            } else{
                    die("<script>alert('már be vagy jelentkezve')</script>") ;
            }

            mysqli_query($adb,
            "INSERT INTO login (
                logid,
                logdate,
                logip,
                logsession,
                luid
                ) 
            VALUES (
                NULL,
                NOW(),
                '$logip',
                '$logsess',
                '$uid'
            )");

          mysqli_close( $adb ) ;

          print "<script> parent.location.href='./?p=konyvek' </script>" ;
    }
?>
