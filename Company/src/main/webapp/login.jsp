<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!-- 掛載jstl -->
<!DOCTYPE html>
<html>
<% %>
<head>
<meta charset="UTF-8">
<title>智能娃娃機營運監控系統</title>
<style>
table{
	background-color: powderblue;
	border-color:black;
	border-collapse:collapse;
}
</style>
</head>
<body>
<form action="LoginController" method="post">
<table width=500px align=center border=2" style="background:linear-gradient(to bottom, #D7EAFB, #FFFFFF);">
	<tr align="center">
		<td width=100% colspan=2 align=center>
		<a href="VisitorCounterServlet?page=index.jsp"><img src="pic/logo.gif" alt="logo"></a>
	<tr>
		<td width=200px>帳號：</td>
		<td width=300px><input type=text name="username" size=50></td>
	<tr>
		<td width=200px>密碼：</td>
		<td><input type=password name="password" size=50></td>
	<tr>
		<td width=200px>驗證碼：</td>
		<td valign="middle"><input type="text" name="captcha" required size=26>
		<img src="CaptchaServlet" alt="驗證碼" onclick="this.src='CaptchaServlet?'+Math.random()"></td>
	<tr>
		<td colspan=2 align="center">
		<input type=submit value=登入>
		<input type=reset value=重置>
	<tr>
		<td colspan=2 align=center>
		<a href="VisitorCounterServlet?page=register.jsp">註冊帳號</a>
		<br>
</table>
</form>
 
</body>
</html>