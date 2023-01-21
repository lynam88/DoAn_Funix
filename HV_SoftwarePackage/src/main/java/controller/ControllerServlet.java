package controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Accounts;
import commons.Utils;
import dao.DonationsDAO;
import dao.ExportService;
import model.Donations;

/**
 * Servlet implementation class ControllerServlet
 */
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DonationsDAO dao;

	private String action;

	private String searchString;

	public void init() {
		dao = new DonationsDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "list" : action;
		try {
			switch (action) {
//			case "login":
//				doLogin(request, response);
//				break;
			case "list":
			case "search":
				listDonation(request, response);
				break;
			case "new":
				showNewForm(request, response);
				break;
			case "edit":
				showEditForm(request, response);
				break;
			case "insert":
				insertDonation(request, response);
				break;
			case "delete":
				deleteDonation(request, response);
				break;
			case "update":
				updateDonation(request, response);
				break;
			case "export":
				exportDonation(request, response);
				break;
			default:
				listDonation(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

//	private void doLogin(HttpServletRequest request, HttpServletResponse response) {
//		response.setContentType("text/html;charset=UTF-8");
//		request.setCharacterEncoding("utf-8"); // Vietnamese
//
//		try {
//			request.getSession(true).invalidate();
//			// make sure that email is valid
//			String regexMail = "^[A-Z0-9_a-z]+@[A-Z0-9\\.a-z]+\\.[A-Za-z]{2,6}";
//			String regex = "[a-zA-Z0-9_!@#$%^&*]+";
//			// collect data from a login form
//			String email = request.getParameter("email");
//			String password = request.getParameter("password");
//			Accounts acc = new Accounts();
//			acc.setEmail(email);
//			acc.setPassword(password);
//			HttpSession session = request.getSession(true);
//			if (!password.matches(regex) || !email.matches(regexMail)) {
//				session.setAttribute("error", "invalid syntax");
//				response.sendRedirect("login.jsp");
//			}
//			if(request.getParameter("remember") != null) {
//				Cookie cookiesName = new Cookie("email", email);
//				cookiesName.setMaxAge(300);
//				response.addCookie(cookiesName);
//				Cookie cookiesPass = new Cookie("password", password);
//				cookiesPass.setMaxAge(300);
//				response.addCookie(cookiesPass);
//			}
//			// read information of account in database
//			String uid = getServletContext().getInitParameter("username");
//			String pwd = getServletContext().getInitParameter("password");
//			// check account - use validate code in assignment 1 to valid user
//			if (user != null && acc.getPwd().equals(pwd) && acc.getName().equalsIgnoreCase(uid)) {
//				// set session
//				session.setAttribute("user", user);
//				// login is valid, now redirect to index page of admin
//				response.sendRedirect("admin/index.jsp");
//			} else {
//				session.setAttribute("error", "wrong username of password");
//				response.sendRedirect("login.jsp");
//			}
//
//		} catch (NullPointerException e) {
//			RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
//			rd.forward(request, response);
//		} catch (Exception ex) {
//			response.getWriter().println(ex);
//		}
//	}

	private void listDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int page = 1;
		int recordPerPage = 6;
		String search = request.getParameter("myInput");
		if(search == null) search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		String status = request.getParameter("searchStatus");
		if (status == null) {
			status = "0";
		}
		request.setAttribute("searchText", searchString);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			List<Donations> temp = dao.search(searchString, status);
			int noOfRecord = dao.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Donations> listPerPage = dao.getRecord(searchString, status, (page - 1) * recordPerPage + 1, page * recordPerPage);
			if (action.equals("list")) {
				request.setAttribute("donationList", listPerPage);
			}
			if (action.equals("search")) {
				request.setAttribute("donationList", listPerPage);
			}
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("DonationList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("DonationForm.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Donations existingDonation = null;
		try {
			existingDonation = dao.getDonation(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("DonationForm.jsp");
		request.setAttribute("donations", existingDonation);
		dispatcher.forward(request, response);

	}

	private void insertDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		response.setContentType("text/htm;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {
			int status = Integer.parseInt(request.getParameter("status"));
			String title = request.getParameter("title");
			byte[] title_Bytes = title.getBytes(StandardCharsets.ISO_8859_1);
			title = new String(title_Bytes, StandardCharsets.UTF_8);
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			Date start = null, end = null;
			String totalNeeded = request.getParameter("totalNeeded");
			String content = request.getParameter("content");
			byte[] content_Bytes = content.getBytes(StandardCharsets.ISO_8859_1);
			content = new String(content_Bytes, StandardCharsets.UTF_8);

			if (!startDate.isEmpty() || !endDate.isEmpty()) {
				start = (Date) Utils.convertStringToDate(startDate);
				end = (Date) Utils.convertStringToDate(endDate);
			}
			Float totalNeededFloat = Utils.convertStringToFloat(totalNeeded);
			String src = request.getParameter("thumbnail");
			Donations d = new Donations(status, title, content, start, end, totalNeededFloat, src);
			dao.insertDonation(d);
			request.setAttribute("notifySave", "Thêm thành công.");
			request.setAttribute("statusSave", "OK");
			RequestDispatcher dispatcher = request.getRequestDispatcher("DonationForm.jsp");
			dispatcher.forward(request, response);
			return;
		} catch (Exception ex) {
			response.getWriter().println(ex);
			ex.printStackTrace();
			request.setAttribute("notifySave", "Thêm thất bại.");
			request.setAttribute("statusSave", "FAIL");
		}		
	}

	private void exportDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		ExportService exporter = new ExportService();
		try {
			exporter.export("Donations", searchString);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("DonationList.jsp");
		dispatcher.forward(request, response);
	}

	private void updateDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int id = Integer.parseInt(request.getParameter("id"));
		int status = Integer.parseInt(request.getParameter("status"));
		String title = request.getParameter("title");
		byte[] title_Bytes = title.getBytes(StandardCharsets.ISO_8859_1);
		title = new String(title_Bytes, StandardCharsets.UTF_8);
		String startDate = request.getParameter("startDate");
		Date start = (Date) Utils.convertStringToDate(startDate);
		String endDate = request.getParameter("endDate");
		Date end = (Date) Utils.convertStringToDate(endDate);
		String totalNeeded = request.getParameter("totalNeeded");
		Float totalNeededFloat = Utils.convertStringToFloat(totalNeeded);
		String content = request.getParameter("content");
		byte[] content_Bytes = content.getBytes(StandardCharsets.ISO_8859_1);
		content = new String(content_Bytes, StandardCharsets.UTF_8);
		String src = request.getParameter("thumbnail");	
		Donations d = new Donations(id, status, title, content, start, end, totalNeededFloat, src);
		try {
			dao.updateDonation(d);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("ControllerServlet?action=list");
	}

	private void deleteDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] ids = request.getParameter("id").split(",");
		List<Donations> list = new ArrayList();
		
		try {
			for(String id : ids) {
				Donations d = new Donations(Integer.parseInt(id));
				list.add(d);
			}
			dao.deleteDonation(list);
		} catch (Exception e) {
			throw new Exception(e);
		}
	}
}
