<?php if (session_status()===PHP_SESSION_NONE) session_start(); ?>
<div style="max-width:900px;margin:0 auto;padding:20px;">
  <h1 style="color:#fd7015;margin-bottom:10px;">Események</h1>
  <div class="muted" style="margin-bottom:14px;">A lista automatikusan frissül. Mindig a legközelebbi 6 jövőbeli eseményt látod.</div>

  <style>
    :root { --accent:#fd7015; }
    .muted{ color:#bbb; }
    .grid{ display:grid; grid-template-columns:1fr; gap:12px; }
    @media (min-width:800px){ .grid{ grid-template-columns:1fr 1fr; } }
    .card{ background:#1f1f1f; border:1px solid #333; border-radius:12px; padding:14px; color:#fff; }
    .row{ display:flex; align-items:center; justify-content:space-between; gap:8px; flex-wrap:wrap; }
    .badge{ display:inline-block; background:#111; color:#ffa500; border:1px solid #333; border-radius:999px; padding:2px 8px; font-size:12px; }
    .btn{ padding:8px 12px; border-radius:10px; border:1px solid #444; background:#111; color:#fff; cursor:pointer; }
    .btn-primary{ background:linear-gradient(180deg,#ff7a1a,#e86d12); border:none; color:#fff; }
    .btn[disabled]{ opacity:.6; cursor:not-allowed; }
  </style>

  <div id="events" class="grid"></div>
</div>

<script>
async function fetchEvents(){
  const r = await fetch('events_api.php',{cache:'no-store'});
  if(!r.ok) return;
  const data = await r.json();
  const wrap = document.getElementById('events');
  wrap.innerHTML = '';
  (data.events || []).forEach(ev=>{
    const start = new Date(ev.start_at.replace(' ','T'));
    const end   = new Date(ev.end_at.replace(' ','T'));
    const time  = start.toLocaleString('hu-HU', { dateStyle:'medium', timeStyle:'short' }) +
                  ' – ' + end.toLocaleTimeString('hu-HU', { timeStyle:'short' });

    const left  = Math.max(0, ev.capacity - ev.reg_cnt);
    const youIn = !!ev.is_registered;

    const card = document.createElement('div');
    card.className='card';
    card.innerHTML = `
      <div style="font-weight:700;margin-bottom:4px;">${ev.title}</div>
      <div class="muted" style="margin-bottom:6px;">${ev.cities || ''} • ${time}</div>
      <div style="margin-bottom:8px;">${ev.description || ''}</div>
      <div class="row">
        <span class="badge">Férőhely: ${ev.capacity} • Szabad: ${left}</span>
        <div>
          ${youIn
            ? `<button class="btn" data-type="unreg" data-id="${ev.id}">Visszamondom</button>`
            : `<button class="btn btn-primary" ${left===0?'disabled':''} data-type="reg" data-id="${ev.id}">Jelentkezem</button>`}
        </div>
      </div>
    `;
    wrap.appendChild(card);
  });
}
async function regAction(type, id){
  const url = type==='reg' ? 'event_register.php' : 'event_unregister.php';
  const fd = new FormData(); fd.append('event_id', id);
  const r = await fetch(url,{ method:'POST', body:fd });
  if(!r.ok){
    const t = await r.text();
    alert('Hiba: '+t);
  }
  await fetchEvents();
}
document.addEventListener('click', (e)=>{
  const btn = e.target.closest('button[data-type]');
  if(!btn) return;
  regAction(btn.dataset.type, btn.dataset.id);
});

//első betöltés + 60 mp-enként frissítés
fetchEvents();
setInterval(fetchEvents, 60000);
</script>
