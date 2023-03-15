package controller.user;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
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
import dao.DonationsDAO;
import dao.UsersDAO;
import model.Donations;
import model.Users;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.PrintWriter;

import org.apache.commons.io.IOUtils;

/**
 * Servlet implementation class UsersController
 */
@WebServlet(name = "UsersController", urlPatterns = { "/UsersController" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB

public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO usersDAO;
	private DonationsDAO donationsDAO;
	private String action;
	private HttpSession session;
	Users userData;

	public void init() {
		usersDAO = new UsersDAO();
		donationsDAO = new DonationsDAO();
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UsersController() {
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
		action = action == null ? "dashboard" : action;
		try {
			List<Donations> listDonations = donationsDAO.search("", "0", "0");
			request.setAttribute("DonationList", listDonations);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		session = request.getSession();
		Users u = (Users) session.getAttribute("user");
		switch (action) {
		case "login":
			doLogin(request, response);
			break;
		case "resetPassword":
			try {
				resetPassword(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "recoverUser":
			try {
				recoverUser(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "contact":
			showContact(request, response);
			break;
		case "donationGuide":
			showDonationGuide(request, response);
			break;
		case "donations":
			try {
				showDonations(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case "donationPost":
			showDonationPost(request, response);
			break;
		case "rules":
			showRules(request, response);
			break;	
		case "signupForm":
			showSignupForm(request, response);
			break;
		case "signup":
			doSignup(request, response);
			break;
		case "dashboard":
			if (u != null && u.getRole() == 1) {
				showAdminPage(request, response);
			} else {
				try {
					showUserPage(request, response);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			break;
		case "userInfo":
			showUserInfo(request, response);
			break;
		case "updateUserInfo":
			updateUserInfo(request, response);
			break;	
		case "logout":
			doLogout(request, response);
			break;
		}
	}

	private void updateUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {

			// Get form input data
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String originEmail = request.getParameter("originEmail");
			String address = request.getParameter("address");			
			
			Part filePart = request.getPart("avatar");
			long fileSize = filePart.getSize();
			String avatarPath = null;
			if(fileSize > 0) {
			String pathServer = request.getServletContext().getRealPath("");
			String folderAvatar = "user/media/avatar/";
			File uploadDir = new File(pathServer+folderAvatar); 
			if (!uploadDir.exists()) uploadDir.mkdir();
			avatarPath = folderAvatar + phone + ".jpg";			
			filePart.write(pathServer+"/"+avatarPath);
			System.out.println(pathServer+avatarPath);
			}

			// Create new user object
			Users u = new Users(name, phone, email, avatarPath, address);
			request.setAttribute("user", u);
			if (usersDAO.getUser(email) != null && !usersDAO.getUser(email).equals(originEmail)) {
				request.setAttribute("email_error", "Email này đã được đăng ký");

			} else {
				// Insert user data to database
				usersDAO.updateUser(u, originEmail);
				request.setAttribute("notifySignup", "Cập nhật thành công.");
				request.setAttribute("statusSignup", "OK");		
			}

		} catch (Exception ex) {
			request.setAttribute("notifySignup", "Cập nhật thất bại.");
			request.setAttribute("statusSignup", "FAIL");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("user/jsp/userInfo.jsp");
		dispatcher.forward(request, response);
		
	}

	private void showUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("user/jsp/userInfo.jsp").forward(request, response);			
	}

	private void showSignupForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("user/jsp/signup.jsp").forward(request, response);		
	}

	private void showRules(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("user/jsp/rules.jsp").forward(request, response);
	}

	private void showDonationGuide(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("user/jsp/donationGuide.jsp").forward(request, response);
	}

	private void showContact(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("user/jsp/contact.jsp").forward(request, response);
	}

	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
	}

	private void showUserPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, Exception {
		int noOfRecord = donationsDAO.getNoOfRecords();
		request.setAttribute("noOfRecord", noOfRecord);
		request.getRequestDispatcher("user/jsp/index.jsp").forward(request, response);
	}

	private void showAdminPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("admin/jsp/index.jsp").forward(request, response);
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

	private void recoverUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Sender's email and password
		final String fromEmail = "quytuthienlienhoa@gmail.com";
		final String password = "csfawleqxoaqlhur";

		// Recipient's email address
		final String toEmail = request.getParameter("email");
		final String feedback = request.getParameter("feedback");
		request.setAttribute("toEmail", toEmail);
		request.setAttribute("feedback", feedback);
		String feedbackString = null;
		if (feedback != null) {
			byte[] feedback_Bytes = feedback.getBytes(StandardCharsets.ISO_8859_1);
			feedbackString = new String(feedback_Bytes, StandardCharsets.UTF_8);
		}
		// Get user from database
		if (toEmail != null) {
			Users u = usersDAO.getUser(toEmail);
			if (u == null || u.getStatus() == 1) {
				request.setAttribute("notifyValid",
						"Tài khoản chưa bị khoá hoặc chưa đăng ký. Xin kiểm tra lại email.");
				request.getRequestDispatcher("user/jsp/recoverUser.jsp").forward(request, response);
				return;
			}

			// Update feedback to database
			usersDAO.updateFeedback(u, feedbackString);

			// Email subject and body
			final String subject = "Liên Hoa tiếp nhận phản hồi của bạn";
			final String body = "Chào bạn, <br/>"
					+ "Chúng tôi cảm ơn bạn đã gửi yêu cầu phục hồi tài khoản của mình tại trang web Quỹ Từ Thiện Liên Hoa."
					+ "Chúng tôi đã nhận được thông tin tài khoản email, và đang tiến hành xác minh thông tin cũng như xem xét việc phục hồi tài khoản cho bạn. <br/>"
					+ "Chúng tôi sẽ thông báo cho bạn ngay khi tài khoản của bạn đã được khôi phục thành công. Nếu có bất kỳ câu hỏi hoặc yêu cầu nào khác, vui lòng liên hệ với chúng tôi qua email này hoặc qua trang web của chúng tôi. <br/>"
					+ "Chúng tôi rất tiếc vì sự bất tiện này và sẽ cố gắng giải quyết vấn đề của bạn trong thời gian sớm nhất. <br/>"
					+ "Trân trọng, <br/>" + "Ban quản trị của Quỹ Từ Thiện Liên Hoa.";

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

			// Set attributes and forward the request to a new JSP
			request.setAttribute("notifyRecover",
					"Chúng tôi vừa nhận được yêu cầu khôi phục tài khoản từ bạn. Chúng tôi sẽ xem xét và phản hồi email trong thời gain sớm nhất. Cám ơn bạn!");
			request.setAttribute("statusRecover", "Ok");
		}
		request.getRequestDispatcher("user/jsp/recoverUser.jsp").forward(request, response);
	}

	// Extract file name from content-disposition header of file part
	private String getFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}

	private void doSignup(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {

			// Get form input data
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String address = request.getParameter("address");
			String password = request.getParameter("signupPass");
			String passDB = null;
			if (password != null) {
				passDB = MD5Library.md5(password);
			}
			
			Part filePart = request.getPart("avatar");
			long fileSize = filePart.getSize();
			String avatarPath = null;
			if(fileSize > 0) {
			String pathServer = request.getServletContext().getRealPath("");
			String folderAvatar = "user/media/avatar/";
			File uploadDir = new File(pathServer+folderAvatar); 
			if (!uploadDir.exists()) uploadDir.mkdir();
			avatarPath = folderAvatar + phone + ".jpg";			
			filePart.write(pathServer+"/"+avatarPath);
			System.out.println(pathServer+avatarPath);
			}

			// Create new user object
			Users u = new Users(name, phone, email, avatarPath, address, passDB);
			request.setAttribute("inputUser", u);
			request.setAttribute("signupPass", password);
			if (phone != null && usersDAO.getUser(phone) != null) {
				request.setAttribute("phone_error", "Số điện thoại này đã được đăng ký");

			} else if (usersDAO.getUser(email) != null) {
				request.setAttribute("email_error", "Email này đã được đăng ký");

			} else {
				// Insert user data to database
				usersDAO.insertUser(u);
				request.setAttribute("notifySignup", "Đăng ký thành công.");
				request.setAttribute("statusSignup", "OK");		
			}

		} catch (Exception ex) {
			request.setAttribute("notifySignup", "Đăng ký thất bại.");
			request.setAttribute("statusSignup", "FAIL");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("user/jsp/signup.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * Sends an email with a new password to a user's email address using JavaMail.
	 * 
	 * @param request  the HTTP request object containing the user's email address
	 * @param response the HTTP response object
	 * @throws Exception if an error occurs while sending the email
	 */
	private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Sender's email and password
		final String fromEmail = "quytuthienlienhoa@gmail.com";
		final String password = "csfawleqxoaqlhur";

		// Recipient's email address
		final String toEmail = request.getParameter("email");
		request.setAttribute("toEmail", toEmail);

		// Get user from database
		if (toEmail != null) {
			Users u = usersDAO.getUser(toEmail);
			if (u == null || u.getStatus() == 0) {
				// User is deleted or not registered yet
				request.setAttribute("notifyValid",
						"Tài khoản đã bị khoá hoặc chưa đăng ký. Xin liên hệ Admin để mở khoá tài khoản");
				request.getRequestDispatcher("user/jsp/resetPassword.jsp").forward(request, response);
				return;
			}

			// Generate a new password and update it in the database
			final String newPass = RandomPasswordGenerator.regeneratePassword();
			final String newpassDB = MD5Library.md5(newPass);
			usersDAO.updatePass(u, newpassDB);

			// Email subject and body
			final String subject = "Liên Hoa gửi bạn mật khẩu mới";
			final String body = "Chào bạn, <br/>"
					+ "Chúng tôi nhận được yêu cầu cấp lại mật khẩu cho tài khoản của bạn trên trang web Quỹ Từ Thiện Liên Hoa. Sau đây là mật khẩu mới của bạn: <br/>"
					+ "<span style=\"color: blue; font-weight: bold\">" + newPass + "</span><br/>"
					+ "Vui lòng đăng nhập vào tài khoản của bạn và thay đổi mật khẩu ngay lập tức để đảm bảo an toàn cho tài khoản của bạn. Đồng thời, nếu bạn phát hiện bất kỳ hoạt động đáng ngờ nào trên tài khoản của mình, vui lòng liên hệ với chúng tôi ngay lập tức để chúng tôi có thể hỗ trợ và giúp bạn khắc phục vấn đề. <br/>"
					+ "Chúng tôi luôn sẵn sàng hỗ trợ bạn nếu bạn cần giải đáp bất kỳ thắc mắc nào. Cảm ơn bạn đã đồng hành cùng chúng tôi trên con đường thiện nghiệp! <br/>"
					+ "Trân trọng, <br/>" + "Ban quản trị của Quỹ Từ Thiện Liên Hoa.";

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

			// Set attributes and forward the request to a new JSP
			request.setAttribute("notifyPassSent",
					"Chúng tôi vừa gửi mật khẩu tới email của bạn. Vui lòng kiểm tra hộp thư của mình. Cám ơn bạn!");
			request.setAttribute("statusPassSent", "Ok");
		}
		request.getRequestDispatcher("user/jsp/resetPassword.jsp").forward(request, response);
	}

	/**
	 * Performs the login process by collecting user input from the login form,
	 * checking the user's account information in the database, and creating a new
	 * session for the user. If the user has selected "remember me", creates cookies
	 * for their login information. The user is then forwarded to the login page
	 * with appropriate notifications based on the outcome of the login process.
	 * 
	 * @param request  the HTTP servlet request containing the user's input from the
	 *                 login form
	 * @param response the HTTP servlet response that will be sent to the client
	 * @throws ServletException if there is an error with the servlet
	 * @throws IOException      if there is an error with the input or output
	 */
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Set response content type and request character encoding
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8"); // For Vietnamese language

		// Invalidate any existing session before creating a new one

		// Collect user input from the login form
		String id = request.getParameter("loginId");
		String loginPass = request.getParameter("loginPass");
		String passDB = null;
		if (loginPass != null) {
			passDB = MD5Library.md5(loginPass);
		}
		// Create a new session for the user
		session = request.getSession(true);

		// If the user has selected "remember me", create cookies for their login
		// information
		if (request.getParameter("remember") != null) {
			Cookie cookiesName = new Cookie("loginId", id);
			cookiesName.setMaxAge(300);
			response.addCookie(cookiesName);
			Cookie cookiesPass = new Cookie("loginPass", loginPass);
			cookiesPass.setMaxAge(300);
			response.addCookie(cookiesPass);
		}

		// Check the user's account information in the database
		if (id != null && loginPass != null) {
			try {
				userData = usersDAO.getUser(id);

				if (userData == null || !userData.getPassword().equals(passDB)) {
					request.setAttribute("notifyLogin",
							"Thông tin đăng nhập chưa đúng hoặc tài khoản chưa được đăng ký.");

					// Forward the request and response to the login page
					request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
					return;
				}

				if (userData.getStatus() == 1 && userData.getPassword().equals(passDB) && userData.getRole() == 1) {
					session.setAttribute("user", userData);

					// Forward the request and response to the admin page
					request.getRequestDispatcher("UsersController?action=dashboard").forward(request, response);
					return;
				}

				if (userData.getStatus() == 1 && userData.getPassword().equals(passDB) && userData.getRole() == 2) {
					session.setAttribute("user", userData);

					// Forward the request and response to the user page
					request.getRequestDispatcher("UsersController?action=dashboard").forward(request, response);
					return;
				}

				if (userData.getStatus() == 0) {
					request.setAttribute("notifyLogin", "Tài khoản đã bị khoá, vui lòng liên hệ admin.");

					// Forward the request and response to the login page
					request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
					return;
				}

			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("notifyLogin", "Có lỗi xảy ra, xin vui lòng thử lại sau.");
			}
		}

		// Forward the request and response to the login page
		request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
	}
}
