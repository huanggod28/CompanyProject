<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>投票管理系統</title>
<link rel="icon" href="https://web.huanggod.myddns.me/vote/pic/voteicon.png" type="image/x-icon">
<style>
    /* ----------------- 背景動畫 ----------------- */
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
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

    /* ----------------- Logo + 標題容器 ----------------- */
    .title-wrap {
        display: flex;
        align-items: center;
        gap: 12px;
        opacity: 0;
        transform: translateY(-20px);
        animation: fadeIn 1s forwards;
    }

    /* ----------------- Logo 大小 ----------------- */
    .logo {
        width: 60px;
        height: 60px;
        object-fit: contain;
    }

    /* ----------------- 標題 ----------------- */
    h1 {
        margin: 0;
        font-size: 2.2em;
        color: #444;
    }

    /* ----------------- 表單 ----------------- */
    form {
        background: rgba(255,255,255,0.85);
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        display: flex;
        flex-direction: column;
        width: 300px;
        text-align: center;
        animation: fadeIn 1s forwards;
        animation-delay: 0.4s;
        opacity: 0;
        transform: translateY(-20px);
    }

    input[type="text"], input[type="password"] {
        padding: 10px 12px;
        margin: 10px 0;
        border-radius: 8px;
        border: 1px solid #ccc;
        transition: all 0.3s ease;
        width: 100%;
        box-sizing: border-box;
    }

    input[type="text"]:focus, input[type="password"]:focus {
        border-color: #89f7fe;
        box-shadow: 0 0 8px rgba(137,247,254,0.5);
        outline: none;
    }

    button {
        padding: 10px 20px;
        margin: 10px 0;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
        color: #fff;
        font-size: 16px;
        transition: all 0.3s ease;
    }

    button:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 15px rgba(0,0,0,0.2);
    }

    a {
        color: #4a90e2;
        margin-top: 5px;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    a:hover {
        color: #d36cae;
        transform: scale(1.05);
    }

    .error {
        color: red;
        margin-top: 10px;
    }

    /* ----------------- 動畫 ----------------- */
    @keyframes fadeIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* ----------------- RWD ----------------- */
    @media screen and (max-width: 480px) {
        h1 {
            font-size: 1.8em;
        }
        .logo {
            width: 50px;
            height: 50px;
        }
        form {
            width: 90%;
            padding: 20px;
        }
    }
</style>
</head>

<body>

    <!-- ⭐ 新增：Logo 與標題在一起 -->
    <div class="title-wrap">
        <img class="logo" src="https://web.huanggod.myddns.me/vote/pic/voteicon.png" alt="Logo">
        <h1>投票管理系統</h1>
    </div>

    <form method="post" action="LoginServlet">
        <input type="text" name="username" placeholder="帳號" required>
        <input type="password" name="password" placeholder="密碼" required>
        <button type="submit">登入</button>
        <a href="register.jsp">沒有帳號？註冊</a>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
    </form>

</body>
</html>