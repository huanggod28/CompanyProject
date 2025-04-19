<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>井字遊戲介紹</title>
<link rel="stylesheet" href="style.css">
<script>
	//儲存所有語言版本的內容
	const translations = {
	    "zh-TW": {
	        "title": "歡迎來到井字遊戲！",
	        "intro": "井字遊戲是一款經典的兩人遊戲，玩家輪流在 3x3 的棋盤中放置「X」或「O」，目標是完成橫向、縱向或對角線的三個同樣符號。",
	        "rules": [
	            "玩家和電腦輪流在棋盤上放置「X」或「O」。",
	            "玩家或電腦首先完成一條橫向、縱向或對角線的三個符號，即為勝利。",
	            "如果棋盤已滿且無人獲勝，則遊戲為平局。",
	            "當有玩家獲勝時，會顯示「玩家獲勝」或「電腦獲勝」的提示。",
	            "如果您選擇單人遊玩，電腦會智能防守並嘗試勝出。"
	        ],
	        "operations": [
	            "在遊戲中，您可以使用滑鼠點擊棋盤上的空白格子來放置您的「X」或「O」。每次輪到您時，棋盤上會顯示您選擇的符號。請注意：",
	            "玩家（「X」）先行，電腦（「O」）則會根據情況作出最佳回應。",
	            "每當遊戲結束後，您可以選擇重新開始。"
	        ],
	        "backToGame": "開始遊戲"
	    },
	    "zh-CN": {
	        "title": "欢迎来到井字游戏！",
	        "intro": "井字游戏是一款经典的两人游戏，玩家轮流在 3x3 的棋盘中放置「X」或「O」，目标是完成横向、纵向或对角线的三个相同符号。",
	        "rules": [
	            "玩家和电脑轮流在棋盘上放置「X」或「O」。",
	            "玩家或电脑首先完成一条横向、纵向或对角线的三个符号，即为胜利。",
	            "如果棋盘已满且无人获胜，则游戏为平局。",
	            "当有玩家获胜时，会显示「玩家获胜」或「电脑获胜」的提示。",
	            "如果您选择单人游戏，电脑会智能防守并尝试胜出。"
	        ],
	        "operations": [
	            "在游戏中，您可以使用鼠标点击棋盘上的空白格子来放置您的「X」或「O」。每次轮到您时，棋盘上会显示您选择的符号。请注意：",
	            "玩家（「X」）先行，电脑（「O」）则会根据情况作出最佳回应。",
	            "每当游戏结束后，您可以选择重新开始。"
	        ],
	        "backToGame": "开始游戏"
	    },
	    "en": {
	        "title": "Welcome to Tic-Tac-Toe!",
	        "intro": "Tic-Tac-Toe is a classic two-player game where players take turns placing 'X' or 'O' on a 3x3 grid. The goal is to complete a line of three matching symbols horizontally, vertically, or diagonally.",
	        "rules": [
	            "Players take turns placing 'X' or 'O' on the board.",
	            "The first player to complete a row, column, or diagonal with three matching symbols wins.",
	            "If the board is full and no one wins, the game is a tie.",
	            "When someone wins, the message 'Player Wins' or 'Computer Wins' will be displayed.",
	            "If you play single-player mode, the computer will intelligently defend and try to win."
	        ],
	        "operations": [
	            "In the game, you can click on an empty cell on the board to place your 'X' or 'O'. Each time it's your turn, the board will show your chosen symbol. Please note:",
	            "Player ('X') goes first, and the computer ('O') will make the best move.",
	            "After the game ends, you can choose to restart."
	        ],
	        "backToGame": "Start to Game"
	    }
	};
	
	// 切換語言
	function changeLanguage() {
	    const lang = document.getElementById('language').value;
	    const translation = translations[lang];
	
	    // 更新頁面內容
	    document.querySelector('h1').textContent = translation.title;
	    document.querySelector('.game-introduction h2').textContent = 'Game Introduction';
	    document.querySelector('.game-introduction p').textContent = translation.intro;
	    
	    const rulesList = document.querySelector('.game-rules ul');
	    rulesList.innerHTML = '';
	    translation.rules.forEach(rule => {
	        const li = document.createElement('li');
	        li.textContent = rule;
	        rulesList.appendChild(li);
	    });
	
	    const operationsList = document.querySelector('.game-operations ul');
	    operationsList.innerHTML = '';
	    translation.operations.forEach(op => {
	        const li = document.createElement('li');
	        li.textContent = op;
	        operationsList.appendChild(li);
	    });
	
	    document.querySelector('.back-to-game button').textContent = translation.backToGame;
	}    
</script>
</head>
<body>
	<!-- 語言選擇 -->
	<div class="language-selector">
		<label for="language">選擇語言:</label> <select id="language"
			onchange="changeLanguage()">
			<option value="zh-TW">繁體中文</option>
			<option value="zh-CN">簡體中文</option>
			<option value="en">English</option>
		</select>
	</div>

	<div class="intro-container">
		<h1>歡迎來到井字遊戲！</h1>

		<section class="game-introduction">
			<h2>遊戲簡介</h2>
			<p>井字遊戲是一款經典的兩人遊戲，玩家輪流在 3x3 的棋盤中放置「X」或「O」，目標是完成橫向、縱向或對角線的三個同樣符號。</p>
		</section>

		<section class="game-rules">
			<h2>遊戲規則</h2>
			<ul>
				<li>玩家和電腦輪流在棋盤上放置「X」或「O」。</li>
				<li>玩家或電腦首先完成一條橫向、縱向或對角線的三個符號，即為勝利。</li>
				<li>如果棋盤已滿且無人獲勝，則遊戲為平局。</li>
				<li>當有玩家獲勝時，會顯示「玩家獲勝」或「電腦獲勝」的提示。</li>
				<li>如果您選擇單人遊玩，電腦會智能防守並嘗試勝出。</li>
			</ul>
		</section>

		<section class="game-operations">
			<h2>操作說明</h2>
			<ul>
				<li>在遊戲中，您可以使用滑鼠點擊棋盤上的空白格子來放置您的「X」或「O」。每次輪到您時，棋盤上會顯示您選擇的符號。</li>
				<li>玩家（「X」）先行，電腦（「O」）則會根據情況作出最佳回應。</li>
				<li>每當遊戲結束後，您可以選擇重新開始。</li>
			</ul>
		</section>

		<section class="back-to-game">
			<button
				onclick="window.location.href='VisitorCounterServlet?page=game/tictactoe/gameTicTacToe.jsp'">開始遊戲</button>
		</section>
	</div>
</body>