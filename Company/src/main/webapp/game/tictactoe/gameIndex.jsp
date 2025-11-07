<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>井字遊戲介紹</title>

<script
	src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>

<style>
/* 基本樣式 */
body {
	margin: 0;
	font-family: 'Segoe UI', Arial, sans-serif;
	background: #0a0f1f;
	color: #d0eaff;
	overflow-x: hidden;
}

#particles-js {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: -1;
}

.intro-container {
	width: 90%;
	max-width: 850px;
	margin: 50px auto;
	background: rgba(20, 30, 60, 0.55);
	border-radius: 16px;
	padding: 20px 30px;
	backdrop-filter: blur(10px);
	box-shadow: 0 0 20px rgba(0, 204, 255, 0.3);
	border: 1px solid rgba(0, 204, 255, 0.3);
}

/* 標題 */
h1 {
	color: #5ad5ff;
	text-align: center;
	font-size: 2rem;
	margin-bottom: 15px;
	text-shadow: 0 0 8px #00c8ff;
}

h2 {
	color: #5ad5ff;
	font-size: 1.4rem;
	margin-top: 20px;
	margin-bottom: 10px;
}

/* 列表 */
ul li {
	margin: 6px 0;
	line-height: 1.5em;
}

/* 語言選單 */
.language-selector {
	position: fixed;
	top: 15px;
	right: 15px;
	background: rgba(20, 30, 60, 0.55);
	padding: 8px 12px;
	border-radius: 10px;
	border: 1px solid rgba(0, 204, 255, 0.3);
	backdrop-filter: blur(6px);
	color: white;
	z-index: 10;
}

select {
	background: #0d162c;
	border: 1px solid #4dcaff;
	color: #d8f4ff;
	padding: 4px 6px;
	border-radius: 6px;
}

/* 按鈕 */
button {
	display: block;
	width: 100%;
	max-width: 250px;
	margin: 25px auto 0 auto;
	background: linear-gradient(90deg, #009dff, #00eaff);
	border: none;
	padding: 12px;
	font-size: 1.2rem;
	color: #00111f;
	cursor: pointer;
	border-radius: 10px;
	font-weight: bold;
	transition: 0.2s;
	box-shadow: 0 0 10px #00c8ff;
}

button:hover {
	box-shadow: 0 0 20px #00eaff;
	transform: scale(1.05);
}

/* 響應式調整 */
@media screen and (max-width: 600px) {
	.intro-container {
		margin: 20px;
		padding: 15px;
	}
	h1 {
		font-size: 1.6rem;
	}
	h2 {
		font-size: 1.2rem;
	}
	button {
		font-size: 1rem;
		max-width: 200px;
	}
	.language-selector {
		top: 10px;
		right: 10px;
		padding: 6px 10px;
	}
}
</style>

<script>
window.onload = () => {
    const savedLang = localStorage.getItem("lang") || "zh-TW";
    document.getElementById('language').value = savedLang;
    changeLanguage();
};

/* 翻譯資料 */
const translations = {
  "zh-TW": { "title":"歡迎來到動態井字遊戲！","intro":"這是一款進化版的井字遊戲，讓經典玩法變得更刺激！玩家可以選擇先攻（○）或後攻（✕）。先攻時玩家先下，後攻時由電腦先下（首子位置隨機）。","rules":["玩家與電腦輪流在 3x3 棋盤上放置棋子（○ 或 ✕）。","遊戲開始時可選擇「先攻（○）」或「後攻（✕）」。","當下到第 4 子時，該玩家或電腦最早下的第 1 子會自動消失。","下第 5 子時，第 2 子會消失，以此類推。","當任一方在棋盤上形成三子連線（橫、直或斜），即為勝利。","這樣的規則讓遊戲保持變化，不會陷入重複局面。"],"operations":["開始遊戲後，選擇是否先攻（○）或後攻（✕）。","使用滑鼠點擊棋盤空格放置棋子。","隨著遊戲進行，舊的棋子會逐漸被移除。","連成三子即獲勝，可選擇重新開始遊戲。"],"backToGame":"開始遊戲"},
  "zh-CN": { "title":"欢迎来到动态井字游戏！","intro":"这是井字游戏的进化版，让经典玩法更刺激！玩家可以选择先攻（○）或后攻（✕）。先攻时玩家先下，后攻时电脑先下（首子位置随机）。","rules":["玩家与电脑轮流在 3x3 棋盘上放置棋子（○ 或 ✕）。","游戏开始时可选择“先攻（○）”或“后攻（✕）”。","当下到第4子时，该玩家或电脑最早下的第1子会自动消失。","下第5子时，第2子会消失，以此类推。","任意一方在棋盘上形成三子连线即获胜。","这样的规则让游戏保持变化，不会陷入重复局面。"],"operations":["开始游戏后，选择先攻（○）或后攻（✕）。","使用鼠标点击棋盘空格放置棋子。","随着游戏进行，旧的棋子会逐渐消失。","连成三子即获胜，可重新开始游戏。"],"backToGame":"开始游戏"},
  "en": { "title":"Welcome to Dynamic Tic-Tac-Toe!","intro":"This is an enhanced version of Tic-Tac-Toe! You can choose to go first (○) or second (✕). If you go first, you start the game; if you go second, the computer plays first with a random opening move.","rules":["Players take turns placing ○ or ✕ on a 3x3 grid.","At the start, choose to be first (○) or second (✕).","When a player or the computer places their 4th piece, their oldest piece disappears automatically.","When the 5th piece is placed, the 2nd piece disappears, and so on.","The first to align three symbols horizontally, vertically, or diagonally wins.","The first to align three symbols wins, keeping the game dynamic."],"operations":["After starting, choose whether to go first (○) or second (✕).","Click an empty cell to place your symbol.","Older pieces will fade as new ones are placed.","Form three in a row to win, then restart for another round!"],"backToGame":"Start Game"},
  "ko": { "title":"다이나믹 틱택토에 오신 것을 환영합니다!","intro":"이 게임은 클래식 틱택토의 업그레이드 버전입니다! 먼저 두기(○) 또는 나중에 두기(✕)를 선택할 수 있습니다. 먼저 두면 플레이어가 먼저, 나중에 두면 컴퓨터가 랜덤한 위치에서 시작합니다.","rules":["플레이어와 컴퓨터가 번갈아 3x3 보드에 ○ 또는 ✕를 둡니다.","게임 시작 시 선공(○) 또는 후공(✕)을 선택합니다.","4번째 돌을 둘 때, 자신의 첫 번째 돌이 자동으로 사라집니다.","5번째 돌을 둘 때는 두 번째 돌이 사라집니다.","세 개를 가로, 세로 또는 대각선으로 연결하면 승리합니다.","이 규칙 덕분에 게임이 지루하지 않고 항상 새롭습니다."],"operations":["게임을 시작하면 선공(○) 또는 후공(✕)을 선택하세요.","빈 칸을 클릭하여 돌을 둡니다.","새 돌을 놓을수록 오래된 돌이 사라집니다.","3개를 연결하면 승리하며, 다시 시작할 수 있습니다."],"backToGame":"게임 시작"},
  "ja": { "title":"ダイナミック三目並べへようこそ！","intro":"これは進化版の三目並べです！プレイヤーは先攻（○）または後攻（✕）を選べます。先攻の場合はプレイヤーが先に、後攻の場合はコンピュータがランダムに初手を打ちます。","rules":["プレイヤーとコンピュータが交互に○または✕を3x3の盤に置きます。","ゲーム開始時に先攻（○）か後攻（✕）を選択します。","4手目を置くと、そのプレイヤー（またはコンピュータ）の最初の石が消えます。","5手目では2手目が消えます。このように順番に古い石が消えていきます。","3つを横・縦・斜めに揃えた方が勝利です。","このルールにより、毎回新鮮な展開が楽しめます。"],"operations":["ゲーム開始後、先攻（○）または後攻（✕）を選びます。","空いているマスをクリックして石を置きます。","新しい石を置くたびに古い石が消えていきます。","三つ並べると勝利です。再スタートも可能です。"],"backToGame":"ゲームを始める"}
};

function changeLanguage() {
    const lang = document.getElementById('language').value;
    const t = translations[lang];

    document.querySelector("h1").textContent = t.title;
    document.querySelector(".game-introduction p").textContent = t.intro;

    const titles = {
        "zh-TW": ["遊戲簡介","遊戲規則","操作說明"],
        "zh-CN": ["游戏简介","游戏规则","操作说明"],
        "en": ["Game Introduction","Game Rules","How to Play"],
        "ko": ["게임 소개","게임 규칙","조작 방법"],
        "ja": ["ゲーム紹介","ルール","操作説明"]
    };
    const [introTitle,rulesTitle,opsTitle] = titles[lang];
    document.querySelector('.game-introduction h2').textContent = introTitle;
    document.querySelector('.game-rules h2').textContent = rulesTitle;
    document.querySelector('.game-operations h2').textContent = opsTitle;

    const rulesList = document.querySelector('.game-rules ul');
    rulesList.innerHTML = '';
    t.rules.forEach(r=>{let li=document.createElement('li');li.textContent=r;rulesList.appendChild(li);});

    const operationsList = document.querySelector('.game-operations ul');
    operationsList.innerHTML='';
    t.operations.forEach(o=>{let li=document.createElement('li');li.textContent=o;operationsList.appendChild(li);});

    document.querySelector('.back-to-game button').textContent = t.backToGame;
    localStorage.setItem("lang", lang);
}

/* 粒子背景 */
window.addEventListener("DOMContentLoaded",()=>{
    particlesJS("particles-js",{
        particles:{number:{value:80},color:{value:"#00d5ff"},shape:{type:"circle"},opacity:{value:0.5},size:{value:3},line_linked:{enable:true,distance:120,color:"#00eaff",opacity:0.4,width:1},move:{speed:1.5}},
        interactivity:{events:{onhover:{enable:true,mode:"grab"}},modes:{grab:{distance:200,line_linked:{opacity:0.5}}}},
        retina_detect:true
    });
});
</script>

</head>
<body>

	<div id="particles-js"></div>

	<!-- 語言選單 -->
	<div class="language-selector">
		<label for="language">語言:</label> <select id="language"
			onchange="changeLanguage()">
			<option value="zh-TW">繁體中文</option>
			<option value="zh-CN">簡體中文</option>
			<option value="en">English</option>
			<option value="ko">한국어</option>
			<option value="ja">日本語</option>
		</select>
	</div>

	<div class="intro-container">
		<h1>歡迎來到動態井字遊戲！</h1>

		<section class="game-introduction">
			<h2>遊戲簡介</h2>
			<p>載入中...</p>
		</section>

		<section class="game-rules">
			<h2>遊戲規則</h2>
			<ul>
				<li>載入中...</li>
			</ul>
		</section>

		<section class="game-operations">
			<h2>操作說明</h2>
			<ul>
				<li>載入中...</li>
			</ul>
		</section>

		<section class="back-to-game">
			<button onclick="location.href='game/tictactoe/gameTicTacToe.jsp'">開始遊戲</button>
		</section>
	</div>

</body>
</html>