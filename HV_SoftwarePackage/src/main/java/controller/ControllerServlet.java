package controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import commons.Utils;
import dao.DonationsDAO;
import model.Donations;

/**
 * Servlet implementation class ControllerServlet
 */
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DonationsDAO dao;

	public void init() {
		dao = new DonationsDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		try {
			switch (action) {
			case "list":
				listDonation(request, response);
				break;
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
			default:
				listDonation(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}

	private void listDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int page = 1;
		int recordPerPage = 6;
		String text = request.getParameter("myInput");
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			List<Donations> temp = dao.search(text);
			int noOfRecord = dao.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Donations> list = dao.getRecord((page - 1) * recordPerPage + 1, page * recordPerPage);
			request.setAttribute("donationList", list);
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
			throws SQLException, IOException {
		response.setContentType("text/htm;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {
			HttpSession session = request.getSession(true);
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
			Donations d = new Donations(status, title, content, start, end, totalNeededFloat);
			dao.insertDonation(d);
			response.sendRedirect("ControllerServlet?action=list");
			return;
		} catch (Exception ex) {
			response.getWriter().println(ex);
			ex.printStackTrace();
		}
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

		Donations d = new Donations(status, title, content, start, end, totalNeededFloat);
		try {
			dao.updateDonation(d);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("ControllerServlet?action=list");
	}

	private void deleteDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));

		Donations d = new Donations(id);
		try {
			dao.deleteDonation(d);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("ControllerServlet?action=list");
	}
}
