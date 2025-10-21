<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>意見回復表單_管理區</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
*, *::before, *::after {
    box-sizing: border-box;
}
body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: radial-gradient(circle at top, #0a0f1a, #000);
    color: #fff;
}
h2 {
    text-align: center;
    margin: 25px 0;
    color: #00ffff;
    text-shadow: 0 0 8px #00ffff;
}
.table-container {
    width: 95%;
    max-width: 1000px;
    margin: auto;
    background: rgba(0,0,0,0.6);
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0,255,255,0.25);
    padding: 20px;
    overflow-x: auto;
}
table {
    width: 100%;
    border-collapse: collapse;
    color: #fff;
    font-size: 15px;
    min-width: 800px;
}
th, td {
    padding: 10px;
    border: 1px solid rgba(0,255,255,0.3);
    text-align: center;
    vertical-align: top;
}
th {
    background-color: rgba(0,255,255,0.2);
    color: #00ffff;
    text-shadow: 0 0 4px #00ffff;
}
tr:nth-child(even) {
    background-color: rgba(255,255,255,0.05);
}
tr:hover {
    background-color: rgba(0,255,255,0.1);
}
textarea {
    width: 100%;
    height: 80px;
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(0,255,255,0.3);
    border-radius: 6px;
    color: #fff;
    padding: 8px;
    font-size: 14px;
    resize: vertical;
    transition: 0.3s;
}
textarea:focus {
    border-color: #00ffff;
    box-shadow: 0 0 8px #00ffff;
    background: rgba(255,255,255,0.15);
}
button {
    background-color: #00ffff;
    border: none;
    color: #000;
    padding: 8px 14px;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
    margin-top: 6px;
}
button:hover {
    background-color: #00cccc;
    box-shadow: 0 0 10px #00ffff;
    transform: scale(1.05);
}
.status-btn {
    background: none;
    color: inherit;
    border: none;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
}
.status-btn:hover {
    text-shadow: 0 0 6px #00ffff;
}
/* 🔹RWD調整 */
@media (max-width: 768px) {
    table {
        font-size: 13px;
        min-width: 600px;
    }
    textarea {
        height: 70px;
    }
}
</style>
</head>
<body>

<h2>客服意見管理</h2>

<div class="table-container">
<table>
    <tr>
        <th>ID</th>
        <th>使用者</th>
        <th>主旨</th>
        <th>內容</th>
        <th>回覆</th>
        <th>狀態</th>
    </tr>
    <c:forEach var="f" items="${feedbackList}">
        <tr>
            <td>${f.id}</td>
            <td>${f.name}</td>
            <td>${f.subject}</td>
            <td>${f.message}</td>
            <td>
                <form action="FeedbackAdminServlet" method="post">
                    <input type="hidden" name="id" value="${f.id}">
                    <textarea name="reply">${f.reply}</textarea>
                    <button type="submit">送出回覆</button>
                </form>
            </td>
            <td>
                <button class="status-btn" onclick="toggleStatus(${f.id}, ${f.replyStatus})">
                    ${f.replyStatus == 1 ? '✅ 已回覆' : '❌ 未回覆'}
                </button>
            </td>
        </tr>
    </c:forEach>
</table>
</div>

<script>
function toggleStatus(id, current) {
    fetch('ToggleReplyStatusServlet?id=' + id + '&status=' + (current === 1 ? 0 : 1))
        .then(() => location.reload());
}
</script>

</body>
</html>