<?php
if (session_status() === PHP_SESSION_NONE) session_start();
require_once "kapcsolat.php";
mysqli_set_charset($adb,"utf8mb4");
mysqli_select_db($adb,"kl_registration");
?>
<div style="max-width:640px;margin:30px auto;padding:20px;background:#fff;border-radius:10px;border:1px solid #eee;">
  <h1>Szervezeti regisztráció</h1>
  <form action="reg_org_ir.php" method="post">
    <label>Felhasználónév
      <input type="text" name="username" required style="width:100%;padding:10px;margin:6px 0;">
    </label>
    <label>E-mail
      <input type="email" name="email" required style="width:100%;padding:10px;margin:6px 0;">
    </label>
    <label>Jelszó
      <input type="password" name="password" required style="width:100%;padding:10px;margin:6px 0;">
    </label>
    <label>Szervezet neve
      <input type="text" name="org_name" required style="width:100%;padding:10px;margin:6px 0;">
    </label>
    <input type="hidden" name="is_org" value="1">
    <button type="submit" style="padding:10px 16px;background:#ff6b6b;border:none;color:#fff;border-radius:8px;cursor:pointer;">
      Regisztráció (Szervezet)
    </button>
  </form>
</div>
