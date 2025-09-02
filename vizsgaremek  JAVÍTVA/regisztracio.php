<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Regisztráció</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: "Barlow Semi Condensed", sans-serif;
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            height: 100vh;
            background-color: #151515;
            text-align: center;
            color: white;
        }

        #regisz {
            background-color: #222222;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            justify-content: center;
            align-items: center;
            box-sizing: border-box;
            margin: auto;
        }

        #cim {
            text-align: center;
            font-weight: bold;
            font-size: 1.8em;
            color: #fd7015;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        #regisz label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #ddd;
        }
        
        #regisz input[type="text"],
        #regisz input[type="email"],
        #regisz input[type="password"],
        #regisz input[type="tel"],
        #regisz input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #444;
            border-radius: 5px;
            background-color: #333;
            color: #fff;
        }

        #regisz input[type="checkbox"] {
            margin-right: 10px;
        }

        #regisz input[type="submit"] {
            background-color: #fd7015;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        #regisz input[type="submit"]:hover {
            background-color: #e0630d;
        }

        .name-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .name-container div {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .name-container div:first-child {
            margin-right: 10px;
        }


    </style>
</head>
<body>
    <form action="reg_ir.php" method="post" target="kisablak" id="regisz">
        <label id="cim">Regisztráció</label>

        <label for="username">Felhasználónév:</label>
        <input type="text" name="username" id="username" required>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required>

        <label for="password">Jelszó:</label>
        <input type="password" name="password" id="password" required>

        <label for="checkbox">
            <input type="checkbox" name="checkbox" id="checkbox" required>
            Beleegyezek a feltételekbe
        </label>

        <input type="submit" value="Regisztráció">
    </form>
</body>
</html>
