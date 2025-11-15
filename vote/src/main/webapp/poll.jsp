<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="dao.impl.PollDAOImpl, dao.impl.PollOptionDAOImpl, dao.impl.PollVoteDAOImpl, model.Poll, model.PollOption, java.util.*, model.User"%>
<%
    String token = request.getParameter("token");
    if (token == null) {
        out.println("<h3>Token missing!</h3>");
        return;
    }

    PollDAOImpl pollDAO = new PollDAOImpl();
    PollOptionDAOImpl optionDAO = new PollOptionDAOImpl();
    PollVoteDAOImpl voteDAO = new PollVoteDAOImpl();

    Poll poll = pollDAO.getPollByAnonymousUrl("VoteServlet?token=" + token);
    if (poll == null) {
        out.println("<h3>無此投票或連結錯誤</h3>");
        return;
    }

    List<PollOption> options = optionDAO.getOptionsByPollId(poll.getId());

    User user = (User) session.getAttribute("user");
    boolean hasVoted = false;

    if (user != null) {
        hasVoted = voteDAO.hasUserVoted(poll.getId(), user.getId());
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>投票 - <%= poll.getTitle() %></title>

<style>

/* ========================================= */
/* ★ 全頁無 Scrollbar 並維持畫面正常 */
/* ========================================= */
html, body {
	height: 100vh;
	overflow: hidden; /* 移除整頁 scrollbar */
}

/* ========================================= */
/* 背景漸層動畫 */
/* ========================================= */
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding-top: 80px;
	background: linear-gradient(-45deg, #fbc2eb, #a6c1ee, #fad0c4, #c2e9fb);
	background-size: 400% 400%;
	animation: gradientBG 14s ease infinite;
	color: #333;
	display: flex;
	flex-direction: column;
	align-items: center;
}

@
keyframes gradientBG { 0% {
	background-position: 0% 50%;
}

50
%
{
background-position
:
100%
50%;
}
100
%
{
background-position
:
0%
50%;
}
}

/* ========================================= */
/* ★ 固定頂部工具列 (Topbar) */
/* ========================================= */
.topbar {
	width: 100%;
	position: fixed;
	top: 0;
	left: 0;
	background: rgba(255, 255, 255, 0.55);
	backdrop-filter: blur(10px);
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 12px;
	padding: 15px 25px;
	z-index: 100;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.15);
}

/* 統一按鈕視覺 */
.top-btn {
	padding: 9px 15px;
	border-radius: 10px;
	border: none;
	font-size: 14px;
	cursor: pointer;
	transition: 0.28s;
	text-decoration: none;
	display: inline-block;
	margin-right: 25px;
}

.btn-login {
	background: #4a90e2;
	color: white;
}

.btn-logout {
	background: #ff7675;
	color: white;
}

.btn-copy {
	background: #55efc4;
	color: #2d3436;
	font-weight: bold;
}

.top-btn:hover {
	transform: scale(1.08);
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

/* 複製成功提示氣泡 */
.copy-toast {
	position: fixed;
	top: 85px;
	right: 20px;
	background: #2ecc71;
	color: white;
	padding: 10px 20px;
	border-radius: 10px;
	font-size: 14px;
	opacity: 0;
	transform: translateY(-10px);
	transition: all 0.4s ease;
	z-index: 200;
}

.copy-toast.show {
	opacity: 1;
	transform: translateY(0);
}

/* ========================================= */
/* 標題 */
/* ========================================= */
h2 {
	margin: 20px 0;
	font-size: 2em;
	color: #444;
	text-align: center;
	animation: fadeInDown 0.9s ease forwards;
}

@
keyframes fadeInDown { 0% {
	opacity: 0;
	transform: translateY(-12px);
}

100
%
{
opacity
:
1;
transform
:
translateY(
0
);
}
}

/* ========================================= */
/* ★ 主內容卡片（避免超出畫面） */
/* ========================================= */
.card {
	background: rgba(255, 255, 255, 0.85);
	width: 92%;
	max-width: 520px;
	padding: 30px;
	border-radius: 16px;
	box-shadow: 0 10px 28px rgba(0, 0, 0, 0.15);
	animation: fadeInUp 0.8s ease forwards;
	/* ★ 讓內容不會超出螢幕 */
	max-height: calc(100vh - 160px);
	overflow-y: auto;
}

@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(15px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* ========================================= */
/* 投票選項 */
/* ========================================= */
.poll-option {
	background: #ffffff;
	border: 2px solid #dadada;
	border-radius: 10px;
	padding: 12px 15px;
	margin: 10px 0;
	cursor: pointer;
	transition: 0.28s;
	display: flex;
	align-items: center;
}

.poll-option:hover {
	background: #f9f9f9;
	border-color: #a29bfe;
}

.poll-option input {
	display: none;
}

.poll-option span {
	flex: 1;
	font-size: 16px;
}

.poll-option input:checked+span {
	background: #6c5ce7;
	color: white;
	padding: 5px 8px;
	border-radius: 8px;
}

/* 送出按鈕 */
button.submit-btn {
	margin-top: 15px;
	padding: 12px;
	background: linear-gradient(135deg, #89f7fe, #66a6ff);
	border: none;
	border-radius: 10px;
	font-size: 17px;
	color: white;
	cursor: pointer;
	transition: 0.28s;
}

button.submit-btn:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

/* ========================================= */
/* 結果表格 */
/* ========================================= */
table {
	width: 100%;
	border-collapse: collapse;
}

td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
	font-size: 16px;
}

/* ========================================= */
/* RWD 手機優化 */
/* ========================================= */
@media ( max-width : 480px) {
	h2 {
		font-size: 1.6em;
	}
	.card {
		padding: 22px;
	}
	.topbar {
		padding: 12px;
	}
	.top-btn {
		padding: 7px 11px;
		font-size: 13px;
		margin-right: 15px;
	}
}
</style>

</head>
<body>

	<!-- ===================== -->
	<!-- ★ 固定頂部工具列 -->
	<!-- ===================== -->
	<div class="topbar">
		<% if (user == null) { %>
		<a href="login.jsp" class="top-btn btn-login">登入</a>
		<% } else { %>
		<a href="logout.jsp" class="top-btn btn-logout">登出（<%= user.getUsername() %>）
		</a>
		<% } %>

		<button class="top-btn btn-copy" onclick="copyLink()">複製投票連結</button>
	</div>

	<!-- 複製成功提示 -->
	<div id="copyToast" class="copy-toast">已複製連結！</div>

	<script>
function copyLink() {
    navigator.clipboard.writeText(window.location.href).then(() => {
        const toast = document.getElementById("copyToast");
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 1800);
    });
}
</script>

	<!-- ===================== -->
	<!-- ★ 主內容 -->
	<!-- ===================== -->
	<% if (hasVoted) { %>

	<h2><%= poll.getTitle() %>（已投過）
	</h2>
	<div class="card">
		<table>
			<% for (PollOption o : options) { %>
			<tr>
				<td><%= o.getOptionText() %></td>
				<td><%= o.getVotes() %> 票</td>
			</tr>
			<% } %>
		</table>
	</div>

	<% } else { %>

	<h2><%= poll.getTitle() %></h2>
	<form class="card" method="post" action="VoteServlet">
		<input type="hidden" name="pollId" value="<%= poll.getId() %>">

		<% for (PollOption o : options) { %>
		<label class="poll-option"> <input type="radio"
			name="optionId" value="<%= o.getId() %>" required> <span><%= o.getOptionText() %></span>
		</label>
		<% } %>

		<button type="submit" class="submit-btn">送出投票</button>
	</form>

	<% } %>

</body>
</html>