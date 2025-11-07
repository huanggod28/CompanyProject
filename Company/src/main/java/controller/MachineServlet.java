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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String locationIdStr = request.getParameter("locationId");
        System.out.println("📌 收到請求: locationId = " + locationIdStr);

        if (locationIdStr == null || locationIdStr.isEmpty()) {
            System.out.println("❌ 缺少 locationId");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少 locationId");
            return;
        }

        try {
            int locationId = Integer.parseInt(locationIdStr);
            MachineDaoImpl machineDao = new MachineDaoImpl();
            List<Machine> machines = machineDao.getMachinesByLocationId(locationId);

            if (machines.isEmpty()) {
                System.out.println("⚠️ 此場地沒有機台");
            } else {
                for (Machine m : machines) {
                    String imageUrl = m.getImageUrl();
                    String cameraUrl = m.getCameraUrl();

                    if (imageUrl != null && !imageUrl.isEmpty()) {
                        System.out.println("✅ 找到機台: " + m.getName() + "，圖片連結: " + imageUrl);
                    } else if (cameraUrl != null && !cameraUrl.isEmpty()) {
                        System.out.println("✅ 找到機台: " + m.getName() + "，攝影機連結: " + cameraUrl);
                    } else {
                        System.out.println("⚠️ 找到機台: " + m.getName() + "，但沒有上傳圖片或攝影機連結");
                    }
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