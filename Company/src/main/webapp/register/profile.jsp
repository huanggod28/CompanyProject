<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
   HttpSession sessionObj = request.getSession(false);
   String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;

   if (username == null) {
       response.sendRedirect("../login.jsp"); // 未登入則導回登入頁
       return;
   }

   String name = (String) sessionObj.getAttribute("name");
   String phone = (String) sessionObj.getAttribute("phone");
   String email = (String) sessionObj.getAttribute("email");
   String gender = (String) sessionObj.getAttribute("gender");
   String address = (String) sessionObj.getAttribute("address");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>智能娃娃機營運監控系統</title>
</head>
<body>
<h2>個人資料</h2>
    <p><strong>姓名：</strong> <%= name %></p>
    <p><strong>帳號：</strong> <%= username %></p>
    <p><strong>電話：</strong> <%= phone %></p>
    <p><strong>Email：</strong> <%= email %></p>
    <p><strong>性別：</strong> <%= gender %></p>
    <p><strong>地址：</strong> <%= address %></p>

    <nav>
        <a href="VisitorCounterServlet?page=main.html">返回首頁</a>
    </nav>
</body>
</html>