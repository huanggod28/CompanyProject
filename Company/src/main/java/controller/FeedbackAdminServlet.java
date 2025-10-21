package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.impl.FeedbackDaoImpl;
import model.Feedback;
import model.Register;

@WebServlet("/FeedbackAdminServlet")
public class FeedbackAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDaoImpl dao = new FeedbackDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Register user = (Register) request.getSession().getAttribute("loginUser");
        if (user == null || !user.isWhitelist()) {
            response.sendRedirect("VisitorCounterServlet?page=register/admin/noPermission.jsp");//跳轉到無此權限頁面
            return;
        }

        List<Feedback> list = dao.findAll();
        request.setAttribute("feedbackList", list);
        request.getRequestDispatcher("VisitorCounterServlet?page=register/admin/feedback_admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String reply = request.getParameter("reply");
        int replyStatus = 1; // 已回覆
        dao.updateReply(id, reply, replyStatus);
        response.sendRedirect("FeedbackAdminServlet");
    }
}