<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bejelentkezés</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Barlow Semi Condensed", sans-serif;
        }

        body {
            display: flex;
            height: 100vh;
            background-color: #151515;
            text-align: center;
            color: white;
        }

        .form-container {
            background-color: #222222;
            justify-content: center;
            align-items: center;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
            margin: auto;
            
        }

        .form-container h2 {
            color: #fd7015;
            font-size: 1.8em;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        .form-container input[type="text"],
        .form-container input[type="password"],
        .form-container input[name="email"] {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #444;
            border-radius: 5px;
            font-size: 16px;
            background-color: #333;
            color: #fff;
        }

        .form-container input[type="submit"],
        .form-container input[type="button"] {
            background-color: #fd7015;
            color: white;
            border: none;
            padding: 12px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"]:hover,
        .form-container input[type="button"]:hover {
            background-color: #e0630d;
        }

        .form-container input[type="button"] {
            background-color: #28a745;
            margin-top: 10px;
        }

        .form-container input[type="button"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Bejelentkezés</h2>
    <form action="login_ir.php" method="post" target="kisablak">
        <input name="email" type="text" placeholder="felhasználó név vagy e-mail cím" required><br>
        <input name="pw" type="password" placeholder="Jelszó" required><br>
        <input type="submit" value="Belépés"><br>
        <input type="button" value="Regisztráció" onclick="location.href='./?p=reg'"><br>
    </form>
</div>

</body>
</html>
