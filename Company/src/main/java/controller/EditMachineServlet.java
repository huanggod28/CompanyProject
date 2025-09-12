package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.MachineDaoImpl;
import model.Machine;

@WebServlet("/EditMachineServlet")
public class EditMachineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int machineId = Integer.parseInt(request.getParameter("machineId"));
        String name = request.getParameter("name");
        String cameraUrl = request.getParameter("cameraUrl");
        String imageUrl = request.getParameter("imageUrl");

        MachineDaoImpl machineDao = new MachineDaoImpl();
        Machine machine = new Machine();
        machine.setId(machineId);
        machine.setName(name);
        machine.setCameraUrl(cameraUrl.isEmpty() ? null : cameraUrl);
        machine.setImageUrl(imageUrl.isEmpty() ? null : imageUrl);

        machineDao.updateMachine(machine);
        response.sendRedirect("VisitorCounterServlet?page=register/machineInformation.jsp");
    }
}