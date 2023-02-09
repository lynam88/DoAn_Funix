package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DonationsDAO;
import dao.UsersDAO;
import model.Users;

/**
 * Servlet implementation class UsersController
 */
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO dao;
	private String action;

	public void init() {
		dao = new UsersDAO();
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UsersController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "index" : action;
		try {
			switch (action) {
			case "index":
				showMainPage(request, response);
				break;
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

	public Users checkLogin(String id, String password) throws Exception {
	    Users ud = dao.getUser(id, password);
	    return ud;
	}

	private void doLogin(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    response.setContentType("text/html;charset=UTF-8");
	    request.setCharacterEncoding("utf-8"); // Vietnamese
	    request.getSession(true).invalidate();
	    // collect data from a login form
	    String id = request.getParameter("loginId");
	    String password = request.getParameter("password");
	    HttpSession session = request.getSession(true);
	    if (request.getParameter("remember") != null) {
	        Cookie cookiesName = new Cookie("loginId", id);
	        cookiesName.setMaxAge(300);
	        response.addCookie(cookiesName);
	        Cookie cookiesPass = new Cookie("password", password);
	        cookiesPass.setMaxAge(300);
	        response.addCookie(cookiesPass);
	    }
	    // check information of account in database
	    try {
	        Users userData = checkLogin(id, password);
	        if (userData.getEmail() != null || userData.getPhone() != null) {
	            request.setAttribute("notifyLogin", "Chúc mừng bạn đã đăng nhập thành công.");
	            if (userData.getRole() == 0) {
	                request.setAttribute("statusLogin", "Admin");
	            } else {
	                request.setAttribute("statusLogin", "User");
	            }
	        } else {
	            request.setAttribute("notifyLogin", "Số điện thoại/ Email hoặc mật khẩu chưa đúng.");
	            request.setAttribute("statusLogin", "Fail");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("notifyLogin", "Có lỗi xảy ra, xin vui lòng thử lại sau.");
	        request.setAttribute("statusLogin", "Fail");
	    }
	    request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	private void showMainPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("admin/index.jsp").forward(request, response);		
	}

}