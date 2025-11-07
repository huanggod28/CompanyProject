<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>動態消子井字遊戲</title>

<style>
/* 粒子背景 */
#particles-js {
    position: fixed;
    inset: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
}

/* 基本深色 + 螢光藍科技風 */
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    margin: 0;
    background: linear-gradient(135deg, #0a0f1f, #050719);
    color: #d0eaff;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 20px 0;
    overflow-x: hidden;
}

/* 遊戲容器 */
.game-frame {
    width: 90%;
    max-width: 550px;
    background: rgba(20,30,60,0.75);
    padding: 20px;
    border-radius: 16px;
    box-shadow: 0 0 25px rgba(0,204,255,0.5), 0 0 50px rgba(0,128,255,0.2) inset;
    backdrop-filter: blur(10px);
    text-align: center;
    border: 1px solid rgba(0,204,255,0.3);
    animation: glowPulse 3s infinite alternate;
}

/* 標題與狀態 */
h1 {
    font-size: 1.8rem;
    color: #00eaff;
    margin-bottom: 15px;
    text-shadow: 0 0 15px #00c8ff, 0 0 25px #00eaff;
    animation: neonGlow 2s infinite alternate;
}
#currentPlayerText, #gameStatusText {
    font-weight: bold;
    color: #00ffff;
}

/* 棋盤 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}
td {
    width: 33%;
    height: 90px;
    border: 2px solid #00c8ff;
    font-size: 2rem;
    cursor: pointer;
    transition: 0.3s;
    text-align: center;
    vertical-align: middle;
    box-shadow: 0 0 5px #00eaff inset;
    border-radius: 6px;
}
td:hover {
    background: rgba(0,255,255,0.15);
    transform: scale(1.08);
    box-shadow: 0 0 15px #00eaff, 0 0 25px #00ffff inset;
}
/* 新增落子發光效果 */
td.x-mark, td.o-mark {
    animation: markGlow 0.8s ease forwards;
}

@keyframes markGlow {
    0% { text-shadow: 0 0 0px #00eaff; }
    50% { text-shadow: 0 0 15px #00eaff, 0 0 25px #00c8ff; }
    100% { text-shadow: 0 0 8px #00eaff; }
}

/* 按鈕 */
button {
    width: 100%;
    max-width: 220px;
    padding: 10px;
    margin-top: 10px;
    border: none;
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: bold;
    color: #00111f;
    background: linear-gradient(90deg,#00c8ff,#00eaff);
    cursor: pointer;
    box-shadow: 0 0 8px #00eaff, 0 0 15px #00c8ff inset;
    transition: 0.3s;
}
button:hover:not(:disabled) {
    box-shadow: 0 0 20px #00ffff, 0 0 30px #00c8ff inset;
    transform: scale(1.08);
}
button:disabled {
    background: gray;
    cursor: not-allowed;
}

/* 選先攻/後攻彈窗 */
#selectFirstDialog {
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.75);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 999;
    animation: fadeIn 0.8s ease;
}
.dialog-box {
    background: rgba(20,30,60,0.95);
    padding: 20px;
    border-radius: 14px;
    width: 280px;
    border: 1px solid #00c8ff;
    box-shadow: 0 0 15px #00eaff;
    text-align: center;
}
.dialog-box h2 {
    font-size: 1.3rem;
    color: #00eaff;
    margin-bottom: 15px;
    text-shadow: 0 0 8px #00c8ff;
}
.dialog-box button {
    margin-top: 10px;
}

/* 遊戲結束訊息 */
#gameOverMessage b {
    font-size: 1.2rem;
    text-shadow: 0 0 10px #00eaff;
    animation: neonGlow 2s infinite alternate;
}

/* 響應式調整 */
@media screen and (max-width: 600px) {
    .game-frame { padding: 15px; }
    h1 { font-size: 1.4rem; }
    td { height: 70px; font-size: 1.6rem; }
    button { font-size: 1rem; max-width: 180px; }
    .dialog-box { width: 220px; padding: 15px; }
}

/* 動畫特效 */
@keyframes glowPulse {
    0% { box-shadow: 0 0 20px rgba(0,204,255,0.4), 0 0 40px rgba(0,128,255,0.2) inset; }
    100% { box-shadow: 0 0 35px rgba(0,204,255,0.6), 0 0 60px rgba(0,128,255,0.4) inset; }
}

@keyframes neonGlow {
    0% { text-shadow: 0 0 10px #00c8ff, 0 0 20px #00eaff; }
    100% { text-shadow: 0 0 25px #00c8ff, 0 0 40px #00eaff; }
}

@keyframes fadeIn {
    0% { opacity: 0; transform: scale(0.9); }
    100% { opacity: 1; transform: scale(1); }
}
</style>
</head>

<body>

<div id="selectFirstDialog">
    <div class="dialog-box">
        <h2>選擇先攻/後攻</h2>
        <button onclick="chooseFirst('O')">玩家先攻（O）</button>
		<button onclick="chooseFirst('X')">玩家後攻（X）</button>
    </div>
</div>

<div class="game-frame">
    <h1>動態消子井字遊戲</h1>
    <button id="startBtn" disabled>請先選擇先攻/後攻</button>
    <div style="margin-top:10px;">
        當前玩家：<span id="currentPlayerText">-</span>　
        狀態：<span id="gameStatusText">未開始</span>
    </div>
    <div id="gameBoardContainer" style="margin-top:20px;"></div>
    <div id="gameOverMessage" style="margin-top:15px;"></div>
</div>

<script>
let currentState = null;
let playerFirst = null;

async function safeFetch(url, options) {
    const res = await fetch(url, options);
    const text = await res.text();
    console.log("伺服器原始回傳：", text);
    try { return JSON.parse(text); }
    catch(e){ console.error("❌ JSON parse failed:", e); return {error:"JSON parse error", raw:text}; }
}

function chooseFirst(symbol){
    playerFirst = symbol;
    document.getElementById("selectFirstDialog").style.display = "none";
    const btn = document.getElementById("startBtn");
    btn.disabled = false;
    btn.textContent = "開始遊戲";
}

async function startGame() {
    if(!playerFirst){ alert("請先選擇先攻/後攻！"); return; }
    const btn = document.getElementById("startBtn");
    btn.disabled = true; btn.textContent = "遊戲中…";

    const data = await safeFetch("/Company/TicTacToeServlet", {
        method: "POST",
        headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "action=init&first=" + playerFirst
    });

    updateUI(data);
}

function renderBoard(board){
    let html = "<table>";
    for(let i=0;i<3;i++){
        html += "<tr>";
        for(let j=0;j<3;j++){
            const cell = board[i][j] ? board[i][j] : "";
            // 根據棋子加入 class，套用動畫
            const cellClass = cell === 'X' ? 'x-mark' : cell === 'O' ? 'o-mark' : '';
            html += "<td class='" + cellClass + "' onclick='makeMove(" + i + "," + j + ")'>" + cell + "</td>";
        }
        html += "</tr>";
    }
    html += "</table>";
    document.getElementById("gameBoardContainer").innerHTML = html;
}

function updateUI(state){
    if(state.error){ alert("錯誤：" + state.error); return; }
    currentState = state;
    renderBoard(state.board);
    document.getElementById("currentPlayerText").innerText = state.currentPlayer||"-";
    document.getElementById("gameStatusText").innerText = state.gameOver?"已結束":"進行中";
    const msg = document.getElementById("gameOverMessage");
    if(state.gameOver){
        if(state.winner==="player") msg.innerHTML="<b style='color:green'>玩家獲勝！</b>";
        else if(state.winner==="computer") msg.innerHTML="<b style='color:red'>電腦獲勝！</b>";
        else msg.innerHTML="<b style='color:orange'>平手</b>";
        const btn = document.getElementById("startBtn");
        btn.disabled = false; btn.textContent = "重新開始";
    } else msg.innerHTML="";
    console.log("接收到的 board：", state.board);
    logBoard(state.board);
}

function logBoard(board){
    console.log("🧩 前端棋盤：");
    board.forEach(r=>console.log(r.join(" | ")));
    console.log("------------------");
}

async function makeMove(r,c){
    if(!currentState||currentState.gameOver) return;
    if(currentState.board[r][c]!=="") return;
    const data = await safeFetch("/Company/TicTacToeServlet", {
        method:"POST",
        headers:{"Content-Type":"application/x-www-form-urlencoded"},
        body: "action=move&row=" + r + "&col=" + c
    });
    updateUI(data);
}

document.getElementById("startBtn").onclick = startGame;

/* 粒子效果 */
window.addEventListener("DOMContentLoaded",()=>{
    particlesJS("particles-js",{
        particles:{number:{value:80},color:{value:"#00d5ff"},shape:{type:"circle"},opacity:{value:0.5},size:{value:3},line_linked:{enable:true,distance:120,color:"#00eaff",opacity:0.4,width:1},move:{speed:1.5}},
        interactivity:{events:{onhover:{enable:true,mode:"grab"}},modes:{grab:{distance:200,line_linked:{opacity:0.5}}}},
        retina_detect:true
    });
});
</script>
</body>
</html>