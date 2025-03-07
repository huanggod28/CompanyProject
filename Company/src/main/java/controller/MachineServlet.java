package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import dao.impl.MachineDaoImpl;
import model.Machine;

@WebServlet("/MachineServlet")
public class MachineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String locationIdStr = request.getParameter("locationId");

        if (locationIdStr == null || locationIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少 locationId");
            return;
        }

        try {
            int locationId = Integer.parseInt(locationIdStr);
            MachineDaoImpl machineDao = new MachineDaoImpl();
            List<Machine> machines = machineDao.getMachinesByLocationId(locationId);

            // **設定回傳格式**
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            // **使用 Gson 轉換 JSON**
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(machines);

            out.print(jsonResponse);
            out.flush();
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "locationId 必須是數字");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器發生錯誤: " + e.getMessage());
        }
    }
}