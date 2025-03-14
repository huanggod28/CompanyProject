package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.impl.MachineDaoImpl;
import model.Machine;

@WebServlet("/AddMachineServlet")
public class AddMachineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String locationIdStr = request.getParameter("locationId");
        String machineName = request.getParameter("machineName");
        String cameraUrl = request.getParameter("cameraUrl").trim();
        String imageUrl = request.getParameter("imageUrl").trim();

        if (locationIdStr == null || locationIdStr.isEmpty() || machineName == null || machineName.isEmpty()) {
            response.sendRedirect("VisitorCounterServlet?page=register/addMachine.jsp?error=missingData");
            return;
        }

        int locationId = Integer.parseInt(locationIdStr);

        // 確保至少填入 cameraUrl 或 imageUrl
        if (cameraUrl.isEmpty() && imageUrl.isEmpty()) {
            response.sendRedirect("VisitorCounterServlet?page=register/addMachine.jsp?error=missingUrl");
            return;
        }

        // 確保只有一種 URL 被填入
        if (!cameraUrl.isEmpty() && !imageUrl.isEmpty()) {
            response.sendRedirect("VisitorCounterServlet?page=register/addMachine.jsp?error=multipleUrls");
            return;
        }

        // 創建機台物件
        Machine machine = new Machine();
        machine.setLocationId(locationId);
        machine.setName(machineName);
        machine.setCameraUrl(cameraUrl.isEmpty() ? null : cameraUrl);
        machine.setImageUrl(imageUrl.isEmpty() ? null : imageUrl);

        // 存入資料庫
        MachineDaoImpl machineDao = new MachineDaoImpl();
        machineDao.addMachine(machine);

        response.sendRedirect("VisitorCounterServlet?page=register/machineInformation.jsp");
    }
}