<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>2048 Game</title>
<style type="text/css">
/* 全域樣式 */
body {
	font-family: Arial, sans-serif;
	background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
	display: flex;
	justify-content: center;
	align-items: center;
	height: 80vh;
	margin: 0;
}

/* 遊戲容器 */
.game-container {
	text-align: center;
	background: white;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	max-width: 450px;
	width: 90%;
}

/* 標題 */
h1 {
	font-size: 32px;
	color: #333;
	margin-bottom: 20px;
}

/* 棋盤區 */
.board {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	grid-gap: 10px;
	margin-bottom: 20px;
	background: #bbada0;
	padding: 10px;
	border-radius: 10px;
}

/* 每個方塊 */
.tile {
	width: 80px;
	height: 80px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 32px;
	font-weight: bold;
	border-radius: 5px;
	background-color: #cdc1b4;
	color: #776e65;
	transition: 0.2s;
}

/* 控制按鈕 */
.controls button {
	font-size: 20px;
	padding: 10px;
	margin: 5px;
	background-color: #2980b9;
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: 0.3s;
}

.controls button:hover {
	background: #1f6692;
}
/* 一般按鈕 */
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

/* 返回首頁按鈕 */
.return-btn {
	margin-top: 20px;
	padding: 10px 20px;
	font-size: 18px;
	background-color: #8f7a66;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s;
}

.return-btn:hover {
	background-color: #b5a89e;
}

/* 顯示分數 */
.score {
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
}

/* 響應式設計 */
@media ( max-width : 480px) {
	.game-container {
		width: 95%;
		padding: 20px;
	}
	h1 {
		font-size: 24px;
	}
	.tile {
		width: 60px;
		height: 60px;
		font-size: 24px;
	}
	.controls button {
		font-size: 18px;
		padding: 8px 16px;
	}
}
</style>
</head>
<body>
	<div class="game-container">
		<h1>2048 Game</h1>

		<!-- 顯示分數 -->
		<div id="score" class="score">Score: 0</div>

		<!-- 顯示遊戲棋盤 -->
		<div id="board" class="board"></div>

		<!-- 遊戲控制按鈕 -->
		<div class="controls">
			<button id="up">↑</button>
			<button id="left">←</button>
			<button id="down">↓</button>
			<button id="right">→</button>
		</div>

		<!-- 重新開始遊戲的按鈕 -->
		<button id="resetBtn" class="controls">重新開始遊戲</button>

		<!-- 返回首頁的按鈕 -->
		<button
			onclick="window.location.href='VisitorCounterServlet?page=register/main.html'">回到首頁</button>
	</div>

	<script type="text/javascript">
        let grid = [
            [null, null, null, null],
            [null, null, null, null],
            [null, null, null, null],
            [null, null, null, null]
        ];

        function updateScore() {
            const score = getScore();
            document.getElementById("score").textContent = "Score: " + score;
        }

        function getScore() {
            let score = 0;
            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    if (grid[i][j]) {
                        score += grid[i][j];
                    }
                }
            }
            return score;
        }

        function renderBoard() {
            const board = document.getElementById("board");
            board.innerHTML = '';

            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    const tile = document.createElement("div");
                    tile.classList.add("tile");
                    tile.textContent = grid[i][j] ? grid[i][j] : '';
                    if (grid[i][j]) {
                        tile.style.backgroundColor = getTileColor(grid[i][j]);
                    }
                    board.appendChild(tile);
                }
            }

            updateScore();
        }

        function getTileColor(value) {
            switch (value) {
                case 2: return "#eee4da";
                case 4: return "#ede0c8";
                case 8: return "#f2b179";
                case 16: return "#f59563";
                case 32: return "#f67c5f";
                case 64: return "#f65e3b";
                case 128: return "#edcf72";
                case 256: return "#edcc61";
                case 512: return "#edc850";
                case 1024: return "#edc53f";
                case 2048: return "#edc22e";
                default: return "#cdc1b4";
            }
        }

        function generateNewTile() {
            let emptyCells = [];
            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    if (!grid[i][j]) {
                        emptyCells.push({ x: i, y: j });
                    }
                }
            }

            const randomCell = emptyCells[Math.floor(Math.random() * emptyCells.length)];
            grid[randomCell.x][randomCell.y] = Math.random() < 0.9 ? 2 : 4;
        }

        function arraysEqual(arr1, arr2) {
            if (arr1.length !== arr2.length) return false;
            for (let i = 0; i < arr1.length; i++) {
                if (arr1[i] !== arr2[i]) return false;
            }
            return true;
        }

        function isGameOver() {
            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    if (!grid[i][j]) {
                        return false;
                    }
                }
            }

            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    if (i < 3 && grid[i][j] === grid[i + 1][j]) return false;
                    if (j < 3 && grid[i][j] === grid[i][j + 1]) return false;
                }
            }

            return true;
        }

        function checkGameOver() {
            if (isGameOver()) {
                setTimeout(function() {
                    alert("遊戲結束！");
                    saveScore(); // 遊戲結束後保存分數
                }, 100);
            }
        }

     // 保存分數到伺服器
      function saveScore() {
		    const score = getScore();  // 獲取遊戲分數
		    const playerName = prompt("遊戲結束，請輸入您的名字：");
		
		    if (playerName) {
		        console.log("🚀 發送資料到後端:", { playerName, score });
		
		        fetch('ScoreServlet', {
		            method: 'POST',
		            headers: {
		                'Content-Type': 'application/json'  // 使用 JSON 格式
		            },
		            body: JSON.stringify({ playerName, score })  // 傳送 JSON 格式的資料
		        })
		        .then(response => {
		            console.log("💬 後端回應狀態:", response);  // 檢查後端回應狀態
		
		            if (!response.ok) {
		                throw new Error("後端回應非 200 狀態");
		            }
		
		            return response.json();  // 解析 JSON
		        })
		        .then(data => {
		            console.log("✅ 後端回應資料:", JSON.stringify(data));  // 使用 JSON.stringify 來檢查資料結構
		
		            // 檢查返回資料是否包含所有必需的字段
		            if (data && data.playerName && data.score && data.createdAt) {
		                let createdAt = new Date(data.createdAt).toLocaleString();  // 轉換時間格式
		
		                // 輸出資料檢查
		                console.log("創建時間:", createdAt);
		                console.log("玩家名稱:", data.playerName);
		                console.log("分數:", data.score);
		
		                // 額外檢查返回的值
		                console.log("playerName是否有效：", data.playerName !== undefined && data.playerName !== null);
		                console.log("score是否有效：", data.score !== undefined && data.score !== null);
		                console.log("createdAt是否有效：", data.createdAt !== undefined && data.createdAt !== null);
		
		                // 若資料有效，拼接 alert 顯示內容
		                const alertMessage = `🎉 分數保存成功！\n玩家：${data.playerName || '未知'}\n分數：${data.score || '無法顯示'}\n創建時間：${createdAt || '無法顯示'}`;
		
		                // 檢查要顯示的 alert 內容
		                console.log("將顯示的 alert 內容：", alertMessage);
		
		                // 彈出 alert 內容
		                alert(alertMessage);
		            } else {
		                alert("❌ 返回的數據格式不正確！");
		            }
		        })
		        .catch(error => {
		            console.error("❌ Fetch error:", error);
		            alert("儲存分數失敗： " + error.message);  // 顯示錯誤的詳細信息
		        });
		    } else {
		        alert("❌ 玩家名稱未輸入，無法儲存分數！");
		    }
		}

        function moveLeft() {
            let moved = false;
            for (let row = 0; row < 4; row++) {
                let newRow = grid[row].filter(val => val !== null);
                let mergedRow = [];

                for (let i = 0; i < newRow.length; i++) {
                    if (newRow[i] === newRow[i + 1]) {
                        mergedRow.push(newRow[i] * 2);
                        moved = true;
                        i++;
                    } else {
                        mergedRow.push(newRow[i]);
                    }
                }

                while (mergedRow.length < 4) {
                    mergedRow.push(null);
                }

                if (!arraysEqual(grid[row], mergedRow)) {
                    moved = true;
                }

                grid[row] = mergedRow;
            }

            if (moved) {
                generateNewTile();
                renderBoard();
                checkGameOver();
            }
        }

        function moveRight() {
            let moved = false;
            for (let row = 0; row < 4; row++) {
                let newRow = grid[row].filter(val => val !== null).reverse();
                let mergedRow = [];

                for (let i = 0; i < newRow.length; i++) {
                    if (newRow[i] === newRow[i + 1]) {
                        mergedRow.push(newRow[i] * 2);
                        moved = true;
                        i++;
                    } else {
                        mergedRow.push(newRow[i]);
                    }
                }

                while (mergedRow.length < 4) {
                    mergedRow.push(null);
                }

                mergedRow.reverse();

                if (!arraysEqual(grid[row], mergedRow)) {
                    moved = true;
                }

                grid[row] = mergedRow;
            }

            if (moved) {
                generateNewTile();
                renderBoard();
                checkGameOver();
            }
        }

        function moveUp() {
            let moved = false;
            for (let col = 0; col < 4; col++) {
                let newCol = [];
                for (let row = 0; row < 4; row++) {
                    if (grid[row][col]) newCol.push(grid[row][col]);
                }

                let mergedCol = [];

                for (let i = 0; i < newCol.length; i++) {
                    if (newCol[i] === newCol[i + 1]) {
                        mergedCol.push(newCol[i] * 2);
                        moved = true;
                        i++;
                    } else {
                        mergedCol.push(newCol[i]);
                    }
                }

                while (mergedCol.length < 4) {
                    mergedCol.push(null);
                }

                for (let i = 0; i < 4; i++) {
                    if (grid[i][col] !== mergedCol[i]) {
                        moved = true;
                    }
                    grid[i][col] = mergedCol[i];
                }
            }

            if (moved) {
                generateNewTile();
                renderBoard();
                checkGameOver();
            }
        }

        function moveDown() {
            let moved = false;
            for (let col = 0; col < 4; col++) {
                let newCol = [];
                for (let row = 3; row >= 0; row--) {
                    if (grid[row][col]) newCol.push(grid[row][col]);
                }

                let mergedCol = [];

                for (let i = 0; i < newCol.length; i++) {
                    if (newCol[i] === newCol[i + 1]) {
                        mergedCol.push(newCol[i] * 2);
                        moved = true;
                        i++;
                    } else {
                        mergedCol.push(newCol[i]);
                    }
                }

                while (mergedCol.length < 4) {
                    mergedCol.push(null);
                }

                mergedCol.reverse();

                for (let i = 0; i < 4; i++) {
                    if (grid[i][col] !== mergedCol[i]) {
                        moved = true;
                    }
                    grid[i][col] = mergedCol[i];
                }
            }

            if (moved) {
                generateNewTile();
                renderBoard();
                checkGameOver();
            }
        }

        document.addEventListener("keydown", function(event) {
            switch (event.key) {
                case "ArrowUp": moveUp(); break;
                case "ArrowDown": moveDown(); break;
                case "ArrowLeft": moveLeft(); break;
                case "ArrowRight": moveRight(); break;
            }
        });

        document.getElementById("up").addEventListener("click", moveUp);
        document.getElementById("left").addEventListener("click", moveLeft);
        document.getElementById("down").addEventListener("click", moveDown);
        document.getElementById("right").addEventListener("click", moveRight);

        document.getElementById("resetBtn").addEventListener("click", function() {
            grid = [
                [null, null, null, null],
                [null, null, null, null],
                [null, null, null, null],
                [null, null, null, null]
            ];
            generateNewTile();
            generateNewTile();
            renderBoard();
        });

        generateNewTile();
        generateNewTile();
        renderBoard();
    </script>
</body>
</html>