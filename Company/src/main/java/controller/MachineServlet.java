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
        System.out.println("📌 收到請求: locationId = " + locationIdStr); // Debug

        if (locationIdStr == null || locationIdStr.isEmpty()) {
            System.out.println("❌ 缺少 locationId");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少 locationId");
            return;
        }

        try {
            int locationId = Integer.parseInt(locationIdStr);
            System.out.println("📡 查詢機台資料，locationId: " + locationId);
            
            MachineDaoImpl machineDao = new MachineDaoImpl();
            List<Machine> machines = machineDao.getMachinesByLocationId(locationId);

            if (machines.isEmpty()) {
                System.out.println("⚠️ 此場地沒有機台");
            } else {
                for (Machine m : machines) {
                    System.out.println("✅ 找到機台: " + m.getName() + "，imageUrl: " + m.getImageUrl());
                }
            }

            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();
            out.print(gson.toJson(machines));
            out.flush();
        } catch (NumberFormatException e) {
            System.out.println("❌ locationId 格式錯誤: " + locationIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "locationId 必須是數字");
        } catch (Exception e) {
            System.out.println("❌ 伺服器發生錯誤: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器發生錯誤");
        }
    }
}