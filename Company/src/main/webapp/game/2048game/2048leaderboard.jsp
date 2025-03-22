<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaderboard</title>
    <style>
        body {
            background: linear-gradient(to bottom, #E3F2FD, #FFFFFF);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            text-align: center;
            color: #003366;
        }

        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #FFFFFF;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #0277BD;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        h1 {
            color: #0277BD;
            font-size: 36px;
            margin-bottom: 20px;
        }

        button {
            background: #2980b9;
            color: white;
            font-size: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #1f6692;
        }

        td {
            background-color: #FAFAFA;
        }
    </style>
</head>
<body>
    <h1>排行榜</h1>
    <table>
        <thead>
            <tr>
                <th>排名</th>
                <th>玩家名稱</th>
                <th>分數</th>
                <th>創建時間</th>
            </tr>
        </thead>
        <tbody id="leaderboard">
            <!-- 這裡會動態插入排行榜數據 -->
        </tbody>
    </table>
    <div class="game-container">
        <button onclick="window.location.href='VisitorCounterServlet?page=game/2048game/game.jsp'">開始遊戲</button>
    </div>

    <script type="text/javascript">
        window.onload = function() {
            fetch("ScoreServlet")
                .then(response => response.json())  // 確保返回的是 JSON
                .then(data => {
                    console.log("Leaderboard response data:", data);

                    try {
                        const leaderboard = document.getElementById("leaderboard");
                        leaderboard.innerHTML = "";  // 每次加載時清空表格內容

                        // 根據分數對數據進行排序
                        const sortedData = data.sort((a, b) => b.score - a.score);

                        // 動態創建表格行
                        sortedData.forEach((player, index) => {
                            const createdAt = new Date(player.createdAt).toLocaleString("zh-TW", { timeZone: "Asia/Taipei" });

                            // 動態創建 tr 和 td 元素
                            const row = document.createElement("tr");

                            // 創建並插入 td 元素
                            const rankCell = document.createElement("td");
                            rankCell.textContent = index + 1;  // 顯示排名

                            const nameCell = document.createElement("td");
                            nameCell.textContent = player.playerName;

                            const scoreCell = document.createElement("td");
                            scoreCell.textContent = player.score;

                            const createdAtCell = document.createElement("td");
                            createdAtCell.textContent = createdAt;

                            // 將 td 元素附加到 tr 中
                            row.appendChild(rankCell);
                            row.appendChild(nameCell);
                            row.appendChild(scoreCell);
                            row.appendChild(createdAtCell);

                            // 將 tr 元素附加到表格中
                            leaderboard.appendChild(row);
                        });
                    } catch (error) {
                        console.error("Error parsing data:", error);
                        alert("資料解析失敗！");
                    }
                })
                .catch(error => {
                    console.error("Error loading leaderboard:", error);
                    alert("載入排行榜失敗！");
                });
        };
    </script>
</body>
</html>