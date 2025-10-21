package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.impl.FeedbackDaoImpl;
import model.Feedback;
import model.Register;

@WebServlet("/FeedbackSubmitServlet")
public class FeedbackSubmitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDaoImpl dao = new FeedbackDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html; charset=UTF-8"); // 改成 HTML

    	Register user = (Register) request.getSession().getAttribute("loginUser");
    	if (user == null) {
    	    response.getWriter().write("<span style='color:#00FFFF'>尚未登入，請先登入後再提交</span>");
    	    return;
    	}

    	String name = request.getParameter("name");
    	String subject = request.getParameter("subject");
    	String email = request.getParameter("email");
    	String message = request.getParameter("message");

    	// 驗證信箱格式
    	if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
    	    response.getWriter().write("<span style='color:#00FFFF'>信箱格式不正確</span>");
    	    return;
    	}

    	if (message.length() > 500) {
    	    response.getWriter().write("<span style='color:#00FFFF'>意見內容超過500字</span>");
    	    return;
    	}

    	Feedback f = new Feedback();
    	f.setUserId(user.getId());
    	f.setName(name);
    	f.setSubject(subject);
    	f.setEmail(email);
    	f.setMessage(message);

    	dao.insert(f);
    	response.getWriter().write("<span style='color:#00FFFF'>已成功送出意見，感謝您的回饋！</span>");
    	response.getWriter().write("<span style='color:#00FFFF'><a href=\"VisitorCounterServlet?page=register/main3.html\">返回首頁</span></a>");
    }
}