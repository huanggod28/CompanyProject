<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.ServletContext" %>
<%
	HttpSession sessionObj = request.getSession(false);
    ServletContext context = request.getServletContext();
    String name = (sessionObj != null) ? (String) sessionObj.getAttribute("name") : null;
    Integer visitorCount = (Integer) context.getAttribute("visitorCount");
    if (visitorCount == null) {
    	visitorCount = 0;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>智能娃娃機營運監控系統</title>
<link rel="icon" href="http://huanggod.myddns.me:8080/Company/pic/icon.ico" type="image/x-icon">
<style>
body {
    background-image: url('http://huanggod.myddns.me:8080/Company/pic/bacc01.jpg');
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
    background-size: cover;
    font-family: Arial, sans-serif;
    color: #333;
    margin: 0;
}

.container {
    display: flex;
    justify-content: center;
    padding-top: 0px;
}

.main-table {
    width: 1024px;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
}

.header {
    text-align: center;
    background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
    padding: 10px 0;
}

.header img {
    width: 1000px;
    height: auto;
}

.sidebar {
    width: 220px;
    background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
    padding: 15px;
    text-align: center;
}

.sidebar .title {
    font-size: 22px;
    font-weight: bold;
    color: #0056b3;
    margin-bottom: 10px;
    border-bottom: 2px solid #000;
    padding-bottom: 5px;
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
    color: white;
    text-decoration: none;
    background: #007BFF;
    border-radius: 5px;
    transition: background 0.3s;
}

.menu a:hover {
    background: #0056b3;
}

.content {
    width: 770px;
    background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
    padding: 15px;
    border-left: 3px solid #ccc;
}

.marquee {
    font-size: 20px;
    color: #0000FF;
    padding: 10px 0;
    font-weight: bold;
}

.footer {
    text-align: center;
    font-size: 14px;
    background: linear-gradient(to bottom, #D7EAFB, #FFFFFF);
    padding: 10px;
    position: relative;
}

.footer a {
    color: #007BFF;
    text-decoration: none;
}

.footer a:hover {
    text-decoration: underline;
}

/* 新增圖片的樣式 */
.footer img {
    position: absolute;
    right: 10px;  /* 使圖片靠右顯示 */
    top: 50%;
    transform: translateY(-50%);  /* 垂直居中 */
    width: 30px;  /* 圖片大小，可根據需要調整 */
    height: auto;
}
.footer div {
    position: absolute;
    right: 40px;  /* 使圖片靠右顯示 */
    top: 50%;
    transform: translateY(-50%);  /* 垂直居中 */
    width: 30px;  /* 圖片大小，可根據需要調整 */
    height: auto;
}
</style>
</head>
<body>

<div class="container">
  <table class="main-table">
    <!-- Header -->
    <tr>
      <td colspan="2" class="header">
        <a href="VisitorCounterServlet?page=register/loginSuccess.jsp" target="_top">
          <img src="http://huanggod.myddns.me:8080/Company/pic/logo4.png" alt="Logo">
        </a>
      </td>
    </tr>

    <!-- Main Content -->
    <tr>
      <!-- Sidebar -->
      <td class="sidebar">
        <div class="title">智能娃娃機監控系統</div>
        <ul class="menu">
          <li><a href="VisitorCounterServlet?page=register/profile.jsp" target="imain">個人資料</a></li>
          <li><a href="VisitorCounterServlet?page=register/machineInformation.jsp" target="imain">機台資訊</a></li>
          <li><a href="ChatController" target="imain">留言板</a></li>
          <li><a href="VisitorCounterServlet?page=register/aboutMe.jsp" target="imain">聯絡我們</a></li>
        </ul>
        <p>歡迎使用者：<%= name %></p>
        <p>當前瀏覽人次：<%= visitorCount %></p>
      </td>

      <!-- Main Content -->
      <td class="content">
        <div class="marquee">
          <marquee>歡迎使用智能娃娃機營運監控系統，系統將於每天晚上12點自動更新</marquee>
        </div>
        <iframe src="VisitorCounterServlet?page=register/main.html" name="imain" width="100%" height="600"></iframe>
      </td>
    </tr>

    <!-- Footer -->
    <tr>
      <td colspan="2" class="footer">
        維護：第二組 | <a href="VisitorCounterServlet?page=/LogoutController">登出</a>
        <!-- 在這裡放置圖片 -->
        <a href="VisitorCounterServlet?page=game/gameList.jsp" target="imain" alt="遊戲列表">
        <img class="2048" src="http://huanggod.myddns.me:8080/Company/pic/2048_game_icon.png" alt="2048 Game Icon">
        </a> 
        <!--  <div class="1A2B">       
	        <a href="VisitorCounterServlet?page=game/1A2Bgame/game1A2B.jsp" target="imain" alt="1A2B">
			    <img src="http://huanggod.myddns.me:8080/Company/pic/1A2B_game_icon.png" alt="1A2B Game Icon">
			</a>
		</div>-->
      </td>
    </tr>
  </table>
</div>

</body>
</html>