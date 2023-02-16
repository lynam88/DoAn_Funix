package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import commons.Utils;
import dao.DonationsDAO;
import dao.ExportService;
import model.Users;
import model.Donations;

/**
 * Servlet implementation class DonationsController
 */
public class DonationsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DonationsDAO dao;
	private String action;
	private String search;
	private String searchString;
	private int page;
	HttpSession session;

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
		action = action == null ? "DonationList" : action;
		session = request.getSession();
		Users u = (Users) session.getAttribute("user");
		if (u != null && u.getRole() == 1) {
			try {
				switch (action) {
				case "DonationList":
				case "DonationSearch":
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
					showDashboard(request, response);
					break;
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	private void showDashboard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/index.jsp");
		dispatcher.forward(request, response);
	}

	private void listDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		page = 1;
		int recordPerPage = 5;
		search = request.getParameter("myInput");
		if (search == null)
			search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		String status = request.getParameter("searchStatus");
		if (status == null || status == "") {
			status = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", status);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			dao.search(searchString, status);
			int noOfRecord = dao.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Donations> listPerPage = dao.getRecord(searchString, status, page, recordPerPage);
			request.setAttribute("DonationList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/DonationList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/DonationForm.jsp");
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/DonationForm.jsp");
		request.setAttribute("donations", existingDonation);
		page = Integer.parseInt(request.getParameter("page"));
		request.setAttribute("page", page);
		dispatcher.forward(request, response);

	}

	private void insertDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		response.setContentType("text/htm;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {
			String status = request.getParameter("status");
			String title = request.getParameter("title");
			byte[] title_Bytes = title.getBytes(StandardCharsets.ISO_8859_1);
			title = new String(title_Bytes, StandardCharsets.UTF_8);
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			Date start = null, end = null;
			String totalNeeded = request.getParameter("totalNeeded").replaceAll(",", "");
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

		} catch (Exception ex) {
			request.setAttribute("notifySave", "Thêm thất bại.");
			request.setAttribute("statusSave", "FAIL");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/DonationForm.jsp");
		dispatcher.forward(request, response);
	}

	private void exportDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		ExportService exporter = new ExportService();
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		// reads input file from an absolute path
		File downloadFile = null;
		try {
			downloadFile = new File(exporter.export(searchString));
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

	private void updateDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int id = Integer.parseInt(request.getParameter("id"));
		String status = request.getParameter("status");
		String title = request.getParameter("title");
		byte[] title_Bytes = title.getBytes(StandardCharsets.ISO_8859_1);
		title = new String(title_Bytes, StandardCharsets.UTF_8);
		String startDate = request.getParameter("startDate");
		Date start = (Date) Utils.convertStringToDate(startDate);
		String endDate = request.getParameter("endDate");
		Date end = (Date) Utils.convertStringToDate(endDate);
		String totalNeeded = request.getParameter("totalNeeded").replaceAll(",", "");
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
		page = Integer.parseInt(request.getParameter("page"));
		response.sendRedirect("DonationsController?action=DonationList&page=" + page);
	}

	private void deleteDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] ids = request.getParameter("id").split(",");
		List<Donations> list = new ArrayList<Donations>();

		try {
			for (String id : ids) {
				Donations d = new Donations(Integer.parseInt(id));
				list.add(d);
			}
			dao.deleteDonation(list);
		} catch (Exception e) {
			throw new Exception(e);
		}
	}
}
