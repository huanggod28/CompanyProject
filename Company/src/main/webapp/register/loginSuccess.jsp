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
<style>
body{
	background-image: url(http://huanggod.myddns.me:8080/Company/pic/bacc01.jpg);
	background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
    background-size: cover;
}
#div1 {
	height: 658px;
	width: 215px;
	border-bottom-width: medium;
	border-bottom-style: double;
	
}
#div2 {
	height: 29px;
	width: 215px;
}
#div3 {
	font-family: "標楷體";
	font-size: 24px;
	color: #0000FF;
	height: 29px;
	width: 770px;
}
.s1 {
	font-family: "標楷體";
	font-size: 24px;
	font-weight: 500;
	color: #D7A0FB;
	border-bottom-width: medium;
	border-bottom-style: solid;
	border-bottom-color: #000;
	width: 100px;
}
.s2 {
	font-size: 16px;
	color: #000000;
	background-image: url(http://huanggod.myddns.me:8080/Company/pic/menu1.png);
	line-height: 30px;
	height: 30px;
	background-repeat: no-repeat;
}
table{
	border-collapse:collapse;
}
#div1 table tr td .s2:hover {
	background-image: url("http://huanggod.myddns.me:8080/Company/pic/menu2.png);
	background-repeat: no-repeat;
}
</style>
</head>
<body>
<div align="center">
  <table width="1024" border="1">
    <tr>
      <td height="65" colspan="2" align="center" style="background:linear-gradient(to bottom, #D7EAFB, #FFFFFF);"><a href="VisitorCounterServlet?page=register/loginSuccess.jsp" target="_top" ><img src="http://huanggod.myddns.me:8080/Company/pic/logo3.png" width="1000" height="65" /></a></td>
    </tr>
    <tr>
      <td width="215" height="683" align="center" style="vertical-align:text-top; background:linear-gradient(to bottom, #D7EAFB, #FFFFFF);" ><div id="div1">
        <p class="s1">智能娃娃機營運監控系統</p>
        <table width="100%" border="0">
          <tr>
            <td align="center"><div class="s2"><a href="VisitorCounterServlet?page=register/profile.jsp" target="imain">個人資料</a></div></td>
          </tr>
          <tr>
            <td align="center"><div class="s2"><a href="VisitorCounterServlet?page=register/machineInformation.jsp" target="imain">機台資訊</a></div></td>
          </tr>
          <tr>
            <td align="center"><div class="s2"><a href="" target="imain"></a></div></td>
          </tr>
          <tr>
            <td align="center"><div class="s2"><a href="" target="imain"></a></div></td>
          </tr>
          <tr>
            <td align="center"><div class="s2"><a href="" target="imain"></a></div></td>
          </tr>
          <tr>
            <td align="center"><div class="s2"><a href="VisitorCounterServlet?page=register/aboutMe.jsp" target="imain">關於我們</a></div></td>
          </tr>
        </table>
    	<p>歡迎使用者：<%= name %></p>
    	<p>當前瀏覽人次： <%= visitorCount %></p>
        <p>&nbsp;</p>
      </div>
      <div id="div2" style="font-family: '標楷體'; font-size: 16px; color: #000000;">最近更新日期：2025/01/25</div></td>
      <td width="770" valign="top" style="background:linear-gradient(to bottom, #D7EAFB, #FFFFFF);"><div id="div3"><marquee>歡迎光臨智能娃娃機營運監控系統，系統將於每天晚上12點自動更新</marquee></div><iframe src="http://huanggod.myddns.me:8080/Company/main.html" name="imain" width="770" height="654"></iframe></td>
    </tr>
    <tr>
      <td height="20" colspan="2" align="center" style="font-family: '標楷體'; font-size: 16px; color: #000000; background:linear-gradient(to bottom, #D7EAFB, #FFFFFF);">網頁設計及維護：張哲豪
      <a href="VisitorCounterServlet?page=/LogoutController">登出</a></td>
    </tr>
  </table>
</div>


</body>
</html>