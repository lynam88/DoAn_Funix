package controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
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
import javax.servlet.http.Part;

import commons.MD5Library;
import commons.Utils;
import dao.DonationsDAO;
import dao.ExportService;
import model.Users;
import model.Donations;

/**
 * Servlet implementation class DonationsController
 */
@WebServlet(name = "UserDonationController", urlPatterns = { "/UserDonationController" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 50, // 50MB
maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UserDonationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DonationsDAO donationsDAO;
	private String action;
	private String search;
	private String status;
	private String category;
	private String searchString;
	private int page;
	HttpSession session;
	Users sessionUser;

	public void init() {
		donationsDAO = new DonationsDAO();
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
				makeDonation(request, response);
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
		case "showMakeDonationPage":
			try {
				showMakeDonationPage(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		}
	}

	private void showMakeDonationPage(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		String donationTitle =  request.getParameter("donationTitle");
		RequestDispatcher dispatcher = request.getRequestDispatcher("user/jsp/makeDonation.jsp");
		request.setAttribute("donationTitle", donationTitle);
		dispatcher.forward(request, response);
	}

	private void makeDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {

			// Get form input data
			String name = request.getParameter("name");
			byte[] name_Bytes = name.getBytes(StandardCharsets.ISO_8859_1);
			name = new String(name_Bytes, StandardCharsets.UTF_8);
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String donationAmount = request.getParameter("donationAmount");
			Float donationAmountFloat = Utils.convertStringToFloat(donationAmount);
		
			// Create new user object
			Users u = new Users(name, phone, email, donationAmount);
			request.setAttribute("inputUser", u);
			if (phone != null && usersDAO.getUser(phone) != null) {
				request.setAttribute("phone_error", "Số điện thoại này đã được đăng ký");

			} else if (usersDAO.getUser(email) != null) {
				request.setAttribute("email_error", "Email này đã được đăng ký");

			} else {
				// Insert user data to database
				usersDAO.insertUser(u);
				request.setAttribute("notifyDonation", "Đăng ký thành công.");
				request.setAttribute("statusDonation", "OK");		
			}

		} catch (Exception ex) {
			request.setAttribute("notifyDonation", "Đăng ký thất bại.");
			request.setAttribute("statusDonation", "FAIL");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("user/jsp/makeDonation.jsp");
		dispatcher.forward(request, response);
}
