package controller.admin;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ExportService;
import dao.UsersDAO;
import model.Users;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

/**
 * Servlet implementation class UsersController
 */
@WebServlet(name = "ManageUsersController", urlPatterns = { "/ManageUsersController" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ManageUsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO usersDAO;
	private String action;
	private String search;
	private String searchString;
	private String searchRole;
	private String searchStatus;
	private int page;
	private HttpSession session;
	Users sessionUser;
	Users userData;
	private int sessionRole;

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
		action = request.getParameter("action");
		action = action == null ? "UserSearch" : action;
		session = request.getSession();
		Users sessionUser = (Users) session.getAttribute("user");
		sessionRole = sessionUser.getRole();
		if (sessionUser != null && (sessionRole == 0 || sessionRole == 1)) {
			try {
				switch (action) {
				case "UserSearch":
					listUser(request, response);
					break;
				case "delete":
					deleteUser(request, response);
					break;
				case "updateRole":
					String notify = updateRole(request, response);
				    response.setContentType("text/plain; charset=UTF-8");
				    response.setCharacterEncoding("UTF-8");
				    response.getWriter().write(notify);
					break;
				case "updateStatus":
					updateStatus(request, response);
					break;
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "UserList" : action;
		session = request.getSession();
		sessionUser = (Users) session.getAttribute("user");
		if (sessionUser != null && (sessionRole == 0 || sessionRole == 1)) {
			try {
				switch (action) {
				case "UserList":
					listUser(request, response);
					break;
				case "new":
					showNewForm(request, response);
					break;
				case "edit":
					showEditForm(request, response);
					break;
				case "export":
					exportUser(request, response);
					break;
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
		}
	}

	private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");

		try {
			Users u = usersDAO.getUser(email);
			usersDAO.updateStatus(u);
		} catch (Exception e) {
			throw new Exception(e);
		}

		request.getRequestDispatcher("admin/jsp/UserList.jsp").forward(request, response);
	}

	private String updateRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");		

		try {
			Users u = usersDAO.getUser(email);
			if (sessionUser.getEmail().equals(u.getEmail())) {
				return "Bạn không được cập nhật chính mình.";
					
			} else if (sessionRole == 1 && (u.getRole() == 0 || u.getRole() == 1)) {				
				return "Bạn không được cập nhật ADMIN.";
								
			} else {
				usersDAO.updateRole(u);
				return  "Bạn đã cập nhật vai trò thành công.";				
			}
		} catch (
		Exception e) {
			return e.getMessage();
		}

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
		searchRole = request.getParameter("searchRole");
		if (searchRole == null || searchRole == "") {
			searchRole = "0";
		}
		searchStatus = request.getParameter("searchStatus");
		if (searchStatus == null || searchStatus == "") {
			searchStatus = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchRole", searchRole);
		request.setAttribute("searchStatus", searchStatus);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			usersDAO.search(searchString, searchRole, searchStatus);
			int noOfRecord = usersDAO.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Users> listPerPage = usersDAO.getRecord(searchString, searchRole, searchStatus, page, recordPerPage);
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
			downloadFile = new File(exporter.userExport(searchString, searchRole, searchStatus));
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

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] emails = request.getParameter("email").split(",");
		List<Users> list = new ArrayList<Users>();

		for (String email : emails) {
			Users u = usersDAO.getUser(email);
			if (u != null && u.getRole() == 2)
				list.add(u);
		}

		if (list.size() == 0) {
			request.setAttribute("notifyUserList", "Bạn không được phép xoá ADMIN.");
			request.setAttribute("statusUserList", "Fail");
		} else {
			try {
				usersDAO.deleteUser(list);
				request.setAttribute("notifyUserList", "Bạn đã xoá thành công.");
				request.setAttribute("statusUserList", "ok");
			} catch (Exception e) {
				request.setAttribute("notifyUserList", "Có lỗi xảy ra, xin vui lòng thử lại sau.");
				request.setAttribute("statusUserList", "Fail");
			}
		}
		request.getRequestDispatcher("admin/jsp/UserList.jsp").forward(request, response);
	}

}
