package controller.admin;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import commons.MD5Library;
import commons.RandomPasswordGenerator;
import dao.ExportService;
import dao.UsersDAO;
import model.Users;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import org.apache.commons.io.IOUtils;


/**
 * Servlet implementation class UsersController
 */
@WebServlet(name = "ManageUsersController", urlPatterns = { "/ManageUsersController" })
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ManageUsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO usersDAO;
	private String action;
	private String search;
	private String searchString;
	private String searchStatus;
	private int page;
	private HttpSession session;
	Users userData;

	public void init() {
		usersDAO = new UsersDAO();
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManageUsersController() {
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
		action = action == null ? "login" : action;
		session = request.getSession();
		Users u = (Users) session.getAttribute("user");
		if (u != null && u.getRole() == 1) {
			try {
				switch (action) {
				case "admin":
					showAdminPage(request, response);
					break;
				case "UserList":
				case "UserSearch":
					listUser(request, response);
					break;
				case "new":
					showNewForm(request, response);
					break;
				case "edit":
					showEditForm(request, response);
					break;
				case "delete":
					deleteUser(request, response);
					break;
				case "export":
					exportUser(request, response);
					break;
				case "logout":
					doLogout(request, response);
					break;
				default:
					showAdminPage(request, response);
					break;
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
		}
		
	}
	
	private void showAdminPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("admin/jsp/index.jsp").forward(request, response);
	}
	
	private void listUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		page = 1;
		int recordPerPage = 5;
		search = request.getParameter("myInput");
		if (search == null)
			search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		searchStatus = request.getParameter("searchStatus");
		if (searchStatus == null || searchStatus == "") {
			searchStatus = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", searchStatus);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			usersDAO.searchName(searchString, searchStatus);
			int noOfRecord = usersDAO.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Users> listPerPage = usersDAO.getRecord(searchString, searchStatus, page, recordPerPage);
			request.setAttribute("UserList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/jsp/UserList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/jsp/UserForm.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String email = request.getParameter("email");
		Users existingUser = null;
		try {
			existingUser = usersDAO.getUser(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/jsp/UserForm.jsp");
		request.setAttribute("Users", existingUser);
		page = Integer.parseInt(request.getParameter("page"));
		request.setAttribute("page", page);
		dispatcher.forward(request, response);

	}
	
	private void exportUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		ExportService exporter = new ExportService();
		// reads input file from an absolute path
		File downloadFile = null;
		try {
			downloadFile = new File(exporter.userExport(searchString, searchStatus));
			FileInputStream inStream = new FileInputStream(downloadFile);

			// modifies response
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setContentLength((int) downloadFile.length());

			// forces download
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
			response.setHeader(headerKey, headerValue);

			// obtains response's output stream
			OutputStream outStream = response.getOutputStream();

			byte[] buffer = new byte[4096];
			int bytesRead = -1;

			while ((bytesRead = inStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			inStream.close();
			outStream.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
	}
	
	/**
	Performs the login process by collecting user input from the login form, checking the user's account
	information in the database, and creating a new session for the user. If the user has selected "remember me",
	creates cookies for their login information. The user is then forwarded to the login page with appropriate
	notifications based on the outcome of the login process.
	@param request the HTTP servlet request containing the user's input from the login form
	@param response the HTTP servlet response that will be sent to the client
	@throws ServletException if there is an error with the servlet
	@throws IOException if there is an error with the input or output
	*/
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Set response content type and request character encoding
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8"); // For Vietnamese language
			
		// Invalidate any existing session before creating a new one
		request.getSession(true).invalidate();
			
		// Collect user input from the login form
		String id = request.getParameter("loginId");
		String loginPass = request.getParameter("loginPass");
		String passDB = null;
		if(loginPass != null) {
			passDB = MD5Library.md5(loginPass);
		}
		// Create a new session for the user
		session = request.getSession(true);
			
		// If the user has selected "remember me", create cookies for their login information
		if (request.getParameter("remember") != null) {
			Cookie cookiesName = new Cookie("loginId", id);
			cookiesName.setMaxAge(300);
			response.addCookie(cookiesName);
			Cookie cookiesPass = new Cookie("loginPass", loginPass);
			cookiesPass.setMaxAge(300);
			response.addCookie(cookiesPass);
		}
			
		// Check the user's account information in the database
		if(id != null && loginPass != null) {
			try {
				userData = usersDAO.getUser(id);
				
				if (userData == null || !userData.getPassword().equals(passDB)) {
					request.setAttribute("notifyLogin", "Thông tin đăng nhập chưa đúng hoặc tài khoản chưa được đăng ký.");				
					
					// Forward the request and response to the login page
					request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
					return;
				} 
				
				if (userData.getStatus() == 1 && userData.getPassword().equals(passDB) && userData.getRole() == 1) {						
					session.setAttribute("user", userData);	
					
					// Forward the request and response to the admin page
					request.getRequestDispatcher("admin/jsp/index.jsp").forward(request, response);
					return;
				} 
				
				if (userData.getStatus() == 1 && userData.getPassword().equals(passDB) && userData.getRole() == 2) {					
					session.setAttribute("user", userData);
					
					// Forward the request and response to the user page
					request.getRequestDispatcher("user/jsp/index.jsp").forward(request, response);
					return;
				} 				 
				
				if (userData.getStatus() == 0) {
					request.setAttribute("notifyLogin", "Tài khoản đã bị khoá, vui lòng liên hệ admin.");						
					
					// Forward the request and response to the login page
					request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
					return;
				}
				
			} 
			catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("notifyLogin", "Có lỗi xảy ra, xin vui lòng thử lại sau.");					
			}
		}
		
		// Forward the request and response to the login page
		request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
		
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] emails = request.getParameter("email").split(",");
		List<Users> list = new ArrayList<Users>();
		
		for (String email : emails) {
			Users u = usersDAO.getUser(email);
			if(u != null && u.getRole() == 2) list.add(u);
		}
		
		if(list.size() == 0) {
			request.setAttribute("notifyDelete", "Bạn không được phép xoá ADMIN.");
			request.setAttribute("statusDelete", "Fail");
		} else {		
			try {
				usersDAO.deleteUser(list);
				request.setAttribute("notifyDelete", "Bạn đã xoá thành công.");
				request.setAttribute("statusDelete", "ok");
			} catch (Exception e) {
				request.setAttribute("notifyDelete", "Có lỗi xảy ra, xin vui lòng thử lại sau.");
				request.setAttribute("statusDelete", "Fail");
			}
		}		
		request.getRequestDispatcher("admin/UserList.jsp").forward(request, response);
	}

	

}
