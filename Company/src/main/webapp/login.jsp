<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!-- 掛載jstl -->
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>智能娃娃機營運監控系統</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        table {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            border-collapse: collapse;
        }

        td {
            padding: 15px;
            font-size: 14px;
            color: #333;
        }

        /* 文字輸入框縮減30px */
        td input[type="text"],
        td input[type="password"],
        td input[type="submit"],
        td input[type="reset"],
        td input[type="text"] {
            width: calc(100% - 30px); /* 設置為減少30px */
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        td input[type="submit"],
        td input[type="reset"] {
            background-color: #3498db;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        td input[type="submit"]:hover,
        td input[type="reset"]:hover {
            background-color: #2980b9;
        }

        td a {
            text-decoration: none;
            color: #3498db;
            font-size: 14px;
            display: inline-block;
            margin-top: 10px;
        }

        td a:hover {
            text-decoration: underline;
        }

        .logo {
            width: 100%; /* 使圖片寬度滿版 */
            height: auto;
            margin-bottom: 20px;
        }

        .captcha-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* 增加驗證碼輸入框和圖片之間的間距 */
        .captcha-container input[type="text"] {
            width: 65%; /* 調整驗證碼輸入框的寬度 */
            margin-right: 10px; /* 增加間距 */
        }

        .captcha-container img {
            cursor: pointer;
        }

        /* 設定表單欄位的標籤 */
        label {
            font-weight: bold;
            color: #333;
        }

    </style>
</head>
<body>
    <div class="container">
        <form action="LoginController" method="post">
            <table border="2">
                <tr align="center">
                    <td colspan="2" align="center">
                        <a href="VisitorCounterServlet?page=index.jsp">
                            <img src="pic/logo.gif" alt="logo" class="logo">
                        </a>
                    </td>
                </tr>
                <tr>
                    <td>帳號：</td>
                    <td><input type="text" name="username" required placeholder="請輸入帳號" size="50"></td>
                </tr>
                <tr>
                    <td>密碼：</td>
                    <td><input type="password" name="password" required placeholder="請輸入密碼" size="50"></td>
                </tr>
                <tr>
                    <td>驗證碼：</td>
                    <td class="captcha-container">
                        <input type="text" name="captcha" required placeholder="請輸入驗證碼" size="26">
                        <img src="CaptchaServlet" alt="驗證碼" onclick="this.src='CaptchaServlet?'+Math.random()">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="登入">
                        <input type="reset" value="重置">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <a href="VisitorCounterServlet?page=register.jsp">註冊帳號</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>