<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>註冊帳號</title>
    <style>
        /* 設定背景圖片樣式 */
        body {
            background-image: url(pic/bacc01.jpg);
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-size: cover;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* 設定容器，使表單在畫面居中 */
        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* 表單樣式 */
        table {
            background: rgba(255, 255, 255, 0.8); /* 透明背景使背景圖片可見 */
            border-collapse: collapse;
            width: 100%;
            max-width: 500px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        td {
            padding: 12px;
            font-size: 14px;
            color: #333;
        }

        td input[type="text"],
        td input[type="password"],
        td input[type="email"],
        td input[type="submit"],
        td input[type="reset"] {
            width: calc(100% - 30px); /* 寬度減少 30px */
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        td input[type="radio"] {
            margin-right: 5px;
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
            width: 100%;
            height: auto;
            margin-bottom: 20px;
        }

        /* 性別選擇欄位樣式 */
        .gender-section {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        /* 設置表單欄位的標籤 */
        label {
            font-weight: bold;
            color: #333;
        }

    </style>
</head>
<body>
    <div class="container">
        <form action="AddRegisterControler" method="post">
            <table border="1">
                <tr>
                    <td colspan="2" align="center">
                        <a href="index.jsp">
                            <img src="pic/logo.gif" alt="logo" class="logo">
                        </a>
                    </td>
                </tr>
                <tr>
                    <td>姓名：</td>
                    <td><input type="text" name="name" required size="50"></td>
                </tr>
                <tr>
                    <td>帳號：</td>
                    <td><input type="text" name="username" required size="50"></td>
                </tr>
                <tr>
                    <td>密碼：</td>
                    <td><input type="password" name="password" required size="50"></td>
                </tr>
                <tr>
                    <td>電話：</td>
                    <td><input type="text" name="phone" required size="50"></td>
                </tr>
                <tr>
                    <td>信箱：</td>
                    <td><input type="email" name="email" required placeholder="example@gmail.com" size="50"></td>
                </tr>
                <tr>
                    <td>性別：</td>
                    <td class="gender-section">
                        <input type="radio" name="gender" value="男">男
                        <input type="radio" name="gender" value="女">女
                    </td>
                </tr>
                <tr>
                    <td>地址：</td>
                    <td><input type="text" name="address" required placeholder="請填寫完整地址" size="50"></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="送出" onclick="alert('註冊成功')">
                        <input type="reset" value="重填">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <a href="VisitorCounterServlet?page=index.jsp">返回登入</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>