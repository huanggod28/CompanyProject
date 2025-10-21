<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>聯絡我們</title>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #0a0a0a, #1a1a1a);
            color: #fff;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
            top: 0;
            left: 0;
        }

        .container {
            width: 90%;
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
        }

        h1 {
            text-align: center;
            color: #00ffff;
            font-size: 28px;
            margin-bottom: 20px;
        }
        
        a{
        	color: white;
        	text-decoration: none;
        }
        
        a:hover{
        	text-decoration: underline;
        }

        .contact-info h2 {
            font-size: 20px;
            color: #00ffff;
            margin-bottom: 10px;
        }

        .contact-info p {
            font-size: 14px;
            color: #ccc;
            line-height: 1.6;
        }
        
        .contact-info a {
            font-size: 14px;
            color: #00FFFF;
            line-height: 1.6;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            font-size: 12px;
            color: #888;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
        }
    </style>
</head>
<body>

<div id="particles-js"></div>

<div class="container">
    <h1>聯絡我們</h1>
    <div class="contact-info">
        <h2>我們的聯絡方式</h2>
        <p><strong>單位：</strong>致理科大夜資四A第二組</p>
        <p><strong>地址：</strong>新北市板橋區文化路313號</p>
        <p><strong>電話：</strong>(02) 1234-5678</p>
        <p><strong>電子郵件：</strong>61110125@example.com</p>
        <p><a href="FeedbackUserServlet">回饋表單填寫</a></p>
        <!-- 設定只有管理者才能看到 -->
        <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.whitelist}">
		    <a href="FeedbackAdminServlet">管理意見回覆</a>
		</c:if>
    </div>
</div>

<div class="footer">
    <p>© 2025 致理科大夜資四A第二組 - 所有權利保留</p>
</div>

<script>
particlesJS("particles-js", {
    particles: {
        number: { value: 60 },
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