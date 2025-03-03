package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.RegisterDaoImpl;
import model.Register;


@WebServlet("/AddRegisterControler")
public class AddRegisterControler extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddRegisterControler() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Username=request.getParameter("username");
		boolean user=new RegisterDaoImpl().findByUsername(Username);
		
		if(user)
		{
			response.sendRedirect("addRegisterError.jsp");
		}
		else {
		String Name=request.getParameter("name");
		String Password=request.getParameter("password");
		String Phone=request.getParameter("phone");
		String Email=request.getParameter("email");
		String Genger=request.getParameter("genger");
		String Address=request.getParameter("address");
		
		
		new RegisterDaoImpl().addRegister(Name, Username, Password, Phone, Email, Genger, Address);
		
		response.sendRedirect("addRegisterSuccess.jsp");
		}
	}

}
