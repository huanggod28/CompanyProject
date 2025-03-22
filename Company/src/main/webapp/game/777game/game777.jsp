<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
    Integer balance = (Integer) session.getAttribute("balance");
    if (balance == null) {
        balance = 100;
        session.setAttribute("balance", balance);
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>777 拉霸機</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.container {
	display: flex;
	width: 900px;
	background: white;
	border-radius: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	overflow: hidden;
}

/* 側邊選單 */
.sidebar {
	width: 220px;
	background: #007BFF;
	padding: 20px;
	color: white;
}

.menu {
	list-style: none;
	padding: 0;
}

.menu li {
	margin: 10px 0;
}

.menu a {
	display: block;
	padding: 10px;
	font-size: 18px;
	color: white;
	text-decoration: none;
	background: #0056b3;
	border-radius: 5px;
	transition: background 0.3s;
	text-align: center;
}

.menu a:hover {
	background: #004085;
}

/* 主要內容區 */
.content {
	flex: 1;
	padding: 30px;
	text-align: center;
	background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
}

h2 {
	font-size: 28px;
	color: #333;
	margin-bottom: 15px;
}

p {
	font-size: 18px;
	margin-bottom: 10px;
}

canvas {
	background: #222;
	display: block;
	margin: 20px auto;
	border-radius: 10px;
}

select, button {
	font-size: 18px;
	padding: 10px;
	margin-top: 10px;
	border-radius: 8px;
	border: none;
	cursor: pointer;
}

select {
	background: white;
	border: 2px solid #007BFF;
}

button {
	background: #007BFF;
	color: white;
	transition: background 0.3s;
}

button:hover {
	background: #0056b3;
}
</style>
<script>
    let spinning = false;
    let symbols = ["🍒", "🍋", "🍊", "🔔", "⭐", "7️⃣"];

    function drawSlot(ctx, x, symbol) {
        ctx.fillStyle = "#FFF";
        ctx.fillRect(x, 0, 100, 100);
        ctx.font = "50px Arial";
        ctx.fillStyle = "#000";
        ctx.fillText(symbol, x + 25, 70);
    }

    function startSpin() {
        let bet = 10;  // 固定投注金額
        let multiplier = parseInt(document.getElementById("multiplier").value);  // 取得選擇的倍率
        let totalBet = bet * multiplier;
        let balance = <%= balance %>;  // 從 JSP 中獲取 balance 的值
	
        if (isNaN(multiplier) || multiplier <= 0) {
            alert("請選擇有效的下注倍率！");
            return;
        }
        
        // 驗證餘額是否足夠
        if (totalBet > balance) {
            alert("餘額不足，請更換投入倍率！");
            return;
        }

        // 確保只有一個拉霸動作在進行
        if (spinning) return;
        spinning = true;
        let ctx = document.getElementById("slotCanvas").getContext("2d");

        let frames = 0;
        let interval = setInterval(() => {
            ctx.clearRect(0, 0, 300, 100);
            let randSymbols = [
                symbols[Math.floor(Math.random() * symbols.length)],
                symbols[Math.floor(Math.random() * symbols.length)],
                symbols[Math.floor(Math.random() * symbols.length)]
            ];
            drawSlot(ctx, 0, randSymbols[0]);
            drawSlot(ctx, 100, randSymbols[1]);
            drawSlot(ctx, 200, randSymbols[2]);

            frames++;
            if (frames >= 21) {
                clearInterval(interval);
                fetchResult(bet, multiplier); // 取後端結果，並傳送 bet 和 multiplier
            }
        }, 100);
    }

    function fetchResult(bet, multiplier) {
        console.log("Bet:", bet);
        console.log("Multiplier:", multiplier);

        if (!multiplier || isNaN(multiplier)) {
            alert("請選擇有效的下注倍率！");
            return;
        }

        if (!bet || isNaN(bet)) {
            alert("錯誤: 下注金額不正確！");
            return;
        }

        // 使用 JSON 格式傳輸數據
        let requestData = {
            bet: bet,
            multiplier: multiplier
        };

        fetch("SlotServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(requestData)
        })
        .then(response => response.json())
        .then(data => {
            console.log("後端回傳資料:", data);
            if (data.error) {
                alert(data.error);
                return;
            }

            // 顯示拉霸結果
            let ctx = document.getElementById("slotCanvas").getContext("2d");
            ctx.clearRect(0, 0, 300, 100);
            drawSlot(ctx, 0, data.symbol1);
            drawSlot(ctx, 100, data.symbol2);
            drawSlot(ctx, 200, data.symbol3);

            // 更新餘額顯示
            document.getElementById("balanceDisplay").innerText = data.balance;

            // 顯示結果
            setTimeout(() => {
                alert(data.message);
            }, 1500);
        })
        .catch(error => {
            console.error("錯誤:", error);
            alert("發生錯誤，請稍後再試！");
        })
        .finally(() => spinning = false);
    }
    </script>
</head>
<body>
	<div class="container">
		<!-- 主要內容 -->
		<div class="content">
			<h2>777 拉霸機</h2>
			<p>
				當前金額: <strong><span id="balanceDisplay"><%= balance %></span></strong>
			</p>

			<canvas id="slotCanvas" width="300" height="100"></canvas>

			<!-- 移除隱藏的 bet 欄位，改為由 JavaScript 控制 -->
			<form id="slotForm" action="SlotServlet" method="post">
				<label>下注倍率： <select name="multiplier" id="multiplier">
						<option value="1">x1</option>
						<option value="2">x2</option>
						<option value="3">x3</option>
						<option value="5">x5</option>
						<option value="10">x10</option>
				</select>
				</label>
				<button type="button" onclick="startSpin()">拉霸！</button>
			</form>

			<p id="result">
				<c:if test="${not empty sessionScope.result}">
					<script>alert("${sessionScope.result}");</script>
                    ${sessionScope.result}
                    <c:remove var="result" scope="session" />
				</c:if>
			</p>
		</div>
	</div>
</body>
</html>