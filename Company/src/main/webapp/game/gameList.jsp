<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>遊戲列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            display: flex;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .sidebar {
            width: 200px;
            padding: 15px;
            background: #007BFF;
            border-radius: 10px;
            color: white;
            text-align: center;
        }
        .title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .menu li {
            margin: 10px 0;
        }
        .menu a {
            display: block;
            padding: 10px;
            font-size: 18px;
            color: white;
            text-decoration: none;
            background: #0056b3;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .menu a:hover {
            background: #003f7f;
        }
        .content {
            width: 770px;
            background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
            padding: 15px;
            border-left: 3px solid #ccc;
            margin-left: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="title">遊戲列表</div>
            <ul class="menu">
                <li><a href="VisitorCounterServlet?page=game/1A2Bgame/game1A2B.jsp" target="imain">猜數字</a></li>
                <li><a href="VisitorCounterServlet?page=game/2048game/gameIndex.jsp" target="imain">2048</a></li>
                <li><a href="VisitorCounterServlet?page=game/777game/777gameRules.jsp" target="imain">777拉霸</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">井字遊戲</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">走迷宮</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">打地鼠</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">打磚塊</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">五子棋</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">貪食蛇</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">賽車</a></li>
                <!-- <li><a href="VisitorCounterServlet?page=game/" target="imain">英打練習</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">中打練習</a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain"></a></li>
                <li><a href="VisitorCounterServlet?page=game/" target="imain">返回遊戲列表</a></li> -->
            </ul>
        </div>
        
        
    </div>
</body>
</html>