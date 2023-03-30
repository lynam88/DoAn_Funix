package controller.admin;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import commons.Utils;
import dao.DonationsDAO;
import dao.UsersDAO;
import dao.UsersDonationDAO;
import model.Users;
import model.Donations;

/**
 * Servlet implementation class DonationsController
 */
@WebServlet(name = "UsersDonationController", urlPatterns = { "/UsersDonationController" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UsersDonationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DonationsDAO donationsDAO;
	private UsersDAO usersDAO;
	private UsersDonationDAO UsersDonationDAO;
	private String action;
	private String search;
	private String status;
	private String category;
	private String searchString;
	private int page;
	HttpSession session;
	Users sessionUser;

	public void init() {
		usersDAO = new UsersDAO();
		donationsDAO = new DonationsDAO();
		UsersDonationDAO = new UsersDonationDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "showMakeDonationPage" : action;
		try {
			List<Donations> listDonations = donationsDAO.search("", "0", "0");
			request.setAttribute("DonationList", listDonations);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		session = request.getSession();
		sessionUser = (Users) session.getAttribute("user");
		switch (action) {
		case "makeDonation":
			try {
				String notifyMakeDonation = makeDonation(request, response);
				response.setContentType("text/plain; charset=UTF-8");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(notifyMakeDonation);
				break;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "showMakeDonationPage" : action;
		try {
			List<Donations> listDonations = donationsDAO.search("", "0", "0");
			request.setAttribute("DonationList", listDonations);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		session = request.getSession();
		sessionUser = (Users) session.getAttribute("user");
		switch (action) {
		case "UsersDonationList":				
			UsersDonationList(request, response);
			break;
		case "showMakeDonationPage":
			try {
				showMakeDonationPage(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case "donationGuide":
			showDonationGuide(request, response);
			break;
		case "donations":
			try {
				showDonations(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "donationPost":
			showDonationPost(request, response);
			break;
		}
	}

	private void UsersDonationList(HttpServletRequest request, HttpServletResponse response) {
		page = 1;
		int recordPerPage = 5;
		search = request.getParameter("myInput");
		if (search == null)
			search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		status = request.getParameter("searchStatus");
		category = request.getParameter("category");
		if (status == null || status == "") {
			status = "0";
		}
		if (category == null || category == "") {
			category = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", status);
		request.setAttribute("category", category);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			UsersDonationDAO.search(searchString, status);
			int noOfRecord = donationsDAO.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Donations> listPerPage = donationsDAO.getRecord(searchString, status, category, page, recordPerPage);
			request.setAttribute("UsersDonationList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/jsp/DonationList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	private void showDonationGuide(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("user/jsp/donationGuide.jsp").forward(request, response);
	}

	private void showDonations(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int page = 1;
		int recordPerPage = 6;
		String category = request.getParameter("category");
		if (category == null || category == "") {
			category = "0";
		}
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		donationsDAO.search("", "0", category);
		int noOfRecord = donationsDAO.getNoOfRecords();
		int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
		List<Donations> listPerPage = donationsDAO.getRecord("", "0", category, page, recordPerPage);
		request.setAttribute("DonationList", listPerPage);
		request.setAttribute("noOfPage", noOfPage);
		request.setAttribute("currentPage", page);
		request.getRequestDispatcher("user/jsp/donations.jsp").forward(request, response);
	}

	private void showDonationPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Donations existingDonation = null;
		try {
			existingDonation = donationsDAO.getDonation(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("donation", existingDonation);
		RequestDispatcher dispatcher = request.getRequestDispatcher("user/jsp/donationPost.jsp");
		dispatcher.forward(request, response);
	}

	private void showMakeDonationPage(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		String donationTitle = request.getParameter("donationTitle");
		RequestDispatcher dispatcher = request.getRequestDispatcher("user/jsp/makeDonation.jsp");
		request.setAttribute("donationTitle", donationTitle);
		dispatcher.forward(request, response);
	}

	private String makeDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {

			// Get form input data			
			String name = request.getParameter("name");		
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String bank = request.getParameter("bank");
			String transactionId = request.getParameter("transactionId");
			int donationId = Integer.parseInt(request.getParameter("donationId"));
			String donationAmount = request.getParameter("donationAmount").replaceAll(",", "");;
			Float donationAmountFloat = Utils.convertStringToFloat(donationAmount);			

			// Create new user object
			Users u = new Users(name, phone, email, bank, transactionId, donationId, donationAmountFloat);			
			if (sessionUser == null && phone != null && usersDAO.getUser(phone) != null) {
				return "0";

			} else if (sessionUser == null && usersDAO.getUser(email) != null) {
				return "1";

			} else {
				// Insert user donation data to database
				UsersDonationDAO.insertUsersDonation(u);
				return "2";
			}

		} catch (Exception e) {
			return e.getMessage();
		}
	}
}
