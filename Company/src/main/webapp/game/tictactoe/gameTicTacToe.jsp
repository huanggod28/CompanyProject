<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>井字遊戲</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #2c3e50;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        td {
            width: 33%;
            height: 100px;
            border: 2px solid #2c3e50;
            font-size: 2rem;
            text-align: center;
            cursor: pointer;
            background-color: #ecf0f1;
        }
        td:hover {
            background-color: #bdc3c7;
        }
        button {
            padding: 10px 20px;
            background-color: #e76f51;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #f39c12;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>井字遊戲</h1>
        <h3>
            當前玩家：<span id="currentPlayer">${currentPlayer}</span>
        </h3>
        <div id="gameOverMessage"></div>
        <div id="gameBoardContainer"></div>
        <button onclick="resetGame()">重新開始</button>
    </div>

    <script>
        function renderBoard(board) {
            const container = document.getElementById("gameBoardContainer");
            let html = '<table>';
            for (let i = 0; i < 3; i++) {
                html += '<tr>';
                for (let j = 0; j < 3; j++) {
                    html += `<td id="cell-${i}-${j}" onclick="makeMove(${i}, ${j})">${board[i][j] || ""}</td>`;
                }
                html += '</tr>';
            }
            html += '</table>';
            container.innerHTML = html;
        }

        function updateBoard(board, currentPlayer, gameOver) {
            console.log("更新棋盤：", board);
            renderBoard(board);

            const currentPlayerSpan = document.getElementById("currentPlayer");
            if (currentPlayerSpan) {
                currentPlayerSpan.innerText = currentPlayer;
            }

            const gameOverDiv = document.getElementById("gameOverMessage");
            gameOverDiv.innerHTML = gameOver ? "<h2>遊戲結束！</h2>" : "";
        }

        function makeMove(row, col) {
            console.log("makeMove called with:", row, col);

            const formData = new URLSearchParams();
            formData.append("action", "move");
            formData.append("row", row);
            formData.append("col", col);

            fetch("TicTacToeServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: formData.toString()
            })
            .then(response => {
                if (!response.ok) throw new Error("伺服器錯誤：" + response.status);
                return response.json();
            })
            .then(data => {
                console.log("✅ 收到資料：", data);
                console.log("📦 board：", data.board);
                updateBoard(data.board, data.currentPlayer, data.gameOver);
            })
            .catch(error => console.error("請求失敗:", error));
        }

        function resetGame() {
            fetch("TicTacToeServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "action=reset"
            })
            .then(response => response.json())
            .then(data => updateBoard(data.board, data.currentPlayer, data.gameOver))
            .catch(error => console.error("重置失敗:", error));
        }

        // 初始化
        window.onload = () => {
            fetch("TicTacToeServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "action=init"  // 只發送 action=init
            })
            .then(response => response.json())
            .then(data => {
                console.log("📥 初始化資料：", data);
                updateBoard(data.board, data.currentPlayer, data.gameOver);
            })
            .catch(error => console.error("初始化失敗:", error));
        };
    </script>
</body>
</html>