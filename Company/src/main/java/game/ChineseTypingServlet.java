package game;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChineseTypingServlet
 */
@WebServlet("/ChineseTypingServlet")
public class ChineseTypingServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int score = Integer.parseInt(request.getParameter("score"));
        int time = Integer.parseInt(request.getParameter("time"));

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>遊戲結果</title></head><body>");
        out.println("<h1>遊戲結束</h1>");
        out.println("<p>得分: " + score + "</p>");
        out.println("<p>遊玩時間: " + time + " 秒</p>");
        out.println("<a href='game/chineseTypingGame/game.jsp'>返回遊戲</a>");
        out.println("</body></html>");
    }
}