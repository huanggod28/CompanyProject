package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.impl.FeedbackDaoImpl;
import model.Feedback;
import model.Register;

@WebServlet("/FeedbackUserServlet")
public class FeedbackUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDaoImpl dao = new FeedbackDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Register loginUser = (Register) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 尚未登入，導向登入頁
            response.sendRedirect("VisitorCounterServlet?page=index.jsp");
            return;
        }

        // 查詢該使用者自己送出的意見
        List<Feedback> feedbackList = dao.findByUserId(loginUser.getId());

        // 放入 request attribute 給 JSP 使用
        request.setAttribute("feedbackList", feedbackList);

        // 導向你的意見回復頁面
        request.getRequestDispatcher("VisitorCounterServlet?page=register/feedback.jsp").forward(request, response);
    }
}