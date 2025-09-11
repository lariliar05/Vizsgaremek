
<?php
    $adb = mysqli_connect( "localhost", "root", "", "kl_registration" ) ;

// Ellenőrizzük, hogy van-e `uid` paraméter
if (isset($_GET['uid'])) {
    $uid = intval($_GET['uid']); // Biztonsági okokból konvertáljuk egész számra
    // Felhasználói adatokat lekérdezzük az adott `uid` alapján
    $query = "SELECT * FROM user WHERE uid = '$uid'";
    $result = mysqli_query($adb, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        $user = mysqli_fetch_assoc($result);
        $profkep = !empty($user['uprofkepnev_eredetinev']) ? "./profilkepek/" . $user['uprofkepnev_eredetinev'] : "./profilkepek/alapprofilkep.jfif";
    } else {
        echo "Nincs ilyen felhasználó.";
        exit;
    }
} else {
    echo "Nincs megadva felhasználó ID.";
    exit;
}
?>
<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adatmódosítás</title>
    <style>
        /* Ide beilleszthető a meglévő CSS */
    </style>
</head>

<style>
        /* Reset and box-sizing */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling for centering */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #4a90e2, #2a5470);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
            color: #333;
        }

        /* Form container styling */
        form {
            background-color: #ffffff;
            padding: 20px; /* Reduced padding */
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            max-width: 400px; /* Reduced max width for smaller form */
            width: 90%; /* Make it responsive for smaller screens */
            text-align: center;
            display: flex;
            flex-direction: column;
            gap: 15px;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Title styling */
        h2 {
            color: #333;
            font-size: 22px; /* Slightly smaller font */
            font-weight: 600;
            margin-bottom: 15px;
        }

        /* Label styling */
        label {
            font-size: 13px;
            color: #666;
            margin-bottom: 5px;
            text-align: left;
            display: block;
        }

        /* Input fields */
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        input[type="file"] {
            width: 100%;
            padding: 10px; /* Reduced padding */
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            color: #333;
            transition: border 0.3s, box-shadow 0.3s;
        }

        /* Focus state */
        input:focus {
            border-color: #4a90e2;
            outline: none;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.3);
        }

        /* Flex container for name fields */
        .name-container {
            display: flex;
            gap: 10px;
            margin-bottom: 1rem;
        }

        .name-container div {
            flex: 1;
        }

        /* Profile picture and file selection layout */
        .profile-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            text-align: left;
        }

        .profile-container img {
            width: 60px; /* Smaller profile image */
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ddd;
        }

        /* Submit button */
        input[type="submit"], input[type="button"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            margin-top: 8px;
        }

        input[type="submit"] {
            background-color: #4a90e2;
        }

        input[type="submit"]:hover {
            background-color: #357ab7;
            transform: translateY(-2px);
        }

        #jmodositas {
            background-color: #ff7675;
        }

        #jmodositas:hover {
            background-color: #d65c5c;
            transform: translateY(-2px);
        }

        /* Responsive adjustments */
        @media (max-width: 480px) {
            form {
                padding: 15px;
            }
            .name-container {
                flex-direction: column;
            }
        }
    </style>

<body>
    <form action='adatlap_ir.php' method='post' enctype='multipart/form-data'>
        <h2>Adatok Módosítása</h2>
        
        <!-- Profilkép -->
        <div class="profile-container">
            <img src="<?= htmlspecialchars($profkep); ?>" alt="Profilkép">
            <div>
                <label for="profkep">Profilkép:</label>
                <input type="file" name="profkep" id="profkep">
            </div>
        </div>

        <div class="name-container">
            <div>
                <label for="keresztnev">Keresztnév:</label>
                <input type="text" name="keresztnev" id="keresztnev" value="<?= htmlspecialchars($user['ufirstname']); ?>">
            </div>
            <div>
                <label for="vezeteknev">Vezetéknév:</label>
                <input type="text" name="vezeteknev" id="vezeteknev" value="<?= htmlspecialchars($user['ulastname']); ?>">
            </div>
        </div>

        <label for="szuldatum">Születési dátum:</label>
        <input type="date" name="szuldatum" id="szuldatum" value="<?= htmlspecialchars($user['uszuldatum']); ?>">

        <label for="username">Felhasználónév:</label>
        <input type="text" name="username" id="username" value="<?= htmlspecialchars($user['username']); ?>">

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" value="<?= htmlspecialchars($user['uemail']); ?>">

        <input type="submit" value="Adatok módosítása">
        <input type="hidden" name="uid" value="<?= htmlspecialchars($user['uid']); ?>">
    </form>
</body>
</html>