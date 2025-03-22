<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2048 Game</title>
    <style type="text/css">
    	/* 全域樣式設定 */
		body {
		    font-family: Arial, sans-serif;
		    background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    height: 100vh;
		    margin: 0;
		}
		
		/* 遊戲容器樣式 */
		.game-container {
		    text-align: center;
		    background: white;
		    padding: 30px;
		    border-radius: 15px;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
		    max-width: 400px;
		    width: 90%;
		}
		
		/* 標題樣式 */
		h1 {
		    font-size: 32px;
		    color: #333;
		    margin-bottom: 20px;
		}
		
		/* 按鈕樣式 */
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
		
		/* 響應式設計 */
		@media (max-width: 480px) {
		    .game-container {
		        width: 95%;
		        padding: 20px;
		    }
		
		    h1 {
		        font-size: 24px;
		    }
		
		    button {
		        font-size: 18px;
		        padding: 8px 16px;
		    }
		}
    </style>
</head>
<body>
    <div class="game-container">
        <h1>2048 Game</h1>
        <button onclick="window.location.href='VisitorCounterServlet?page=game/2048game/game.jsp'">開始遊戲</button>
        <button onclick="window.location.href='VisitorCounterServlet?page=game/2048game/2048leaderboard.jsp'">排行榜</button>
    </div>
</body>
</html>