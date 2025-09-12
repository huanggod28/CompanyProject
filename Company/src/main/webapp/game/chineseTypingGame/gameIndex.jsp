<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>遊戲說明 - 注音打字訓練遊戲</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
            background-color: #e0f7fa;
            padding: 20px;
        }
        h1 {
            color: #00796b;
            font-size: 40px;
            margin-bottom: 20px;
        }
        h2 {
            color: #00796b;
            font-size: 30px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            color: #00796b;
            line-height: 1.6;
        }
        .btn {
            font-size: 20px;
            padding: 10px 20px;
            background-color: #00796b;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 20px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>
    <h1>遊戲說明 - 注音打字訓練遊戲</h1>
    <h2>如何遊玩：</h2>
    <p>
        1. 當你進入遊戲後，畫面會隨機顯示一個注音符號（例如：ㄅ、ㄆ、ㄇ等）以及可能的聲調符號（ˇ、ˋ、ˊ、˙）。<br>
        2. 你需要在畫面上顯示的符號消失前，根據鍵盤上的對應鍵來輸入正確的符號（例如：如果畫面顯示的是「ㄅ」，你需要按下「1」鍵）。<br>
        3. 如果你在2秒內輸入正確，符號會被消除，並會增加分數；如果錯誤或超過時間，遊戲會結束。<br>
        4. 隨著遊戲進行，新的符號會出現，並且會越來越快，挑戰你的反應速度。<br>
        5. 當遊戲結束時，你的得分與遊戲時間將顯示在結果頁面。<br>
        6. 可以隨時重新開始遊戲！
    </p>
    
    <h2>操作說明：</h2>
    <p>
        - 按下鍵盤對應的字母鍵來消除畫面上的注音符號。<br>
        - 遊戲會在2秒鐘內等待你的輸入，未輸入或輸入錯誤將結束當前的遊戲。<br>
        - 每正確消除一次符號，你會獲得1分。
    </p>
    
    <button class="btn" onclick="window.location.href='VisitorCounterServlet?page=game/chineseTypingGame/game.jsp'">開始遊戲</button>
    <button class="btn" onclick="window.location.href='VisitorCounterServlet?page=game/gameList.jsp'">返回主頁</button>
</body>
</html>