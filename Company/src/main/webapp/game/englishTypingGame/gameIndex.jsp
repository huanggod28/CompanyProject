<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>遊戲操作說明</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        header {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
        }

        .content {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        p {
            font-size: 16px;
            line-height: 1.6;
            color: #555;
        }

        ul {
            font-size: 16px;
            color: #555;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .back-btn:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <header>
        <h1>英打遊戲操作說明</h1>
    </header>

    <div class="content">
        <h2>遊戲規則</h2>
        <p>在這個遊戲中，你將看到隨機出現的英文字母 (a-z)。你需要在 2 秒內，使用鍵盤輸入對應的字母來消除它們。</p>
        <p>每成功消除一個字母，新的字母會馬上出現，直到遊戲結束。遊戲結束的條件是當某個字母超過 2 秒未被消除。</p>

        <h2>操作說明</h2>
        <ul>
            <li>使用鍵盤上的字母鍵（a-z）來輸入對應的字母。</li>
            <li>每成功消除一個字母，遊戲會顯示新的字母，並繼續倒計時。</li>
            <li>如果你在 2 秒內沒有輸入正確的字母，遊戲會結束。</li>
            <li>遊戲結束後，你會看到你的最佳成績和排行榜。</li>
        </ul>

        <h2>遊戲目標</h2>
        <p>你的目標是成功消除盡可能多的字母，並在有限的時間內達成高分！</p>

        
        <button class="back-btn" onclick="window.location.href='VisitorCounterServlet?page=game/englishTypingGame/game.jsp'">開始遊戲</button>
    	<button class="back-btn" onclick="window.location.href='VisitorCounterServlet?page=game/gameList.jsp'">返回主頁</button>
    </div>
</body>
</html>