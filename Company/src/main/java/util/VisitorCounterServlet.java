package util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

@WebServlet("/VisitorCounterServlet")
public class VisitorCounterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 取得 session
        HttpSession session = request.getSession(false); // false: 不建立新 session
        Boolean isLoggedIn = (session != null && session.getAttribute("Register") != null);

        // 設定哪些頁面需要登入
        String targetPage = request.getParameter("page");
        if (targetPage == null || targetPage.isEmpty()) {
            targetPage = "index.jsp"; // 預設首頁
        }

        // 受保護的頁面（需要登入）
        String[] protectedPages = {"register/aboutMe.jsp","register/chat.jsp","register/addLocation.jsp",
        		"register/addMachine.jsp", "register/loginSuccess.jsp", "register/machineInformation.jsp",
        		"register/profile.jsp",
        		"game/2048game/gameIndex.jsp","game/2048game/game.jsp","game/2048game/2048leaderboard.jsp",
        		"game/chineseTypingGame/gameIndex.jsp","game/chineseTypingGame/game.jsp","game/gameList","game/gameError",
        		"game/1A2Bgame/game1A2B.jsp","game/777game/777gameRules.jsp","game/777game/game777"};
        boolean needsLogin = false;
        for (String page : protectedPages) {
            if (targetPage.equals(page)) {
                needsLogin = true;
                break;
            }
        }

        // 如果目標頁面需要登入，且未登入，導向 login.jsp
        if (needsLogin && !isLoggedIn) {
            response.sendRedirect(request.getContextPath() + "/errMessage.jsp");
            return;
        }

        // 計數訪問人數
        ServletContext context = getServletContext();
        synchronized (this) {
            Integer count = (Integer) context.getAttribute("visitorCount");
            if (count == null) {
                count = 0;
            }
            count++;
            context.setAttribute("visitorCount", count);
        }

        // 轉發到目標頁面
        request.getRequestDispatcher("/" + targetPage).forward(request, response);
    }
}