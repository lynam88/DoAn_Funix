package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DonationsDAO;
import dao.UsersDAO;
import model.Donations;
import model.Users;

/**
 * Servlet implementation class UsersController
 */
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO dao;
	private String action;
	private String searchString;
	private int page;

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
			case "login":
				doLogin(request, response);
				break;
			case "user":
				listUser(request, response);
				break;
			default:
				showMainPage(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void listUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		page = 1;
		int recordPerPage = 5;
		String search = request.getParameter("myInput");
		if(search == null) search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		String role = request.getParameter("searchRole");
		if (role == null || role == "") {
			role = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchRole", role);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			dao.searchName(searchString, role);
			int noOfRecord = dao.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Users> listPerPage = dao.getRecord(searchString, role, page, recordPerPage);
			request.setAttribute("userList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/UserList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
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
