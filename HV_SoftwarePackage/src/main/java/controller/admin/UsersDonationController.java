package controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;

import commons.Utils;
import dao.DonationsDAO;
import dao.ExportService;
import dao.StatisticsDAO;
import dao.UsersDAO;
import dao.UsersDonationDAO;
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
	private UsersDAO usersDAO;
	private UsersDonationDAO UsersDonationDAO;
	private StatisticsDAO statisticsDAO;
	private String action;
	private String search;
	private String searchString;
	private String searchStatus;
	List<Map<String, String>> donationStats;
	private int page;
	HttpSession session;
	Object sessionUser;

	public void init() {
		usersDAO = new UsersDAO();
		new DonationsDAO();
		UsersDonationDAO = new UsersDonationDAO();
		statisticsDAO = new StatisticsDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "showMakeDonationPage" : action;		
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
		case "userDonationMail":
			try {
				userDonationMail(request, response);
			} catch (Exception e) {
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
			donationStats = statisticsDAO.getDonationStats("0", 0, 0);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		request.setAttribute("DonationStats", donationStats);
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
		case "export":
			exportUserDonation(request, response);
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
		searchStatus = request.getParameter("searchStatus");
		if (searchStatus == null || searchStatus == "") {
			searchStatus = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", searchStatus);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			UsersDonationDAO.search(searchString, searchStatus);
			int noOfRecord = UsersDonationDAO.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<UsersDonation> listPerPage = UsersDonationDAO.getRecord(searchString, searchStatus, page,
					recordPerPage);
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

	private void exportUserDonation(HttpServletRequest request, HttpServletResponse response) {
		ExportService exporter = new ExportService();
		// reads input file from an absolute path
		File downloadFile = null;
		try {
			downloadFile = new File(exporter.userDonationExport(searchString, searchStatus));
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

	private void userDonationMail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Sender's email and password
		final String fromEmail = "quytuthienlienhoa@gmail.com";
		final String password = "csfawleqxoaqlhur";

		// Recipient's email address
		final String toEmail = request.getParameter("toEmail");
		
		String userDonationStatus = request.getParameter("userDonationStatus");
		if (userDonationStatus.equals("R")) userDonationStatus = "Từ chối";
		if (userDonationStatus.equals("P")) userDonationStatus = "Đang chờ";
		if (userDonationStatus.equals("A")) userDonationStatus = "Đã xác thực";

		// Email subject and body
		final String subject = "Thông báo cập nhật trạng thái quyên góp thành công";
		final String body = "Chào bạn,<br/>"
							+ "Chúng tôi xin gửi thông báo đến bạn rằng quyên góp của bạn đã được cập nhật thành công với trạng thái là " 
							+ "<span style=\"color: red; font-weight: bold\">" + userDonationStatus + "</span><br/>"
							+ "Chúng tôi xin chân thành cảm ơn sự đóng góp của bạn và hy vọng rằng chúng ta sẽ tiếp tục đồng hành cùng nhau trên con đường thiện nguyện.<br/>"
							+ "Trân trọng,<br/>" + "Ban quản trị của Quỹ Từ Thiện Liên Hoa.";

		// Load the logo image file
		String fullPath = request.getServletContext().getRealPath("user/media/logo.jpg");
		File file = new File(fullPath);
		InputStream inputStream = new FileInputStream(file);
		IOUtils.toByteArray(inputStream);

		// Create the image attachment
		MimeBodyPart imagePart = new MimeBodyPart();
		imagePart.attachFile(file);
		imagePart.setContentID("<image>");
		imagePart.setDisposition(MimeBodyPart.INLINE);

		// Create the message body and attach the image
		MimeMultipart multipart = new MimeMultipart();
		BodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(body, "text/html; charset=UTF-8");
		multipart.addBodyPart(messageBodyPart);
		multipart.addBodyPart(imagePart);

		// Create a new Properties object
		Properties props = new Properties();

		// Set the SMTP host and port to use for sending the email
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		// Enable SMTP authentication and startTLS for secure communication
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		// Set the trust protocol for the SMTP server
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		// Set startTLS and SSL protocols
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

		// Create a new Authenticator for SMTP authentication
		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};

		// Create a new email session using the Properties and Authenticator objects
		Session session = Session.getInstance(props, auth);

		// Create a new MIME message
		MimeMessage msg = new MimeMessage(session);

		// Set the email headers and content
		msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
		msg.addHeader("format", "flowed");
		msg.addHeader("Content-Transfer-Encoding", "8bit");
		msg.setFrom(new InternetAddress(fromEmail, "Quỹ Từ Thiện Liên Hoa"));
		msg.setReplyTo(InternetAddress.parse(fromEmail, false));
		msg.setSubject(subject, "UTF-8");
		msg.setContent(multipart, "text/html; charset=UTF-8");
		msg.setSentDate(new Date());
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));

		// Send the email and print a success message
		Transport.send(msg);
		System.out.println("Gửi mail thành công");		
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
		request.setAttribute("category", category);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		donationStats = statisticsDAO.getDonationStats(category, 0, 0);
		int noOfRecord = statisticsDAO.getNoOfRecords();
		int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
		List<Map<String, String>> listPerPage = statisticsDAO.getDonationStats(category, page, recordPerPage);
		request.setAttribute("DonationList", listPerPage);
		request.setAttribute("noOfPage", noOfPage);
		request.setAttribute("currentPage", page);
		request.getRequestDispatcher("user/jsp/donations.jsp").forward(request, response);
	}

	private void showDonationPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("donationId"));
		Map<String, String> existingDonation = null;
		try {
			existingDonation = statisticsDAO.getDonation(id);
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
