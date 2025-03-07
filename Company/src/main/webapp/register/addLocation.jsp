<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Location" %>
<%@ page import="dao.impl.LocationDaoImpl" %>
<%
    Integer Id = (Integer) session.getAttribute("id");
    if (Id == null) {
        response.sendRedirect("VisitorCounterServlet?page=login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>智能娃娃機營運監控系統</title>
</head>
<body>
	<h2>新增場地</h2>
    <form action="AddLocationServlet" method="post">
        <label for="name">場地名稱：</label>
        <input type="text" id="name" name="name" required><br>
        <label for="name">場地地址：</label>
        <input type="text" id="address" name="address" required>
        <button type="submit">新增場地</button>
    </form>

    <br>
    <a href="VisitorCounterServlet?page=register/machineInformation.jsp">返回機台資訊</a>
</body>
</html>