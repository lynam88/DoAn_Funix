package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;

import dao.UsersDAO;
import model.Donations;
import model.Users;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

/**
 * Servlet implementation class UsersController
 */
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO dao;
	private String action;
	private String searchString;
	private int page;
	private HttpSession session;

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
		action = action == null ? "admin" : action;
		session = request.getSession();
		if (action.equals("login")) {
			doLogin(request, response);
		} else {
			Users u = (Users) session.getAttribute("user");
			if (u != null && u.getRole() == 1) {
				try {
					switch (action) {
					case "admin":
						showMainPage(request, response);
						break;
					case "UserList":
					case "userSearch":
						listUser(request, response);
						break;
					case "delete":
						deleteUser(request, response);
						break;
					case "sendMail":
						sendMail(request, response);
						break;
					case "logout":
						doLogout(request, response);
						break;
					default:
						showMainPage(request, response);
						break;
					}
				} catch (Exception ex) {
					throw new ServletException(ex);
				}
			} else {
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}

	private void sendMail(HttpServletRequest request, HttpServletResponse response)
			throws MessagingException, UnsupportedEncodingException {		

	}

	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	private void listUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		page = 1;
		int recordPerPage = 5;
		String search = request.getParameter("myInput");
		if (search == null)
			search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		String searchStatus = request.getParameter("searchStatus");
		if (searchStatus == null || searchStatus == "") {
			searchStatus = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", searchStatus);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			dao.searchName(searchString, searchStatus);
			int noOfRecord = dao.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Users> listPerPage = dao.getRecord(searchString, searchStatus, page, recordPerPage);
			request.setAttribute("UserList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/UserList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public Users checkLogin(String id, String password, boolean isLogin) throws Exception {
		Users ud = dao.getUser(id, password, isLogin);
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
		session = request.getSession(true);
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
			Users userData = checkLogin(id, password, true);
			if (userData.getEmail() != null || userData.getPhone() != null) {
				request.setAttribute("notifyLogin", "Chúc mừng bạn đã đăng nhập thành công.");
				request.setAttribute("statusLogin", "Ok");
				session.setAttribute("user", userData);
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

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] emails = request.getParameter("email").split(",");
		List<Users> list = new ArrayList<Users>();

		try {
			for (String email : emails) {
				Users u = dao.getUser(email, null, false);
				list.add(u);
			}
			dao.deleteUser(list);

		} catch (Exception e) {
			throw new Exception(e);
		}
	}

	private void showMainPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("admin/index.jsp").forward(request, response);
	}

}
