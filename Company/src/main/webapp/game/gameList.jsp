<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>遊戲列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100%;
            background: linear-gradient(to right, #0a0a0a, #1a1a1a);
            color: #ffffff;
        }

        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 0;
            width: 100%;
            height: 100%;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 30px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .sidebar {
            width: 250px;
            padding: 20px;
            background: rgba(0, 0, 0, 0.6);
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.2);
            backdrop-filter: blur(8px);
        }

        .title {
            font-size: 24px;
            font-weight: bold;
            color: #00FFFF;
            text-align: center;
            margin-bottom: 20px;
        }

        .menu {
            list-style: none;
            padding: 0;
            margin: 0;
            text-align: center;
        }

        .menu li {
            margin: 12px 0;
        }

        .menu a {
            display: block;
            padding: 10px 14px;
            font-size: 17px;
            color: #00FFFF;
            background-color: rgba(255, 255, 255, 0.05);
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .menu a:hover {
            background-color: rgba(0, 255, 255, 0.15);
            color: #ffffff;
            transform: translateX(5px);
        }

        .content {
            margin-left: 30px;
            flex: 1;
            background-color: rgba(255, 255, 255, 0.05);
            padding: 20px;
            border-radius: 12px;
            min-height: 400px;
            color: #eee;
            box-shadow: 0 0 10px rgba(0, 255, 255, 0.1);
        }
    </style>
</head>
<body>
<div id="particles-js"></div>

<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="title">🎮 遊戲列表</div>
        <ul class="menu">
            <li><a href="VisitorCounterServlet?page=game/1A2Bgame/game1A2B.jsp" target="imain">猜數字</a></li>
            <li><a href="VisitorCounterServlet?page=game/2048game/gameIndex.jsp" target="imain">2048</a></li>
            <li><a href="VisitorCounterServlet?page=game/777game/777gameRules.jsp" target="imain">777拉霸</a></li>
            <li><a href="VisitorCounterServlet?page=game/chineseTypingGame/gameIndex.jsp" target="imain">中打練習</a></li>
            <li><a href="VisitorCounterServlet?page=game/gameError.jsp" target="imain">井字遊戲</a></li>
            <li><a href="VisitorCounterServlet?page=game/gameError.jsp" target="imain">走迷宮</a></li>
            <li><a href="VisitorCounterServlet?page=game/gameError.jsp" target="imain">打地鼠</a></li>
            <li><a href="VisitorCounterServlet?page=game/gameError.jsp" target="imain">打磚塊</a></li>
            <li><a href="VisitorCounterServlet?page=game/gameError.jsp" target="imain">五子棋</a></li>
            <li><a href="VisitorCounterServlet?page=game/gameError.jsp" target="imain">貪食蛇</a></li>
        </ul>
    </div>
</div>

<!-- 粒子背景設定 -->
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
            opacity: 0.4,
            width: 1
        },
        move: {
            enable: true,
            speed: 2,
            direction: "none",
            out_mode: "bounce"
        }
    },
    interactivity: {
        events: {
            onhover: { enable: true, mode: "repulse" },
            onclick: { enable: true, mode: "push" }
        },
        modes: {
            repulse: { distance: 100 },
            push: { particles_nb: 4 }
        }
    },
    retina_detect: true
});
</script>
</body>
</html>