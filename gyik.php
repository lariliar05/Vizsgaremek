<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
?>
<div style="max-width:900px;margin:0 auto;padding:20px;">
  <h1>Gyakori kérdések (GYIK)</h1>

  <input id="faqSearch" type="text" placeholder="Keresés a kérdésekben…"
         style="width:100%;padding:12px 14px;border:1px solid #e6e6e6;border-radius:12px;margin:12px 0 16px;outline:none"
         onfocus="this.style.boxShadow='0 0 0 4px var(--ring)';"
         onblur="this.style.boxShadow='none';">

  <style>
    :root{
      --accent:#ff6b6b; --accent-hover:#e65959; --ink:#2c2f33;
      --muted:#6b7280; --card:#ffffff; --border:#eaeaea; --ring:rgba(255,107,107,.25);
    }
    .faq details{border:1px solid var(--border);border-radius:14px;background:var(--card);margin:12px 0;overflow:hidden;transition:border-color .2s,box-shadow .2s;}
    .faq details:focus-within{border-color:var(--accent);box-shadow:0 0 0 4px var(--ring);}
    .faq summary{list-style:none;background:linear-gradient(180deg,var(--accent),var(--accent-hover));color:#fff;padding:12px 16px;cursor:pointer;display:flex;align-items:center;gap:12px;font-weight:600;user-select:none;}
    .faq summary::-webkit-details-marker{display:none;}
    .faq .row{display:flex;align-items:center;justify-content:space-between;gap:12px;}
    .faq .badge{background:rgba(255,255,255,.25);color:#fff;font-size:12px;padding:2px 8px;border-radius:999px;margin-left:8px;}
    .faq .chev{transition:transform .2s;opacity:.9;font-size:18px;}
    .faq details[open] .chev{transform:rotate(180deg);}
    .faq .answer{padding:14px 16px;background:#fff;color:#333;line-height:1.55;border-top:1px solid var(--border);}
    .faq a{color:#0b63ff;text-decoration:none;} .faq a:hover{text-decoration:underline;}
    .note{font-size:12px;color:var(--muted);margin-top:8px;}
    .kbd{display:inline-block;border:1px solid #ddd;border-bottom-width:2px;border-radius:6px;padding:0 6px;background:#f9f9f9;font-family:ui-monospace,monospace;font-size:12px;}
  </style>

  <div class="faq" id="faqList">
    <details>
      <summary>
        <div class="row">
          <div>Hogyan hozhatok létre fiókot?<span class="badge">Fiók</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Kattints a <strong>Belépés</strong> gombra, majd válaszd a <em>Regisztráció</em> lehetőséget. Add meg az adataidat, és erős jelszót állíts be.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Elfelejtettem a jelszavam. Mit tegyek?<span class="badge">Fiók</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        A <strong>Belépés</strong> oldalon válaszd az <em>Elfelejtett jelszó</em> opciót (ha elérhető), vagy írj nekünk a <a href="./?p=support">Support</a>-on, és segítünk.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hogyan csatlakozhatok egy könyvklubhoz?<span class="badge">Könyv Klub</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Nyisd meg a <a href="./?p=konyvklub"><strong>Könyv Klub</strong></a> oldalt. Válaszd ki a klubot, majd kattints a <em>Csatlakozás</em> gombra.<br>
        <span class="kbd">Megjegyzés:</span> A gomb csak bejelentkezve látható.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hogyan léphetek ki egy könyvklubból?<span class="badge">Könyv Klub</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Ugyanott, ahol csatlakoztál: a klubkártyán a gomb <em>Kilépés</em>-re vált. Kattints rá, és azonnal megszűnik a tagságod.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hogyan adhatok hozzá új könyvklubot?<span class="badge">Könyv Klub</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        A <strong>Könyv Klub</strong> oldalon töltsd ki az űrlapot (Név, Leírás, hely koordináták). A helyet a térképen könnyebb megtalálni, ha pontos
        <em>szélesség</em> (latitude) és <em>hosszúság</em> (longitude) értéket adsz meg. Tizedes elválasztónál pontot használj (pl. <code>47.497913</code>).
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Nem látom a csatlakozás gombot. Miért?<span class="badge">Könyv Klub</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        A gomb csak bejelentkezett felhasználóknak jelenik meg. Jelentkezz be a jobb felső sarokban található <strong>Belépés</strong> gombbal.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hogyan teszek könyvet a kosárba?<span class="badge">Könyvek & Kosár</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        A <strong>Könyvek</strong> oldalon kattints a kiválasztott könyv mellett a <em>Kosárba</em> gombra. A jobb felső sarokban a 🛒 ikon mutatja a darabszámot.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hol látom a kosaram tartalmát?<span class="badge">Könyvek & Kosár</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Vidd az egeret a 🛒 ikon fölé a gyorsnézethez, vagy kattints rá a <strong>Kosár</strong> oldal megnyitásához. Itt tudsz tételeket törölni is.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Miért nem látom a térképet a Könyv Klub oldalon?<span class="badge">Térkép</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Ellenőrizd az internetkapcsolatot és hogy a böngészőben engedélyezve van-e a JavaScript. Frissítsd az oldalt (<span class="kbd">F5</span>).
        Ha továbbra sem jelenik meg, jelezd a <a href="./?p=support">Support</a>-on.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hogyan módosíthatom a profilomat vagy jelszavamat?<span class="badge">Fiók</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Bejelentkezve az <a href="./?p=adatlapom">Adatlapom</a> oldalon tudod szerkeszteni az adataidat, a jelszót pedig a <a href="./?p=jelszomodositas">Jelszómódosítás</a> menüpontban.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Mit történik az adataimmal?<span class="badge">Adatvédelem</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        Csak a szükséges adatokat tároljuk a fiókod és a szolgáltatás működéséhez. Ha kérdésed van, írj nekünk a <a href="./?p=support">Support</a>-on.
      </div>
    </details>

    <details>
      <summary>
        <div class="row">
          <div>Hogyan érem el az ügyfélszolgálatot?<span class="badge">Support</span></div>
          <span class="chev">▾</span>
        </div>
      </summary>
      <div class="answer">
        A jobb alsó <strong>Support</strong> gombbal megnyithatod az üzenetküldőt, vagy kattints ide: <a href="./?p=support">Support</a>.
      </div>
    </details>
  </div>

  <p class="note">Nem találtad a választ? Írj nekünk a <a href="./?p=support">Support</a>-on, szívesen segítünk!</p>
</div>

<script>
  // egyszerű kereső
  const input = document.getElementById('faqSearch');
  const list  = document.getElementById('faqList');
  const items = Array.from(list.querySelectorAll('details'));
  input.addEventListener('input', () => {
    const q = input.value.toLowerCase();
    items.forEach(d => {
      const text = (d.querySelector('summary')?.innerText + ' ' + d.querySelector('.answer')?.innerText).toLowerCase();
      const match = text.includes(q);
      d.style.display = match ? '' : 'none';
      if (!match) d.open = false;
    });
  });
</script>
