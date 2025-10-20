package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

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
    
    // 建立 logger
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    static {
        try {
            // 把 log 寫到檔案 login.log
            FileHandler fileHandler = new FileHandler("login.log", true); // true = append
            fileHandler.setFormatter(new SimpleFormatter());
            logger.addHandler(fileHandler);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public LoginController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");

        Register register = new RegisterDaoImpl().findUsernameAndPassword(username, password);
        HttpSession session = request.getSession(); 
        String sessionCaptcha = (String) session.getAttribute("captcha");

        if (register != null) { // 帳號密碼正確
            if (register.isWhitelist()) {
                loginSuccess(session, register, username, response);
                return;
            }

            if (sessionCaptcha != null && sessionCaptcha.equalsIgnoreCase(captcha)) {
                loginSuccess(session, register, username, response);
            } else {
                logEvent("使用者 [" + username + "] 驗證碼錯誤，登入失敗");
                response.sendRedirect("VisitorCounterServlet?page=loginCaptchaError.jsp");
            }

        } else {
            logEvent("嘗試登入失敗，帳號 [" + username + "] 不存在或密碼錯誤");
            response.sendRedirect("VisitorCounterServlet?page=loginError.jsp");
        }
    }

    private void loginSuccess(HttpSession session, Register register, String username, HttpServletResponse response) throws IOException {
        session.setAttribute("Register", register);
        session.setAttribute("id", register.getId());
        session.setAttribute("name", register.getName());
        session.setAttribute("username", username);
        session.setAttribute("phone", register.getPhone());
        session.setAttribute("email", register.getEmail());
        session.setAttribute("genger", register.getGenger());
        session.setAttribute("address", register.getAddress());
        session.setAttribute("userId", register.getId());
        
        // 讓其他 Servlet 能直接取得登入使用者物件
        session.setAttribute("loginUser", register);

        logEvent("使用者 [" + register.getUsername() + "] 成功登入");

        response.sendRedirect("VisitorCounterServlet?page=register/loginSuccess.jsp");
    }

    // 統一 log 方法
    private void logEvent(String message) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String now = LocalDateTime.now().format(formatter);

        String logMessage = now + " - " + message;

        // 印到 console
        System.out.println(logMessage);
        // 寫到 log 檔
        logger.info(logMessage);
    }
}
