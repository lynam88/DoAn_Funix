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
		action = action == null ? "DonationSearch" : action;
		session = request.getSession();
		Users u = (Users) session.getAttribute("user");
		if (u != null && (u.getRole() == 0 || u.getRole() == 1)) {
			try {
				switch (action) {				
				case "delete":
					deleteDonation(request, response);
					break;	
				case "insert":
					insertDonation(request, response);
					break;				
				case "update":
					updateDonation(request, response);
					break;				
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("user/jsp/login.jsp").forward(request, response);
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

	private void insertDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		response.setContentType("text/htm;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {
			int id = Integer.parseInt(request.getParameter("maxId"));
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
			String category = request.getParameter("category");
			
			Part filePart = request.getPart("thumbnail");
			long fileSize = filePart.getSize();
			String thumbnailPath = null;
			if(fileSize > 0) {
			String pathServer = request.getServletContext().getRealPath("");
			String folderThumbnail = "admin/media/thumbnail/";
			File uploadDir = new File(pathServer + folderThumbnail); 
			if (!uploadDir.exists()) uploadDir.mkdir();
			thumbnailPath = folderThumbnail + id + ".jpg";		
			filePart.write(pathServer+"/"+ thumbnailPath);
			}						
			
			Donations d = new Donations(id, status, title, content, start, end, totalNeededFloat, category, thumbnailPath);
			donationsDAO.insertDonation(d);
			request.setAttribute("notifyDonation", "Thêm thành công.");
			request.setAttribute("statusDonation", "OK");			

		} catch (Exception ex) {
			request.setAttribute("notifyDonation", "Thêm thất bại.");
			request.setAttribute("statusDonation", "FAIL");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/jsp/DonationForm.jsp");
		dispatcher.forward(request, response);
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
		String category = request.getParameter("category");
		String content = request.getParameter("content");
		byte[] content_Bytes = content.getBytes(StandardCharsets.ISO_8859_1);
		content = new String(content_Bytes, StandardCharsets.UTF_8);		
	
		Part filePart = request.getPart("thumbnail");
		long fileSize = filePart.getSize();
		String thumbnailPath = null;
		if(fileSize > 0) {
		String pathServer = request.getServletContext().getRealPath("");
		String folderThumbnail = "admin/media/thumbnail/";
		File uploadDir = new File(pathServer + folderThumbnail); 
		if (!uploadDir.exists()) uploadDir.mkdir();
		thumbnailPath = folderThumbnail + id + ".jpg";		
		filePart.write(pathServer+"/"+ thumbnailPath);
		}						
		
		Donations d = new Donations(id, status, title, content, start, end, totalNeededFloat, category, thumbnailPath);
		try {
			donationsDAO.updateDonation(d);
			request.setAttribute("notifyDonation", "Cập nhật thành công.");
			request.setAttribute("statusDonation", "OK");

		} catch (Exception e) {
			request.setAttribute("notifyDonation", "Cập nhật thất bại.");
			request.setAttribute("statusDonation", "FAIL");
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
			donationsDAO.deleteDonation(list);
		} catch (Exception e) {
			throw new Exception(e);
		}
	}
}
