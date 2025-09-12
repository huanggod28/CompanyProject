package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.MachineDaoImpl;

@WebServlet("/DeleteMachineServlet")
public class DeleteMachineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int machineId = Integer.parseInt(request.getParameter("machineId"));
        MachineDaoImpl machineDao = new MachineDaoImpl();
        machineDao.deleteMachine(machineId);
        response.sendRedirect("VisitorCounterServlet?page=register/machineInformation.jsp");
    }
}