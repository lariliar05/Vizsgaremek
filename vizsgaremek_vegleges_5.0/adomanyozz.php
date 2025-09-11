<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";          // itt csatlakozol a DB-hez
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration"); // ha a kapcsolat.php már kiválasztja, ez nem árt

// --- Adat betöltése (NINCS GET SZŰRÉS) ---
$targets = [];
$sql = "SELECT id, name, description, category, website_url, donate_url, city, country, verified
        FROM donation_targets
        WHERE verified = 1
        ORDER BY name";
$q = mysqli_query($adb, $sql);
while ($q && ($r = mysqli_fetch_assoc($q))) { $targets[] = $r; }

// --- Kat. slugoló (ékezet -> ASCII, kisbetű, kötőjelek) ---
function cat_slug($s){
  $map = ['á'=>'a','é'=>'e','í'=>'i','ó'=>'o','ö'=>'o','ő'=>'o','ú'=>'u','ü'=>'u','ű'=>'u',
          'Á'=>'a','É'=>'e','Í'=>'i','Ó'=>'o','Ö'=>'o','Ő'=>'o','Ú'=>'u','Ü'=>'u','Ű'=>'u',
          ' ' => '-', '–'=>'-', '—'=>'-', '_'=>'-'];
  $s = strtr(trim($s), $map);
  $s = strtolower($s);
  $s = preg_replace('~[^a-z0-9\-]+~','',$s);
  return $s;
}
?>
<div class="donate-wrap">
    <h1>Adományozz szervezeteknek</h1>

    <style>
    :root {
        --accent: #ff6b6b;
        --accent2: #e65959;
        --ink: #000;
        --muted: #333;
        --card: #fff;
        --border: #eaeaea;
        --ring: rgba(255, 107, 107, .25);
        --orange: #ffa500;
    }

    body {
        color: #000;
    }

    .donate-wrap {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    /* felső sor: kereső + találatszám */
    .row {
        display: flex;
        gap: 12px;
        align-items: center;
        flex-wrap: wrap;
    }

    .row.spread {
        justify-content: space-between;
    }

    input[type="text"] {
        padding: 10px 12px;
        border: 1px solid var(--border);
        border-radius: 10px;
        outline: none;
        min-width: 280px;
    }

    input[type="text"]:focus {
        box-shadow: 0 0 0 4px var(--ring);
    }

    /* kategória gombok (pill) */
    #catpills {
        margin: 10px 0 12px;
    }

    .pill {
        padding: 8px 12px;
        border: 1px solid #dcdcdc;
        border-radius: 999px;
        background: #fff;
        color: #000;
        cursor: pointer;
        user-select: none;
    }

    .pill:hover {
        border-color: #c8c8c8;
    }

    .pill.active {
        background: #111;
        color: var(--orange);
        border-color: #444;
    }

    /* találatszám narancs */
    .results-count {
        color: var(--orange) !important;
        font-weight: 600;
    }

    /* kártyarács: több oszlop automatikusan */
    #targetList {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 16px;
        align-items: start;
        justify-items: stretch;
    }

    .card {
        background: var(--card);
        border: 1px solid var(--border);
        border-radius: 14px;
        padding: 14px;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .title {
        font-weight: 700;
    }

    .muted {
        color: var(--muted);
        font-size: 13px;
    }

    .tags {
        display: flex;
        gap: 6px;
        flex-wrap: wrap;
    }

    .tag {
        display: inline-block;
        background: #fff;
        color: #000;
        border: 1px solid #e1e1e1;
        border-radius: 999px;
        padding: 2px 8px;
        font-size: 12px;
    }

    .btn {
        padding: 10px 14px;
        border-radius: 10px;
        cursor: pointer;
        border: 1px solid #dcdcdc;
        background: #fff;
        color: #000;
        text-decoration: none;
        display: inline-block;
    }

    .btn:hover {
        border-color: #c8c8c8;
        box-shadow: 0 0 0 3px var(--ring);
    }

    .btn-primary {
        background: linear-gradient(180deg, var(--accent), var(--accent2));
        color: #fff;
        border: none;
    }

    .btn-disabled {
        opacity: .6;
        cursor: not-allowed;
    }

    /* üres találat */
    .empty {
        grid-column: 1/-1;
        padding: 12px;
        border: 1px dashed #ddd;
        border-radius: 10px;
        background: #fff;
    }

    /* Találatszám legyen nagyobb és narancssárga */
    .results-count {
        color: #ffa500;
        /* narancs */
        font-size: 18px;
        /* kicsit nagyobb */
        font-weight: 700;
        /* félkövér */
    }

    /* (opcionális) a keresőmező is legyen picit nagyobb */
    #q {
        padding: 12px 14px;
        font-size: 16px;
    }
    </style>

    <!-- kategória pillák (kattintásra AZONNAL szűr) -->
    <div id="catpills" class="row">
        <button class="pill active" data-cat="all">Összes</button>
        <button class="pill" data-cat="egeszseg">Egészség</button>
        <button class="pill" data-cat="oktatas">Oktatás</button>
        <button class="pill" data-cat="allatvedelem">Állatvédelem</button>
        <button class="pill" data-cat="kornyezet">Környezet</button>
        <button class="pill" data-cat="szocialis">Szociális</button>
        <button class="pill" data-cat="kultura">Kultúra</button>
        <button class="pill" data-cat="haborus-sebesultek">Háborús-sebesültek</button>
        <button class="pill" data-cat="egyeb">Egyéb</button>
    </div>

    <!-- kereső + találatszám -->
    <div class="row spread" style="margin:8px 0 14px;">
        <input id="q" type="text" placeholder="Keresés név, leírás, város…">
        <div class="muted results-count">
            <span id="resCount"><?= count($targets) ?></span> találat
        </div>
    </div>


    <!-- kártyák -->
    <div id="targetList">
        <?php
      if (!$targets){
        echo '<div class="empty">Jelenleg nincs megjeleníthető célpont.</div>';
      } else {
        foreach($targets as $t){
          $cat  = cat_slug($t['category'] ?? 'egyeb');
          $text = mb_strtolower( ($t['name']??'').' '.($t['description']??'').' '.($t['city']??'').' '.($t['country']??'') );
          $name = htmlspecialchars($t['name'] ?? '');
          $desc = htmlspecialchars($t['description'] ?? '');
          $city = htmlspecialchars($t['city'] ?? '');
          $country = htmlspecialchars($t['country'] ?? 'Magyarország');
          $site = htmlspecialchars($t['website_url'] ?? '#');
          $don  = htmlspecialchars($t['donate_url'] ?? '#');
          $isLogged = isset($_SESSION['uid']);
          ?>
        <div class="card target-card" data-cat="<?= $cat ?>"
            data-text="<?= htmlspecialchars(mb_strtolower($text), ENT_QUOTES) ?>">
            <div class="title"><?= $name ?></div>
            <?php if ($desc !== ''): ?><div class="muted"><?= $desc ?></div><?php endif; ?>

            <div class="tags">
                <span class="tag"><?= htmlspecialchars($t['category'] ?? 'Egyéb') ?></span>
                <?php if ($city !== ''): ?><span class="tag"><?= $city ?></span><?php endif; ?>
                <span class="tag"><?= $country ?></span>
            </div>

            <div class="row" style="justify-content:space-between;margin-top:6px;">
                <a class="btn" href="<?= $site ?>" target="_blank" rel="noopener">Honlap</a>

                <?php if ($isLogged && $don !== '#'): ?>
                <a class="btn btn-primary" href="<?= $don ?>" target="_blank" rel="noopener">Támogatom</a>
                <?php else: ?>
                <a class="btn btn-primary btn-disabled" href="javascript:void(0)"
                    onclick="alert('Csak bejelentkezett felhasználók tudnak támogatni!');">Támogatom</a>
                <?php endif; ?>
            </div>
        </div>
        <?php
        }
      }
    ?>
    </div>
</div>

<script>
(function() {
    const pills = Array.from(document.querySelectorAll('#catpills .pill'));
    const list = document.getElementById('targetList');
    const cards = Array.from(list.querySelectorAll('.target-card'));
    const cntEl = document.getElementById('resCount');
    const q = document.getElementById('q');

    let activeCat = 'all';
    let query = '';

    function matches(c) {
        const cat = c.getAttribute('data-cat') || 'egyeb';
        const text = c.getAttribute('data-text') || '';
        const okCat = (activeCat === 'all') || (cat === activeCat);
        const okText = !query || text.includes(query);
        return okCat && okText;
    }

    function render() {
        let vis = 0;
        cards.forEach(c => {
            const show = matches(c);
            c.style.display = show ? '' : 'none';
            if (show) vis++;
        });
        cntEl.textContent = vis;

        // ha nincs találat, tegyünk ki egy üzenetet
        let empty = list.querySelector('.empty');
        if (vis === 0) {
            if (!empty) {
                empty = document.createElement('div');
                empty.className = 'empty';
                empty.textContent = 'Nincs találat a megadott szűrőkre.';
                list.appendChild(empty);
            }
        } else {
            if (empty) empty.remove();
        }
    }

    pills.forEach(p => {
        p.addEventListener('click', () => {
            pills.forEach(x => x.classList.remove('active'));
            p.classList.add('active');
            activeCat = p.getAttribute('data-cat') || 'all';
            render();
        });
    });

    q.addEventListener('input', () => {
        query = q.value.trim().toLowerCase();
        render();
    });

    // első kirajzolás
    render();
})();
</script>