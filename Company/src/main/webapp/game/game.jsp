<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        @media (max-width: 480px) {
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
        <button onclick="window.location.href='VisitorCounterServlet?page=register/main.html'">回到首頁</button>
    </div>

    <script type="text/javascript">
        // 初始化 4x4 的格子
        let grid = [
            [null, null, null, null],
            [null, null, null, null],
            [null, null, null, null],
            [null, null, null, null]
        ];

        // 更新分數顯示
        function updateScore() {
            const score = getScore();
            document.getElementById("score").textContent = "Score: " + score;
        }

        // 計算當前分數
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

        // 渲染棋盤
        function renderBoard() {
            const board = document.getElementById("board");
            board.innerHTML = ''; // 清空棋盤內容

            // 當前棋盤上每個格子
            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    const tile = document.createElement("div");
                    tile.classList.add("tile");
                    tile.textContent = grid[i][j] ? grid[i][j] : '';  // 顯示數字
                    if (grid[i][j]) {
                        tile.style.backgroundColor = getTileColor(grid[i][j]);
                    }
                    board.appendChild(tile);
                }
            }

            // 更新分數
            updateScore();
        }

        // 根據數字設置方塊顏色
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

        // 生成新方塊
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
            grid[randomCell.x][randomCell.y] = Math.random() < 0.9 ? 2 : 4; // 新方塊設為 2 或 4
        }

        // 比較兩個陣列是否相等
        function arraysEqual(arr1, arr2) {
            if (arr1.length !== arr2.length) return false;
            for (let i = 0; i < arr1.length; i++) {
                if (arr1[i] !== arr2[i]) return false;
            }
            return true;
        }

        // 檢查遊戲是否結束
        function isGameOver() {
            // 檢查是否有空格
            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    if (!grid[i][j]) {
                        return false; // 還有空格，遊戲繼續
                    }
                }
            }

            // 檢查是否有相鄰的方塊可以合併
            for (let i = 0; i < 4; i++) {
                for (let j = 0; j < 4; j++) {
                    if (i < 3 && grid[i][j] === grid[i + 1][j]) return false; // 上下方塊可以合併
                    if (j < 3 && grid[i][j] === grid[i][j + 1]) return false; // 左右方塊可以合併
                }
            }

            return true; // 沒有可合併的方塊或空格，遊戲結束
        }

        // 檢查遊戲是否結束並顯示訊息
        function checkGameOver() {
            if (isGameOver()) {
                setTimeout(function() {
                    alert("遊戲結束！"); // 遊戲結束時顯示訊息
                }, 100);
            }
        }

        function moveLeft() {
            let moved = false;
            for (let row = 0; row < 4; row++) {
                let newRow = grid[row].filter(val => val !== null); // 移除空格
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
                checkGameOver(); // 檢查遊戲是否結束
            }
        }

        function moveRight() {
            let moved = false;
            for (let row = 0; row < 4; row++) {
                let newRow = grid[row].filter(val => val !== null).reverse(); // 先反轉行
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

                mergedRow.reverse(); // 再反轉回來

                if (!arraysEqual(grid[row], mergedRow)) {
                    moved = true;
                }

                grid[row] = mergedRow;
            }

            if (moved) {
                generateNewTile();
                renderBoard();
                checkGameOver(); // 檢查遊戲是否結束
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
                checkGameOver(); // 檢查遊戲是否結束
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

                mergedCol.reverse(); // 反轉

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
                checkGameOver(); // 檢查遊戲是否結束
            }
        }

        // 處理控制鍵
        document.getElementById("up").addEventListener("click", moveUp);
        document.getElementById("left").addEventListener("click", moveLeft);
        document.getElementById("down").addEventListener("click", moveDown);
        document.getElementById("right").addEventListener("click", moveRight);

        // 初始化遊戲
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
            checkGameOver(); // 重新開始後檢查遊戲結束
        });

        // 開始遊戲
        generateNewTile();
        generateNewTile();
        renderBoard();
    </script>
</body>
</html>