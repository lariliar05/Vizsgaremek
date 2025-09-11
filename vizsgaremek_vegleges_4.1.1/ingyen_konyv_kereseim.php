<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
require_once "kapcsolat.php";
mysqli_set_charset($adb, "utf8mb4");
mysqli_select_db($adb, "kl_registration");

if (!isset($_SESSION['uid'])) { header("Location: ./?p=login"); exit; }
$uid=(int)$_SESSION['uid'];

$sql="SELECT r.id, r.created_at, r.message, r.email, r.phone,
             b.title, b.author, b.city, b.status
      FROM free_book_requests r
      JOIN free_books b ON b.id=r.book_id
      WHERE r.requester_user_id=?
      ORDER BY r.created_at DESC";
$stmt=mysqli_prepare($adb,$sql);
mysqli_stmt_bind_param($stmt,"i",$uid);
mysqli_stmt_execute($stmt);
$res=mysqli_stmt_get_result($stmt);
$rows=[]; while($res && ($r=mysqli_fetch_assoc($res))){ $rows[]=$r; }
mysqli_stmt_close($stmt);
?>
<div style="max-width:1000px;margin:0 auto;padding:20px;">
    <h1>Saját igényléseim</h1>
    <style>
    :root {
        --border: #eaeaea;
    }

    body {
        color: #000;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
    }

    th,
    td {
        padding: 10px;
        border-bottom: 1px solid var(--border);
        text-align: left;
    }

    th {
        background: #fafafa;
    }

    .badge {
        display: inline-block;
        padding: 2px 8px;
        border-radius: 999px;
        border: 1px solid #ddd;
        font-size: 12px;
    }
    </style>

    <?php if (!$rows): ?>
    <div style="background:#fff;border:1px solid #eaeaea;border-radius:10px;padding:14px;">Még nem küldtél igénylést.
    </div>
    <?php else: ?>
    <table>
        <thead>
            <tr>
                <th>Dátum</th>
                <th>Könyv</th>
                <th>Város</th>
                <th>Állapot</th>
                <th>Üzenet</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($rows as $r): ?>
            <tr>
                <td><?= htmlspecialchars($r['created_at']) ?></td>
                <td><?= htmlspecialchars($r['title']) ?> <span style="color:#555;font-size:12px;">—
                        <?= htmlspecialchars($r['author']??'') ?></span></td>
                <td><?= htmlspecialchars($r['city']??'') ?></td>
                <td>
                    <span class="badge">
                        <?= $r['status']==='available'?'Elvihető':($r['status']==='reserved'?'Foglalt':'Elvitték') ?>
                    </span>
                </td>
                <td><?= nl2br(htmlspecialchars($r['message']??'')) ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <?php endif; ?>
</div>