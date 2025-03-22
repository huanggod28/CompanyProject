<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>777 拉霸機 遊戲說明</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
            color: #333;
            text-align: center;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #d4af37; /* 金色 */
        }

        h2 {
            color: #007BFF; /* 藍色 */
            margin-top: 15px;
        }

        ul {
            text-align: left;
            padding-left: 20px;
        }

        li {
            margin-bottom: 10px;
        }

        a {
            color: #007BFF;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .play-button {
            margin-top: 20px;
            display: inline-block;
            background: #007BFF;
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            border-radius: 10px;
            transition: background 0.3s, transform 0.2s;
            text-decoration: none;
        }

        .play-button:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎰 歡迎來到 777 拉霸機！</h1>
        <p>這是一款簡單又刺激的拉霸機遊戲，試試你的運氣吧！</p>
        
        <h2>📜 遊戲規則</h2>
        <ul>
            <li>初始金額：<b>100</b></li>
            <li>單次投注金額：<b>10</b>，可選擇倍率（x1, x2, x3, x5, x10）</li>
            <li>按下「開始遊戲」後，拉霸機會轉動，最後定格在三個符號上。</li>
            <li>當三個符號相同時，將獲得獎勵！</li>
        </ul>

        <h2>🏆 中獎條件</h2>
        <ul>
            <li>三個相同符號：獲得投注金額的 <b>3 倍</b></li>
            <li>三個「7️⃣」：獲得投注金額的 <b>5 倍</b></li>
            <li>其他組合：未中獎</li>
        </ul>

        <h2>🎮 操作方式</h2>
        <ul>
            <li>選擇下注金額和倍率</li>
            <li>點擊「開始遊戲」</li>
            <li>等待 2 秒，查看結果</li>
            <li>中獎時會顯示「🎉 恭喜中獎！」</li>
            <li>未中獎時則顯示「😢 好可惜，下次一定中獎！」</li>
        </ul>

        <h2>🔗 進入遊戲</h2>
        <a href="VisitorCounterServlet?page=game/777game/game777.jsp" class="play-button">🎮 進入遊戲</a>
    </div>
</body>
</html>