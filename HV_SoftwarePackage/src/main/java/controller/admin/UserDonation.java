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


/**
 * Servlet implementation class UsersController
 */
@WebServlet(name = "UserDonation", urlPatterns = { "/UserDonation" })
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class UserDonation extends HttpServlet {
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
	public UserDonation() {
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
				default:
					listUser(request, response);
					break;
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
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