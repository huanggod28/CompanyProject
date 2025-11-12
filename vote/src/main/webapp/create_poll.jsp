<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>建立新投票</title>
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

    /* ----------------- 標題 ----------------- */
    h2 {
        text-align: center;
        margin: 20px 0;
        color: #444;
        opacity: 0;
        transform: translateY(-20px);
        animation: fadeIn 1s forwards;
    }

    /* ----------------- 表單 ----------------- */
    form {
        max-width: 600px;
        margin: 20px auto;
        background: rgba(255,255,255,0.8);
        padding: 20px 30px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }

    input[type="text"], input[type="datetime-local"], textarea {
        width: 100%;
        padding: 10px 12px;
        margin: 8px 0;
        border-radius: 8px;
        border: 1px solid #ccc;
        transition: all 0.3s ease;
        box-sizing: border-box;
    }

    input[type="text"]:focus, input[type="datetime-local"]:focus, textarea:focus {
        border-color: #89f7fe;
        box-shadow: 0 0 8px rgba(137,247,254,0.5);
        outline: none;
    }

    button {
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        margin-top: 10px;
        transition: all 0.3s ease;
        font-size: 16px;
    }

    button[type="button"] {
        background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
        color: #fff;
    }

    button[type="submit"] {
        background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
        color: #fff;
    }

    button:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 15px rgba(0,0,0,0.2);
    }

    /* ----------------- 選項區域 ----------------- */
    #options input {
        margin-bottom: 6px;
    }

    /* ----------------- 錯誤訊息 ----------------- */
    .error {
        color: red;
        margin-top: 10px;
        text-align: center;
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
        form {
            width: 90%;
            padding: 15px 20px;
        }

        button {
            width: 100%;
        }
    }
</style>
<script>
    function addOption() {
        let div = document.getElementById("options");
        let input = document.createElement("input");
        input.type = "text";
        input.name = "options";
        input.placeholder = "投票選項";
        div.appendChild(document.createElement("br"));
        div.appendChild(input);
    }
</script>
</head>
<body>
    <h2>建立投票</h2>
    <form method="post" action="CreatePollServlet">
        標題：<input type="text" name="title" required><br>
        描述：<textarea name="description"></textarea><br>
        截止時間：<input type="datetime-local" name="end_time" required><br>
        <div id="options">
            <input type="text" name="options" placeholder="投票選項" required><br>
        </div>
        <button type="button" onclick="addOption()">+ 新增選項</button><br>
        <button type="submit">建立投票</button>
    </form>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
</body>
</html>