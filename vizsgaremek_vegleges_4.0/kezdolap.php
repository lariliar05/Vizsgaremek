<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #1d1f21;
        color: #e0e0e0;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }
    #tartalom{
        text-align: center;
        padding-left: 3rem;
        padding-right: 3rem;
    }
    input {
        background-color: #fd7015;
        color: #fff;
        border: none;
        padding: 8px 15px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 15px;
        margin-left: 10px;
        transition: background-color 0.3s;
    }
</style>
<div id="tartalom">
    <h1>Bookly</h1>
    <h4>Álmaid könyvtára</h4>
    <hr>
    <p>A Bookly egy online könyvtár ami úttörő ötletekel újitja meg a elavult könyvtári rendszereket és hatalmas tárházával nyujt elképzelhetetlen élményeket</p>
    <br><br><br>
    <?php
        echo "<input type='button' value='kezdés' onclick='location.href=\"./?p=login\"'>";
    ?>
</div>
</body>
</html>