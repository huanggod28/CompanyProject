<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>注音打字遊戲</title>
    <style>
        body { text-align: center; font-family: Arial, sans-serif; background-color: #e0f7fa; }
        canvas { border: 2px solid black; margin-top: 20px; background-color: #f0f0f0; }
        h1 { color: #00796b; font-size: 40px; margin-bottom: 20px; }
        h2, h3 { color: #00796b; font-size: 24px; }
        #score { font-size: 24px; font-weight: bold; }
        #timer { font-size: 20px; }
        #status { font-size: 22px; color: red; margin-top: 20px; }
        #gameButtons { margin-top: 20px; }
        button { font-size: 18px; padding: 10px 20px; cursor: pointer; background-color: #00796b; color: white; border: none; border-radius: 5px; }
        button:hover { background-color: #004d40; }
        .instructions-link {
            font-size: 18px;
            color: #00796b;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
        }
        .instructions-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>注音打字訓練遊戲</h1>
    <h2>按鍵盤對應的注音符號來消除字母</h2>
    <h3 id="score">得分: 0</h3>
    <canvas id="gameCanvas" width="500" height="300" tabindex="0"></canvas>
    <h3 id="timer">時間: 0 秒</h3>
    <h3 id="status"></h3>
    <div id="gameButtons">
        <button id="startButton" onclick="startGame()">開始遊戲</button>
        <button id="resetButton" onclick="resetGame()" style="display:none;">重新開始</button>
    </div>
    <a href="VisitorCounterServlet?page=game/chineseTypingGame/gameIndex.jsp" class="instructions-link">遊戲操作說明</a>
    <form action="ChineseTypingServlet" method="post">
        <input type="hidden" name="score" id="finalScore">
        <input type="hidden" name="time" id="finalTime">
        <button type="submit" id="submitResult" style="display:none;">提交成績</button>
    </form>

    <script>
        const canvas = document.getElementById("gameCanvas");
        const ctx = canvas.getContext("2d");

        const zhuyin = ["ㄅ","ㄆ","ㄇ","ㄈ","ㄉ","ㄊ","ㄋ","ㄌ","ㄍ","ㄎ","ㄏ","ㄐ","ㄑ","ㄒ","ㄓ","ㄔ","ㄕ","ㄖ","ㄗ","ㄘ","ㄙ","ㄧ","ㄨ","ㄩ","ㄚ","ㄛ","ㄜ","ㄝ","ㄞ","ㄟ","ㄠ","ㄡ","ㄢ","ㄣ","ㄤ","ㄥ","ㄦ"];
        const tones = ["ˇ", "ˋ", "ˊ", "˙"];
        const keyMap = {
            'ㄅ': '1', 'ㄆ': 'q', 'ㄇ': 'a', 'ㄈ': 'z',
            'ㄉ': '2', 'ㄊ': 'w', 'ㄋ': 's', 'ㄌ': 'x',
            'ㄍ': 'e', 'ㄎ': 'd', 'ㄏ': 'c',
            'ㄐ': 'r', 'ㄑ': 'f', 'ㄒ': 'v',
            'ㄓ': '5', 'ㄔ': 't', 'ㄕ': 'g', 'ㄖ': 'b',
            'ㄗ': 'y', 'ㄘ': 'h', 'ㄙ': 'n',
            'ㄧ': 'u', 'ㄨ': 'j', 'ㄩ': 'm',
            'ㄚ': '8', 'ㄛ': 'i', 'ㄜ': 'k', 'ㄝ': ',',
            'ㄞ': '9', 'ㄟ': 'o', 'ㄠ': 'l', 'ㄡ': '.',
            'ㄢ': '0', 'ㄣ': 'p', 'ㄤ': ';', 'ㄥ': '/', 'ㄦ': '-',
            'ˇ': '3', 'ˋ': '4', 'ˊ': '6', '˙': '7'
        };

        let currentChar = "";
        let score = 0;
        let startTime = 0;
        let gameInterval;
        let timeout;
        let gameInProgress = false;

        function getRandomChar() {
            return Math.random() > 0.7 ? tones[Math.floor(Math.random() * tones.length)] : zhuyin[Math.floor(Math.random() * zhuyin.length)];
        }

        function drawCharacter() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.font = "60px Arial";
            ctx.fillStyle = "#000";
            ctx.fillText(currentChar, canvas.width / 2 - ctx.measureText(currentChar).width / 2, canvas.height / 2 + 20);
        }

        function startGame() {
            if (gameInProgress) return;
            canvas.focus();

            score = 0;
            document.getElementById("score").innerText = "得分: 0";
            document.getElementById("status").innerText = "";
            currentChar = getRandomChar();
            drawCharacter();
            startTime = Date.now();
            gameInProgress = true;

            document.getElementById("startButton").style.display = "none";
            document.getElementById("resetButton").style.display = "inline-block";

            gameInterval = setInterval(() => {
                let elapsed = Math.floor((Date.now() - startTime) / 1000);
                document.getElementById("timer").innerText = "時間: " + elapsed + " 秒";
            }, 1000);

            nextCharacter();
        }

        function nextCharacter() {
            clearTimeout(timeout);
            timeout = setTimeout(endGame, 2000);
            currentChar = getRandomChar();
            drawCharacter();
        }

        function checkInput(event) {
            if (!gameInProgress) return;
            const pressedKey = event.key.toLowerCase();
            const expectedKey = keyMap[currentChar];

            if (pressedKey === expectedKey) {
                score++;
                document.getElementById("score").innerText = "得分: " + score;
                nextCharacter();
            } else {
                endGame();
            }
        }

        function endGame() {
            clearInterval(gameInterval);
            clearTimeout(timeout);
            gameInProgress = false;
            document.getElementById("status").innerText = "遊戲結束！你失敗了！";
            document.getElementById("finalScore").value = score;
            document.getElementById("finalTime").value = Math.floor((Date.now() - startTime) / 1000);
            document.getElementById("submitResult").style.display = "block";
        }

        function resetGame() {
            document.getElementById("submitResult").style.display = "none";
            startGame();
        }

        window.addEventListener("keydown", checkInput);
    </script>
</body>
</html>