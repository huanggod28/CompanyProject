package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.impl.LocationDaoImpl;
import model.Location;

@WebServlet("/AddLocationServlet")
public class AddLocationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer Id = (Integer) session.getAttribute("id");

        if (Id == null) {
            response.sendRedirect("VisitorCounterServlet?page=login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String address = request.getParameter("address");

        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect("addLocation.jsp?error=場地名稱不可為空");
            return;
        }

        Location location = new Location();
        location.setName(name);
        location.setUserId(Id);
        location.setAddress(address);

        LocationDaoImpl locationDao = new LocationDaoImpl();
        locationDao.addLocation(location);

        response.sendRedirect("VisitorCounterServlet?page=register/machineInformation.jsp");
    }
}