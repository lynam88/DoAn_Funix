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
import javax.mail.MessagingException;
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
import dao.ExportService;
import dao.UsersDAO;
import model.Users;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import org.apache.commons.io.IOUtils;


/**
 * Servlet implementation class UsersController
 */
@WebServlet(name = "UsersController", urlPatterns = { "/UsersController" })
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO dao;
	private String action;
	private String search;
	private String searchString;
	private String searchStatus;
	private int page;
	private HttpSession session;
	Users userData;

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
		} else if (action.equals("resetPassword")) {
			try {
				resetPassword(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("recoverUser")) {
			try {
				recoverUser(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("signup")) {
			doSignup(request, response);
		} else {
			Users u = (Users) session.getAttribute("user");
			if (u != null && u.getRole() == 1) {
				try {
					switch (action) {
					case "admin":
						showMainPage(request, response);
						break;
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
	
	private void recoverUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Sender's email and password
	    final String fromEmail = "quytuthienlienhoa@gmail.com";
	    final String password = "csfawleqxoaqlhur";

	    // Recipient's email address
	    final String toEmail = request.getParameter("email");
	    final String feedback = request.getParameter("feedback");
	    
	    //Get user from database
	    if(toEmail != null) {
		    Users u = dao.getUser(toEmail);
		    if(u.getStatus() == 1 || u == null) {
		    	session.setAttribute("email_recover_error", "Tài khoản chưa bị khoá hoặc chưa đăng ký. Xin kiểm tra lại email.");
			    request.getRequestDispatcher("recoverUser.jsp").forward(request, response);
			    return;
		    }
	
		    // Generate a new password and update it in the database
		    final String newPass = RandomPasswordGenerator.regeneratePassword();
		    final String newpassDB = MD5Library.md5(newPass);
		    dao.updatePass(u, newpassDB);
	
		    // Email subject and body
		    final String subject = "Liên Hoa gửi bạn mật khẩu mới";
		    final String body = "Chào bạn, <br/>" + 
		        "Chúng tôi xin chân thành cảm ơn bạn đã gửi yêu cầu phục hồi tài khoản của mình tại trang web Quỹ Từ Thiện Liên Hoa." +
		        "Chúng tôi xác nhận đã nhận được thông tin tài khoản email, và chúng tôi đang tiến hành xác minh thông tin và tiến hành phục hồi tài khoản của bạn. <br/>" +
		        "Chúng tôi sẽ thông báo cho bạn ngay khi tài khoản của bạn đã được khôi phục thành công. Nếu có bất kỳ câu hỏi hoặc yêu cầu nào khác, vui lòng liên hệ với chúng tôi qua email này hoặc qua trang web của chúng tôi. <br/>" +
		        "Chúng tôi rất tiếc vì sự bất tiện này và sẽ cố gắng giải quyết vấn đề của bạn trong thời gian sớm nhất. <br/>" +		        
		        "Trân trọng, <br/>" +
		        "Ban quản trị của Quỹ Từ Thiện Liên Hoa.";
	
		    // Load the logo image file
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
		    request.setAttribute("notifyPassSent", "Chúng tôi vừa gửi mật khẩu tới email của bạn. Xin bạn kiểm tra hộp thư của mình. Cám ơn bạn!");
		    request.setAttribute("statusPassSent", "Ok");		    
	    }
	    request.getRequestDispatcher("recoverUser.jsp").forward(request, response);		
	}

	private void doSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("text/html;charset=UTF-8");
	    request.setCharacterEncoding("utf-8");
	    try {
	    	// Invalidate any existing session before creating a new one
			request.getSession(true).invalidate();
	        // Get form input data
	        String name = request.getParameter("name");
	        String phone = request.getParameter("phone");
	        String email = request.getParameter("email");
	        String address = request.getParameter("address");
	        String password = request.getParameter("password");
	        String passDB = MD5Library.md5(password);
	        
	        // Create a new session for the user
			session = request.getSession(true);
	
	        // Upload avatar to server (if avatarPart exists)       	      
	        Part avatarPart = request.getPart("avatar");
	        String avatarName = avatarPart.getSubmittedFileName();
	        for (Part part : request.getParts()) {
	          part.write(request.getServletContext().getRealPath("/") + avatarName);
	        }
	        System.out.println(request.getServletContext().getRealPath("/") + avatarName);
	        	        
	        // Create new user object
	        Users u = new Users(name, phone, email, avatarName, address, passDB);
	        request.setAttribute("inputUser", u);
	        if(phone != null && dao.getUser(phone) != null) {
	            session.setAttribute("phone_error", "Số điện thoại này đã được đăng ký");
	        } else if(dao.getUser(email) != null) {
		        session.setAttribute("email_error", "Email này đã được đăng ký");
	        } else {
	            // Insert user data to database
	            dao.insertUser(u);
	            System.out.println("Đăng ký thành công.");
	            request.setAttribute("notifySignup", "Đăng ký thành công.");
	            request.setAttribute("statusSignup", "OK");
	        }
	
	    } catch (Exception ex) {
	        request.setAttribute("notifySignup", "Đăng ký thất bại.");
	        request.setAttribute("statusSignup", "FAIL");
	    }
	    RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
	    dispatcher.forward(request, response);
	}

	private void showMainPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("admin/index.jsp").forward(request, response);
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
	
	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/UserForm.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String email = request.getParameter("email");
		Users existingUser = null;
		try {
			existingUser = dao.getUser(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/UserForm.jsp");
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

	/**
	Sends an email with a new password to a user's email address using JavaMail.
	@param request the HTTP request object containing the user's email address
	@param response the HTTP response object
	@throws Exception if an error occurs while sending the email
	*/
	private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    // Sender's email and password
	    final String fromEmail = "quytuthienlienhoa@gmail.com";
	    final String password = "csfawleqxoaqlhur";

	    // Recipient's email address
	    final String toEmail = request.getParameter("email");
	    
	    //Get user from database
	    if(toEmail != null) {
		    Users u = dao.getUser(toEmail);
		    if(u == null ) {
		    	// User is deleted or not registered yet
		    	request.setAttribute("notifyValid", "Tài khoản đã bị khoá hoặc chưa đăng ký. Xin liên hệ Admin để mở khoá tài khoản");
			    request.setAttribute("statusPassSent", "Fail");
			    request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
			    return;
		    }
	
		    // Generate a new password and update it in the database
		    final String newPass = RandomPasswordGenerator.regeneratePassword();
		    final String newpassDB = MD5Library.md5(newPass);
		    dao.updatePass(u, newpassDB);
	
		    // Email subject and body
		    final String subject = "Liên Hoa gửi bạn mật khẩu mới";
		    final String body = "Chào bạn, <br/>" + 
		        "Chúng tôi nhận được yêu cầu cấp lại mật khẩu cho tài khoản của bạn trên trang web Quỹ Từ Thiện Liên Hoa. Sau đây là mật khẩu mới của bạn: <br/>" +
		        "<span style=\"color: blue; font-weight: bold\">" + newPass + "</span><br/>" +
		        "Vui lòng đăng nhập vào tài khoản của bạn và thay đổi mật khẩu ngay lập tức để đảm bảo an toàn cho tài khoản của bạn. Đồng thời, nếu bạn phát hiện bất kỳ hoạt động đáng ngờ nào trên tài khoản của mình, vui lòng liên hệ với chúng tôi ngay lập tức để chúng tôi có thể hỗ trợ và giúp bạn khắc phục vấn đề. <br/>" +
		        "Chúng tôi luôn sẵn sàng hỗ trợ bạn nếu bạn cần giải đáp bất kỳ thắc mắc nào. Cảm ơn bạn đã đồng hành cùng chúng tôi trên con đường thiện nghiệp! <br/>" +
		        "Trân trọng, <br/>" +
		        "Ban quản trị của Quỹ Từ Thiện Liên Hoa.";
	
		    // Load the logo image file
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
		    request.setAttribute("notifyPassSent", "Chúng tôi vừa gửi mật khẩu tới email của bạn. Xin bạn kiểm tra hộp thư của mình. Cám ơn bạn!");
		    request.setAttribute("statusPassSent", "Ok");		    
	    }
	    request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
	}

	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	
	/**
	Performs the login process by collecting user input from the login form, checking the user's account
	information in the database, and creating a new session for the user. If the user has selected "remember me",
	creates cookies for their login information. The user is then forwarded to the login page with appropriate
	notifications based on the outcome of the login process.
	@param request the HTTP servlet request containing the user's input from the login form
	@param response the HTTP servlet response that will be sent to the client
	@throws ServletException if there is an error with the servlet
	@throws IOException if there is an error with the input or output
	*/
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Set response content type and request character encoding
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8"); // For Vietnamese language
			
		// Invalidate any existing session before creating a new one
		request.getSession(true).invalidate();
			
		// Collect user input from the login form
		String id = request.getParameter("loginId");
		String password = request.getParameter("password");
		String passDB = null;
		if(password != null) {
			passDB = MD5Library.md5(password);
		}
		// Create a new session for the user
		session = request.getSession(true);
			
		// If the user has selected "remember me", create cookies for their login information
		if (request.getParameter("remember") != null) {
			Cookie cookiesName = new Cookie("loginId", id);
			cookiesName.setMaxAge(300);
			response.addCookie(cookiesName);
			Cookie cookiesPass = new Cookie("password", password);
			cookiesPass.setMaxAge(300);
			response.addCookie(cookiesPass);
		}
			
		// Check the user's account information in the database
		if(id != null && password != null) {
			try {
				userData = dao.getUser(id);
				
				if (userData == null) {
					request.setAttribute("notifyLogin", "Số điện thoại/Email chưa đúng hoặc Tài khoản chưa được đăng ký. Xin đăng ký để sử dụng");
					request.setAttribute("statusLogin", "Fail");
				} 
				else if (userData != null) {
					if (userData.getStatus() == 0) {
						request.setAttribute("notifyLogin", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ Admin để kích hoạt lại!");
						request.setAttribute("statusLogin", "Fail");
					}
					
					else if (userData.getStatus() == 1 && userData.getPassword().equals(passDB) && userData.getRole() == 1) {
						request.setAttribute("notifyLogin", "Chúc mừng Admin đã đăng nhập thành công.");
						request.setAttribute("statusLogin", "Admin");
						session.setAttribute("user", userData);			
					} 
					
					else if (userData.getStatus() == 1 && userData.getPassword().equals(passDB) && userData.getRole() == 2) {
						request.setAttribute("notifyLogin", "Chúc mừng bạn đã đăng nhập thành công.");
						request.setAttribute("statusLogin", "User");
						session.setAttribute("user", userData);			
					} 
					
					else {
						request.setAttribute("notifyLogin", "Mật khẩu của bạn chưa đúng.");
						request.setAttribute("statusLogin", "Fail");
					}
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("notifyLogin", "Có lỗi xảy ra, xin vui lòng thử lại sau.");
				request.setAttribute("statusLogin", "Fail");
			}
		}
		// Forward the request and response to the login page
		request.getRequestDispatcher("login.jsp").forward(request, response);
		
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception {
		String[] emails = request.getParameter("email").split(",");
		List<Users> list = new ArrayList<Users>();
		
		for (String email : emails) {
			Users u = dao.getUser(email);
			if(u != null && u.getRole() == 2) list.add(u);
		}
		
		if(list.size() == 0) {
			request.setAttribute("notifyDelete", "Bạn không được phép xoá ADMIN.");
			request.setAttribute("statusDelete", "Fail");
		} else {		
			try {
				dao.deleteUser(list);
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
