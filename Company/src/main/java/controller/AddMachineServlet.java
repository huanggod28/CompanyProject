package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.impl.MachineDaoImpl;
import model.Machine;

@WebServlet("/AddMachineServlet")
public class AddMachineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer Id = (Integer) session.getAttribute("id");

        if (Id == null) {
            response.sendRedirect("VisitorCounterServlet?page=login.jsp");
            return;
        }

        String locationIdStr = request.getParameter("locationId");
        String machineName = request.getParameter("machineName");
        String cameraUrl = request.getParameter("cameraUrl");

        if (locationIdStr == null || machineName == null || cameraUrl == null || 
            locationIdStr.trim().isEmpty() || machineName.trim().isEmpty() || cameraUrl.trim().isEmpty()) {
            response.sendRedirect("addMachine.jsp?error=請填寫所有欄位");
            return;
        }

        int locationId = Integer.parseInt(locationIdStr);

        MachineDaoImpl machineDao = new MachineDaoImpl();
        int machineCount = machineDao.getMachineCountByLocation(locationId);

        if (machineCount >= 20) {
            response.sendRedirect("VisitorCounterServlet?page=register/addMachine.jsp?error=該場地已達最多20台機台");
            return;
        }

        Machine machine = new Machine();
        machine.setLocationId(locationId);
        machine.setName(machineName);
        machine.setCameraUrl(cameraUrl);

        machineDao.addMachine(machine);

        response.sendRedirect("VisitorCounterServlet?page=register/machineInformation.jsp");
    }
}