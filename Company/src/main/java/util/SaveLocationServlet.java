package util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SaveLocationServlet")
public class SaveLocationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // 確保處理編碼問題
        String locationIdStr = request.getParameter("locationId");

        if (locationIdStr == null || locationIdStr.trim().isEmpty()) {
            System.out.println("❌ [SaveLocationServlet] 缺少 locationId");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少 locationId");
            return;
        }

        try {
            int locationId = Integer.parseInt(locationIdStr.trim()); // 🔹 確保轉換數字沒問題
            HttpSession session = request.getSession();
            session.setAttribute("locationId", locationId);
            
            // Debug: 確認 session 是否正確存入
            System.out.println("✅ [SaveLocationServlet] locationId 存入 session: " + session.getAttribute("locationId"));

            response.getWriter().write("成功儲存 locationId: " + locationId);
        } catch (NumberFormatException e) {
            System.out.println("❌ [SaveLocationServlet] locationId 格式錯誤: " + locationIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "locationId 必須是數字");
        } catch (Exception e) {
            System.out.println("❌ [SaveLocationServlet] 伺服器錯誤: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器錯誤: " + e.getMessage());
        }
    }
}