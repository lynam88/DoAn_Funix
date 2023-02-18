package controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
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
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import commons.MD5Library;
import commons.RandomPasswordGenerator;
import dao.UsersDAO;
import model.Users;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import org.apache.commons.io.IOUtils;


/**
 * Servlet implementation class UsersController
 */
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO dao;
	private String action;
	private String searchString;
	private int page;
	private HttpSession session;

	public void init() {
		dao = new UsersDAO();
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
		action = action == null ? "admin" : action;
		session = request.getSession();
		if (action.equals("login")) {
			doLogin(request, response);
		} else if (action.equals("sendMail")) {
			try {
				sendMail(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			Users u = (Users) session.getAttribute("user");
			if (u != null && u.getRole() == 1) {
				try {
					switch (action) {
					case "admin":
						showMainPage(request, response);
						break;
					case "UserList":
					case "userSearch":
						listUser(request, response);
						break;
					case "delete":
						deleteUser(request, response);
						break;
					case "logout":
						doLogout(request, response);
						break;
					default:
						showMainPage(request, response);
						break;
					}
				} catch (Exception ex) {
					throw new ServletException(ex);
				}
			} else {
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}

	private void sendMail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		final String fromEmail = "quytuthienlienhoa@gmail.com";
		final String password = "csfawleqxoaqlhur";
		final String toEmail = request.getParameter("email");
		final String newPass = RandomPasswordGenerator.RandomPasswordGenerator();
		final String passDB = MD5Library.md5(newPass);
		final String subject = "Liên Hoa gửi bạn mật khẩu mới";
		final String body = "Chào bạn, chúng tôi vừa nhận được yêu cầu cấp lại mật khẩu mới từ bạn tại trang web của Quỹ Từ Thiện Liên Hoa <br/>" 
				+ "Đây là mật khẩu mới dành cho bạn:<br/>" + newPass + "<br/>"
				+ "Cảm ơn bạn đã đồng hành của chúng tôi trên con đường thiện nghiệp!";

		// Load the image file
		String fullPath = request.getServletContext().getRealPath("/media/logo.jpg");
		File file = new File(fullPath);
		InputStream inputStream = new FileInputStream(file);
		byte[] imageData = IOUtils.toByteArray(inputStream);

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

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};

		Session session = Session.getInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);		
		msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
		msg.addHeader("format", "flowed");
		msg.addHeader("Content-Transfer-Encoding", "8bit");
		msg.setFrom(new InternetAddress(fromEmail, "Quỹ Từ Thiện Liên Hoa"));
		msg.setReplyTo(InternetAddress.parse(fromEmail, false));
		msg.setSubject(subject, "UTF-8");
		msg.setContent(multipart, "text/html; charset=UTF-8");
		msg.setSentDate(new Date());
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
		Transport.send(msg);
		System.out.println("Gửi mail thành công");
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	private void listUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		page = 1;
		int recordPerPage = 5;
		String search = request.getParameter("myInput");
		if (search == null)
			search = "";
		byte[] search_Bytes = search.getBytes(StandardCharsets.ISO_8859_1);
		searchString = new String(search_Bytes, StandardCharsets.UTF_8);
		String searchStatus = request.getParameter("searchStatus");
		if (searchStatus == null || searchStatus == "") {
			searchStatus = "0";
		}
		request.setAttribute("searchText", searchString);
		request.setAttribute("searchStatus", searchStatus);
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		try {
			dao.searchName(searchString, searchStatus);
			int noOfRecord = dao.getNoOfRecords();
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			List<Users> listPerPage = dao.getRecord(searchString, searchStatus, page, recordPerPage);
			request.setAttribute("UserList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);

			RequestDispatcher rd = request.getRequestDispatcher("admin/UserList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public Users checkLogin(String id, String password, boolean isLogin) throws Exception {
		Users ud = dao.getUser(id, password, isLogin);
		return ud;
	}

	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8"); // Vietnamese
		request.getSession(true).invalidate();
		// collect data from a login form
		String id = request.getParameter("loginId");
		String password = request.getParameter("password");
		session = request.getSession(true);
		if (request.getParameter("remember") != null) {
			Cookie cookiesName = new Cookie("loginId", id);
			cookiesName.setMaxAge(300);
			response.addCookie(cookiesName);
			Cookie cookiesPass = new Cookie("password", password);
			cookiesPass.setMaxAge(300);
			response.addCookie(cookiesPass);
		}
		// check information of account in database
		try {
			Users userData = checkLogin(id, password, true);
			if (userData.getEmail() != null || userData.getPhone() != null) {
				request.setAttribute("notifyLogin", "Chúc mừng bạn đã đăng nhập thành công.");
				request.setAttribute("statusLogin", "Ok");
				session.setAttribute("user", userData);
			} else {
				request.setAttribute("notifyLogin", "Số điện thoại/ Email hoặc mật khẩu chưa đúng.");
				request.setAttribute("statusLogin", "Fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("notifyLogin", "Có lỗi xảy ra, xin vui lòng thử lại sau.");
			request.setAttribute("statusLogin", "Fail");
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] emails = request.getParameter("email").split(",");
		List<Users> list = new ArrayList<Users>();

		try {
			for (String email : emails) {
				Users u = dao.getUser(email, null, false);
				list.add(u);
			}
			dao.deleteUser(list);

		} catch (Exception e) {
			throw new Exception(e);
		}
	}

	private void showMainPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("admin/index.jsp").forward(request, response);
	}

}
