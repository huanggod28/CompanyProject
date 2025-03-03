package util;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LocationDao;
import dao.impl.LocationDaoImpl;
import model.Location;

@WebServlet("/MachineInformationServlet")
public class MachineInformationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");  // 確保 session 中有 userId

        if (userId != null) {
            // 使用 DAO 獲取該用戶的所有場地
            LocationDao locationDao = new LocationDaoImpl();
            List<Location> locations = locationDao.getLocationsByUserId(userId);

            // 傳遞場地資料到 JSP
            request.setAttribute("locations", locations);
            request.getRequestDispatcher("machineInformation.jsp").forward(request, response);
        } else {
            // 如果 session 中沒有 userId，重定向至登入頁面
            response.sendRedirect("login.jsp");
        }
    }
}
