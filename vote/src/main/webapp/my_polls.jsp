<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,model.Poll,model.User" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Poll> polls = (List<Poll>) request.getAttribute("polls");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>我的投票</title>
<link rel="icon" href="https://web.huanggod.myddns.me/vote/pic/voteicon.png" type="image/x-icon">
<style>
    /* ----------------- 背景動畫 ----------------- */
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(-45deg, #fbc2eb, #a6c1ee, #fad0c4, #c2e9fb);
        background-size: 400% 400%;
        animation: gradientBG 15s ease infinite;
        color: #333;
    }

    @keyframes gradientBG {
        0% {background-position: 0% 50%;}
        50% {background-position: 100% 50%;}
        100% {background-position: 0% 50%;}
    }

    /* ----------------- 頂部工具列 ----------------- */
    .topbar {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding: 10px 50px;
        background: rgba(255,255,255,0.8);
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        border-radius: 0 0 12px 12px;
        flex-wrap: wrap;
        gap: 10px;
    }

    .topbar a {
        text-decoration: none;
        color: #4a90e2;
        transition: all 0.3s ease;
    }

    .topbar a:hover {
        color: #d36cae;
        transform: scale(1.05);
    }

    /* ----------------- 標題 ----------------- */
    h2 {
        text-align: center;
        margin: 20px 0;
        color: #444;
        opacity: 0;
        transform: translateY(-20px);
        animation: fadeIn 1s forwards;
    }

    /* ----------------- 表格 ----------------- */
    table {
        width: 90%;
        max-width: 1000px;
        margin: 20px auto;
        border-collapse: collapse;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        background: rgba(255,255,255,0.85);
        opacity: 0;
        transform: translateY(20px);
        animation: fadeIn 1s forwards;
        animation-delay: 0.3s;
    }

    th, td {
        padding: 12px 15px;
        text-align: center;
        transition: background-color 0.3s ease, transform 0.3s ease;
    }

    th {
        background: rgba(137,247,254,0.5);
    }

    tr:nth-child(even) {
        background: rgba(255,255,255,0.5);
    }

    tr:hover {
        background: rgba(255,255,255,0.8);
        transform: scale(1.02);
    }

    a {
        color: #4a90e2;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    a:hover {
        color: #d36cae;
        transform: scale(1.05);
    }

    /* ----------------- 滑入動畫 ----------------- */
    @keyframes fadeIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* ----------------- RWD ----------------- */
    @media screen and (max-width: 768px) {

    table {
        border: none;
        box-shadow: none;
        background: transparent;
    }

    tr {
        display: block;
        background: rgba(255,255,255,0.85);
        margin: 15px auto;
        padding: 15px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        width: 90%;
        border-left: 4px solid #89f7fe; /* 淡色強調線，更有設計感 */
    }

    th {
        display: none;
    }

    td {
        display: flex;
        justify-content: space-between;
        padding: 8px 0;
        border-bottom: 1px solid #eee;
    }

    td:last-child {
        border-bottom: none;
    }

    td::before {
        content: attr(data-label);
        font-weight: bold;
        color: #555;
    }

}

</style>
</head>
<body>

<div class="topbar">
    <span>歡迎，<%=user.getUsername()%></span>
    <a href="create_poll.jsp">建立投票</a>
    <a href="logout.jsp">登出</a>
</div>

<h2>我建立的投票</h2>

<table>
    <tr>
        <th>投票主題</th>
        <th>建立時間</th>
        <th>截止時間</th>
        <th>參與人數</th>
        <th>匿名投票連結</th>
    </tr>
    <%
    if (polls == null || polls.isEmpty()) {
    %>
        <tr><td colspan="5">尚未建立任何投票</td></tr>
    <%
    } else {
        for (Poll p : polls) {
    %>
        <tr>
            <td data-label="投票主題"><%=p.getTitle()%></td>
            <td data-label="建立時間"><%=p.getCreatedAt()%></td>
            <td data-label="截止時間"><%=p.getEndTime() != null ? p.getEndTime() : "無期限" %></td>
            <td data-label="參與人數"><%=p.getTotalVotes()%></td>
            <td data-label="匿名投票連結">
                <a target="_blank" href="poll.jsp?token=<%= p.getAnonymousUrl().substring(p.getAnonymousUrl().indexOf('=') + 1) %>">開啟投票頁面</a>
            </td>
        </tr>
    <%
        }
    }
    %>
</table>

</body>
</html>