package controller;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = userDAO.login(username, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);

            // 根據權限導向不同頁面
            if (user.getRole() == 1) {
                response.sendRedirect("AdminPollsServlet");  // 管理員導向投票管理頁
            } else {
                response.sendRedirect("MyPollsServlet");     // 一般會員導向自己的投票頁
            }

        } else {
            request.setAttribute("error", "帳號或密碼錯誤");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}