<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.ServletContext" %>
<%
    HttpSession sessionObj = request.getSession(false);
    ServletContext context = request.getServletContext();
    String name = (sessionObj != null) ? (String) sessionObj.getAttribute("name") : null;
    Integer visitorCount = (Integer) context.getAttribute("visitorCount");
    if (visitorCount == null) visitorCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>智能娃娃機營運監控系統</title>
    <link rel="icon" href="https://web.huanggod.myddns.me/Company/pic/icon.ico" type="image/x-icon">
    <!-- 引入 particles.js -->
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        /* 動態背景顏色改變 */
        @keyframes backgroundColorChange {
            0% {
                background-color: #1A1A1A; /* 深色背景 */
            }
            50% {
                background-color: #0A0A0A; /* 更暗的背景 */
            }
            100% {
                background-color: #1A1A1A;
            }
        }

        @keyframes textColorChange {
            0% {
                color: #00FFFF; /* 螢光藍 */
            }
            50% {
                color: #00FF00; /* 螢光綠 */
            }
            100% {
                color: #00FFFF;
            }
        }

        body {
        	height:948px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            margin: 0;
            background: linear-gradient(45deg, #1A1A1A, #0A0A0A); /* 漸變背景 */
            animation: backgroundColorChange 5s infinite alternate;
            position: relative; /* 需要讓粒子容器顯示在後方 */
        }

        /* 粒子動畫的容器 */
        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0; /* 確保粒子顯示在其他內容的後面 */
        }

        .container {
            display: flex;
            justify-content: center; /* 水平置中 */
            align-items: flex-start; /* 垂直靠上 */
            padding-top: 0;
        }

        .main-table {
            width: 1280px;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 0; /* 靠上 */
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(10px); /* 背景模糊效果 */
        }
        
        .main-table td {
		    vertical-align: top; /* 靠上 */
		}

        .header {
            text-align: center;
            background: rgba(0, 0, 0, 0.7); /* 暗色背景 */
            padding: 10px 0;
        }

        .header img {
            width: 1000px;
            height: auto;
            border: 5px solid #00FFFF; /* 螢光邊框 */
            border-radius: 10px;
        }

        .sidebar {
            width: 220px;
            background: rgba(0, 0, 0, 0.7); /* 深色背景 */
            padding: 15px;
            text-align: center;
            box-shadow: inset 0 0 10px rgba(0, 255, 255, 0.5); /* 內陰影效果 */
        }

        .sidebar .title {
            font-size: 22px;
            font-weight: bold;
            color: #00FFFF; /* 螢光藍 */
            margin-bottom: 10px;
            border-bottom: 2px solid #00FFFF;
            padding-bottom: 5px;
        }
        
        .sidebar a{
        	color: #00FFFF; /* 螢光藍 */
        }

        .menu {
            list-style: none;
            padding: 0;
        }

        .menu li {
            margin: 10px 0;
        }

        .menu a {
            display: block;
            padding: 10px;
            font-size: 18px;
            color: #fff;
            text-decoration: none;
            background: #333;
            border-radius: 5px;
            box-shadow: 0px 0px 5px rgba(0, 255, 255, 0.5); /* 發光效果 */
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .menu a:hover {
            background-color: #00FFFF; /* 螢光藍 */
            color: #333;
            box-shadow: 0px 0px 10px rgba(0, 255, 255, 1); /* 更強的發光效果 */
        }

        .content {
            width: 770px;
            background: rgba(0, 0, 0, 0.6);
            padding: 15px;
            border-left: 3px solid #00FFFF; /* 螢光藍邊框 */
            backdrop-filter: blur(8px); /* 背景模糊效果 */
        }

        .marquee {
            font-size: 20px;
            color: #00FFFF; /* 螢光藍 */
            padding: 5px 0;
            font-weight: bold;
            animation: textColorChange 5s infinite;
        }
        
        iframe{
        	height:700px;
        	border:none;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            background: rgba(0, 0, 0, 0.7);
            padding: 10px;
            position: relative;
            box-shadow: 0px -4px 10px rgba(0, 255, 255, 0.5); /* 底部發光效果 */
        }

        .bottom a {
            color: #00FFFF;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .bottom a:hover {
            color: #FF4500; /* 螢光橙 */
            text-decoration: underline;
        }

        .bottom img {
            position: absolute;
            right: 320px;
            top: 50%;
            transform: translateY(-50%);
            width: 30px;
            height: auto;
        }
        .bottom {
            text-align: center;
            font-size: 14px;
            padding: 10px;
            padding-bottom: 0px;
            position: relative;
        }
    </style>
</head>
<body>

<!-- 粒子背景 -->
<div id="particles-js"></div>

<div class="container">
    <table class="main-table">
        <tr>
            <td colspan="2" class="header">
                <a href="VisitorCounterServlet?page=register/loginSuccess.jsp" target="_top">
                    <img src="https://web.huanggod.myddns.me/Company/pic/logo_白色.png" alt="Logo">
                </a>
            </td>
        </tr>

        <tr>
            <td class="sidebar">
                <div class="title">智能娃娃機監控系統</div>
                <ul class="menu">
                    <li><a href="VisitorCounterServlet?page=register/profile.jsp" target="imain">個人資料</a></li>
                    <li><a href="VisitorCounterServlet?page=register/machineInformation.jsp" target="imain">機台資訊</a></li>
                    <li><a href="ChatController" target="imain">留言板</a></li>
                    <li><a href="VisitorCounterServlet?page=register/aboutUs.jsp" target="imain">認識我們</a></li>
                    <li><a href="VisitorCounterServlet?page=register/aboutMe.jsp" target="imain">聯絡我們</a></li>
                </ul>
                <p>歡迎使用者：<%= name %></p>
                <p>當前瀏覽人次：<%= visitorCount %></p>
                <p>維護：第二組</p>
                <p><a href="VisitorCounterServlet?page=/LogoutController">登出</a></p>
            </td>

            <td class="content">
                <div class="marquee">
                    <marquee>歡迎使用智能娃娃機營運監控系統，系統將於每天晚上12點自動更新</marquee>
                </div>
                <iframe src="VisitorCounterServlet?page=register/main3.html" name="imain" width="100%" height="600"></iframe>
            </td>
        </tr>

        <!--  <tr>
            <td colspan="2" class="footer">
                
                
            </td>
        </tr>-->
    </table>
</div>
<div class="bottom">© 2025 致理科大夜資四A第二組 - 所有權利保留
				<a href="VisitorCounterServlet?page=game/gameList.jsp" target="imain" alt="遊戲列表">
				<!-- <a href="https://game.hullqin.cn" target="imain" alt="遊戲列表"> -->
                    <img src="https://web.huanggod.myddns.me/Company/pic/2048_game_icon.png" alt="2048 Game Icon">
                </a>
</div>
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