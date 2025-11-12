package controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PollDAO;
import dao.impl.PollDAOImpl;
import model.Poll;
import model.User;

@WebServlet("/AdminPollsServlet")
public class AdminPollsServlet extends HttpServlet {
    private PollDAO pollDAO = new PollDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || user.getRole() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Poll> polls = pollDAO.getAllPolls();
        request.setAttribute("polls", polls);
        request.getRequestDispatcher("admin_polls.jsp").forward(request, response);
    }
}