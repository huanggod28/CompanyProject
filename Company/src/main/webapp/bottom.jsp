<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ServletContext context = request.getServletContext();
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
</head>
<body>
<center><p>當前瀏覽人次: <%= visitorCount %></p></center>
</body>
</html>