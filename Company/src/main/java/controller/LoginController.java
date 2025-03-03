package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.impl.RegisterDaoImpl;
import model.Register;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");

        Register register = new RegisterDaoImpl().findUsernameAndPassword(username, password);
        HttpSession session = request.getSession(); 
        String sessionCaptcha = (String) session.getAttribute("captcha");

        if (sessionCaptcha != null && sessionCaptcha.equalsIgnoreCase(captcha)) {
            if (register != null) { // 帳號密碼正確
            	session.setAttribute("Register", register);
            	session.setAttribute("id", register.getId());
                session.setAttribute("name", register.getName()); // 存入 name
                session.setAttribute("username", username);
                session.setAttribute("phone", register.getPhone());
                session.setAttribute("email", register.getEmail());
                session.setAttribute("genger", register.getGenger());
                session.setAttribute("address", register.getAddress());

                // 登入成功，跳轉到計數 Servlet，然後導向成功頁面
                response.sendRedirect("VisitorCounterServlet?page=register/loginSuccess.jsp");
            } else {
                response.sendRedirect("VisitorCounterServlet?page=loginError.jsp");
            }
        } else {
            response.sendRedirect("VisitorCounterServlet?page=loginCaptchaError.jsp");
        }
    }
}