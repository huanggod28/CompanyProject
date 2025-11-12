package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;


@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter implements Filter {
       
   
    public LoginFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/*
		 * request , response-->轉型
		 * 1.檢查看 member資料夾的網頁內容的條件
		 * 2.查 session的物件-->Register
		 * 3.有->!=null-->進入LoginSucces.jsp
		 * 4.沒有->errMessage.jsp
		 */
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse res=(HttpServletResponse)response;
		HttpSession session=req.getSession();
		
		User user=(User)session.getAttribute("User");
		if(user!=null)
		{
			//res.sendRedirect("/Company/register/loginSuccess.jsp");  //與LoginController 切換頁面衝突
			chain.doFilter(request, response); //true時應不做切換頁面 false時才切換
		}
		else 
		{
			res.sendRedirect("login.jsp");
		}
		
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
