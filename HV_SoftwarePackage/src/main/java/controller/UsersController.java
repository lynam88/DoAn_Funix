package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Users;

/**
 * Servlet implementation class UsersController
 */
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String action;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsersController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "index" : action;
		try {
			switch (action) {
			case "login":
				doLogin(request, response);
				break;			
			default:
				showMainPage(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void doLogin(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8"); // Vietnamese
		request.getSession(true).invalidate();
		// collect data from a login form
		String user = request.getParameter("username");
		String password = request.getParameter("password");
		Users u = new Users();
		u.setName(user);
		u.setPassword(password);
		HttpSession session = request.getSession(true);
		if(request.getParameter("remember") != null) {
			Cookie cookiesName = new Cookie("username", user);
			cookiesName.setMaxAge(300);
			response.addCookie(cookiesName);
			Cookie cookiesPass = new Cookie("password", password);
			cookiesPass.setMaxAge(300);
			response.addCookie(cookiesPass);
		}
	}

	private void showMainPage(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

}
