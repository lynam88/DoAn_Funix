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
import model.Donations;
import model.Users;
import model.UsersDonation;

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
	private String searchString;
	private int page;
	HttpSession session;
	Object sessionUser;

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
		case "UsersDonationSearch":
			UsersDonationList(request, response);
			break;
		case "updateStatus":
			String notifyStatus = null;
			try {
				notifyStatus = updateStatus(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    response.setContentType("text/plain; charset=UTF-8");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(notifyStatus);
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
		sessionUser = session.getAttribute("user");
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

	private String updateStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String userDonationStatus = request.getParameter("userDonationStatus");
		int userDonationId = Integer.parseInt(request.getParameter("userDonationId"));		
		
		try {
			UsersDonation ud = new UsersDonation(userDonationStatus, userDonationId);
			UsersDonationDAO.updateStatus(ud);
			return "Bạn đã cập nhật trạng thái quyên góp thành công";
		} catch (Exception e) {
			return "Bạn đã cập nhật trạng thái quyên góp thất bại";
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
		status = request.getParameter("status");
		if (status == null || status == "") {
			status = "0";
		}
		if (status == null || status == "") {
			status = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", status);
		request.setAttribute("status", status);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			UsersDonationDAO.search(searchString, status);
			int noOfRecord = UsersDonationDAO.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<UsersDonation> listPerPage = UsersDonationDAO.getRecord(searchString, status, page, recordPerPage);
			request.setAttribute("UsersDonationList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/jsp/UsersDonationList.jsp");
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
		String status = request.getParameter("status");
		if (status == null || status == "") {
			status = "0";
		}
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		donationsDAO.search("", "0", status);
		int noOfRecord = donationsDAO.getNoOfRecords();
		int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
		List<Donations> listPerPage = donationsDAO.getRecord("", "0", status, page, recordPerPage);
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
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String bank = request.getParameter("bank");
			String transactionId = request.getParameter("transactionId");
			int donationId = Integer.parseInt(request.getParameter("donationId"));
			String donationAmount = request.getParameter("donationAmount").replaceAll(",", "");
			;
			Float donationAmountFloat = Utils.convertStringToFloat(donationAmount);

			// Create new user object
			UsersDonation u = new UsersDonation(name, email, phone, bank, transactionId, donationAmountFloat,
					donationId);
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
