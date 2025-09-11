<!DOCTYPE html>
<html lang="hu">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Regisztráció</title>
  <style>
    *{box-sizing:border-box;font-family:"Barlow Semi Condensed",sans-serif;margin:0;padding:0}
    body{display:flex;min-height:100vh;background:#151515;color:#fff}
    #regisz{background:#222;padding:30px;border-radius:10px;box-shadow:0 4px 8px rgba(0,0,0,.3);width:100%;max-width:400px;margin:auto}
    #cim{text-align:center;font-weight:800;font-size:1.8em;color:#fd7015;margin-bottom:20px;text-transform:uppercase}
    #regisz label{font-weight:700;display:block;margin:0 0 6px;color:#ddd}
    #regisz input[type="text"],
    #regisz input[type="email"],
    #regisz input[type="password"],
    #regisz input[type="tel"],
    #regisz input[type="date"]{
      width:100%;padding:10px;margin:0 0 15px;border:1px solid #444;border-radius:5px;background:#333;color:#fff
    }
    #regisz input[type="checkbox"]{margin-right:10px}
    #regisz input[type="submit"]{
      background:#fd7015;color:#fff;padding:12px;border:none;border-radius:5px;cursor:pointer;width:100%;font-size:16px;margin-top:10px;transition:background .3s
    }
    #regisz input[type="submit"]:hover{background:#e0630d}
    .org-wrap{margin:8px 0 12px;padding:10px;border:1px solid #444;border-radius:8px;background:#1c1c1c}
    .org-row{display:flex;gap:8px;align-items:center;margin-bottom:8px}
  </style>
</head>
<body>

  <form action="reg_ir.php" method="post" target="kisablak" id="regisz">
    <div id="cim">Regisztráció</div>

    <label for="username">Felhasználónév</label>
    <input type="text" name="username" id="username" required>

    <label for="email">Email</label>
    <input type="email" name="email" id="email" required>

    <label for="password">Jelszó</label>
    <input type="password" name="password" id="password" required>

    <!-- Szervezeti regisztráció blokk -->
    <div class="org-wrap">
      <div class="org-row">
        <input type="checkbox" id="is_org_chk">
        <label for="is_org_chk" style="margin:0;cursor:pointer;">Szervezetként regisztrálok</label>
      </div>

      <div id="org_fields" style="display:none;">
        <label for="org_name">Szervezet neve</label>
        <input type="text" name="org_name" id="org_name" placeholder="Pl. Könyvmentők Egyesület">
      </div>

      <!-- rejtett mező: ezt küldjük a backendnek -->
      <input type="hidden" name="is_org" id="is_org" value="0">
    </div>

    <label for="checkbox" style="display:flex;gap:10px;align-items:center;margin-top:6px;">
      <input type="checkbox" name="checkbox" id="checkbox" required>
      Beleegyezek a feltételekbe
    </label>

    <input type="submit" value="Regisztráció">
  </form>

  <script>
    const chk    = document.getElementById('is_org_chk');
    const wrap   = document.getElementById('org_fields');
    const hidden = document.getElementById('is_org');
    const orgName= document.getElementById('org_name');

    function syncOrg(){
      const on = chk.checked;
      wrap.style.display = on ? 'block' : 'none';
      hidden.value = on ? '1' : '0';
      // szervezet esetén legyen kötelező a név
      if (on) { orgName.setAttribute('required','required'); }
      else { orgName.removeAttribute('required'); orgName.value=''; }
    }
    chk.addEventListener('change', syncOrg);

    // URL-ből előre bepipálás: ?org=1
    if (new URLSearchParams(location.search).get('org') === '1') { chk.checked = true; }
    syncOrg();
  </script>

</body>
</html>
