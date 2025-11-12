package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.PollDAO;
import dao.impl.PollDAOImpl;
import model.Poll;
import model.User;

@WebServlet("/MyPollsServlet")
public class MyPollsServlet extends HttpServlet {

	private PollDAO pollDAO = new PollDAOImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 檢查登入
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 撈出使用者建立的投票
		List<Poll> polls = pollDAO.getPollsByUserId(user.getId());

		request.setAttribute("polls", polls);
		request.getRequestDispatcher("my_polls.jsp").forward(request, response);
	}
}