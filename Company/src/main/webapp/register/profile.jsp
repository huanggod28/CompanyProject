<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
   HttpSession sessionObj = request.getSession(false);
   String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;

   if (username == null) {
       response.sendRedirect("../login.jsp");
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
    <title>智能娃娃機營運監控系統 - 個人資料</title>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
            top: 0;
            left: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #0a0a0a, #1a1a1a);
            color: #fff;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #00FFFF;
            margin-top: 50px;
        }

        .container {
            width: 80%;
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
            backdrop-filter: blur(8px);
        }

        .profile-info {
            margin-bottom: 20px;
        }

        .profile-info p {
            font-size: 1.2em;
            margin: 12px 0;
            color: #ccc;
        }

        .profile-info strong {
            color: #00FFFF;
        }

        nav {
            text-align: center;
            margin-top: 30px;
        }

        nav a {
            background-color: #00FFFF;
            color: #000;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        nav a:hover {
            background-color: #00cccc;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div id="particles-js"></div>

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
        <a href="VisitorCounterServlet?page=register/main3.html">返回首頁</a>
    </nav>
</div>

<!-- 粒子特效設定 -->
<script>
particlesJS("particles-js", {
    particles: {
        number: { value: 80 },
        color: { value: "#00ffff" },
        shape: { type: "circle" },
        opacity: { value: 0.3 },
        size: { value: 3 },
        line_linked: {
            enable: true,
            distance: 150,
            color: "#00ffff",
            opacity: 0.3,
            width: 1
        },
        move: { enable: true, speed: 2 }
    },
    interactivity: {
        events: { onhover: { enable: true, mode: "grab" } },
        modes: {
            grab: { distance: 200, line_linked: { opacity: 0.5 } }
        }
    },
    retina_detect: true
});
</script>

</body>
</html>