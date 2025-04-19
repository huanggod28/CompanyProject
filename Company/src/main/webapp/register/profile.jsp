<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
   HttpSession sessionObj = request.getSession(false);
   String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;

   if (username == null) {
       response.sendRedirect("../login.jsp"); // 未登入則導回登入頁
       return;
   }

   String name = (String) sessionObj.getAttribute("name");
   String phone = (String) sessionObj.getAttribute("phone");
   String email = (String) sessionObj.getAttribute("email");
   String genger = (String) sessionObj.getAttribute("genger");
   String address = (String) sessionObj.getAttribute("address");
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智能娃娃機營運監控系統</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #005f77;
            margin-top: 50px;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .profile-info {
            margin-bottom: 20px;
        }

        .profile-info p {
            font-size: 1.1em;
            color: #333;
            margin: 10px 0;
        }

        .profile-info strong {
            color: #005f77;
        }

        nav {
            text-align: center;
            margin-top: 20px;
        }

        nav a {
            background-color: #005f77;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        nav a:hover {
            background-color: #00445b;
        }
    </style>
</head>
<body>
    <h2>個人資料</h2>
    <div class="container">
        <div class="profile-info">
            <p><strong>姓名：</strong> <%= name %></p>
            <p><strong>帳號：</strong> <%= username %></p>
            <p><strong>電話：</strong> <%= phone %></p>
            <p><strong>Email：</strong> <%= email %></p>
            <p><strong>性別：</strong> <%= genger %></p>
            <p><strong>地址：</strong> <%= address %></p>
        </div>
        <nav>
            <a href="VisitorCounterServlet?page=register/main2.html">返回首頁</a>
        </nav>
    </div>
</body>
</html>