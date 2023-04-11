/**

This is a servlet class that handles requests related to donations from the admin panel.
It implements methods to add, update, delete, and search donations, and also to export them to a file.
@author [author name]
*/
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

@WebServlet(name = "DonationsController", urlPatterns = { "/DonationsController" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class DonationsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DonationsDAO donationsDAO;
	private String action;
	private String search;
	private String status;
	private String category;
	private String searchString;
	private int page;
	HttpSession session;

	/**
	 * Initializes the servlet by creating an instance of the DonationsDAO class.
	 */
	public void init() {
		donationsDAO = new DonationsDAO();
	}

	/**
	 * Handles POST requests sent to the servlet. It determines the action to take
	 * based on the "action" parameter sent in the request, and calls the
	 * corresponding method to handle the action.
	 * 
	 * @param request  the HttpServletRequest object that contains the request the
	 *                 client has made of the servlet
	 * @param response the HttpServletResponse object that contains the response the
	 *                 servlet sends to the client
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "DonationSearch" : action;
		session = request.getSession();
		Users u = (Users) session.getAttribute("user");
		if (u != null && (u.getRole() == 0 || u.getRole() == 1)) {
			try {
				switch (action) {
				case "DonationSearch":
					listDonation(request, response);
					break;
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
			request.getRequestDispatcher("/UsersController?action=user").forward(request, response);
		}
	}

	/**
	 * Handles GET requests sent to the servlet. It determines the action to take
	 * based on the "action" parameter sent in the request, and calls the
	 * corresponding method to handle the action.
	 * 
	 * @param request  the HttpServletRequest object that contains the request the
	 *                 client has made of the servlet
	 * @param response the HttpServletResponse object that contains the response the
	 *                 servlet sends to the client
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action = request.getParameter("action");
		action = action == null ? "DonationList" : action;
		session = request.getSession();
		Users u = (Users) session.getAttribute("user");
		if (u != null && (u.getRole() == 0 || u.getRole() == 1)) {
			try {
				switch (action) {
				case "DonationList":
					listDonation(request, response);
					break;
				case "new":
					showNewForm(request, response);
					break;
				case "edit":
					showEditForm(request, response);
					break;
				case "export":
					exportDonation(request, response);
					break;
				}
			} catch (Exception ex) {
				throw new ServletException(ex);
			}
		} else {
			request.getRequestDispatcher("/UsersController?action=user").forward(request, response);
		}
	}

	/**
	 * 
	 * This method is responsible for listing the donations based on the search
	 * parameters and page number.
	 * 
	 * @param request  The HttpServletRequest object to get the search parameters
	 *                 and set the attributes for the JSP page.
	 * 
	 * @param response The HttpServletResponse object to forward the request and
	 *                 response to the JSP page.
	 * 
	 * @throws SQLException     If there is an error executing the SQL queries.
	 * 
	 * @throws IOException      If there is an error in the input or output of the
	 *                          data.
	 * 
	 * @throws ServletException If there is an error in the servlet operation.
	 */
	private void listDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		page = 1;
		int recordPerPage = 5;
		search = request.getParameter("myInput");
		if (search == null)
			search = "";
		// Converting the search string to UTF-8 format
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
			// Searching the database for the matching donations
			donationsDAO.search(searchString, status, category);
			int noOfRecord = donationsDAO.getNoOfRecords();
			// Calculating the number of pages based on the number of records
			int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordPerPage);
			// Getting the records for the current page
			List<Donations> listPerPage = donationsDAO.getRecord(searchString, status, category, page, recordPerPage);
			// Setting the attributes to be used in the JSP page
			request.setAttribute("DonationList", listPerPage);
			request.setAttribute("noOfPage", noOfPage);
			request.setAttribute("currentPage", page);
			RequestDispatcher rd = request.getRequestDispatcher("admin/jsp/DonationList.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			// Handling the exceptions and printing the stack trace
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * This method is responsible for showing the new form to add a new donation.
	 * 
	 * @param request  The HttpServletRequest object to set the attributes for the
	 *                 JSP page.
	 * @param response The HttpServletResponse object to forward the request and
	 *                 response to the JSP page.
	 * @throws Exception If there is an error in the servlet operation.
	 */
	private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("maxId", donationsDAO.getMaxId());
		// Forwarding the request and response to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/jsp/DonationForm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * 
	 * This method is responsible for showing the edit form for the selected
	 * donation.
	 * 
	 * @param request  The HttpServletRequest object to get the selected donation ID
	 *                 and page number and set the attributes for the JSP page.
	 * @param response The HttpServletResponse object to forward the request and
	 *                 response to the JSP page.
	 * @throws SQLException     If there is an error executing the SQL queries.
	 * @throws ServletException If there is an error in the servlet operation.
	 * @throws IOException      If there is an error in the input or output of the
	 *                          data.
	 */
	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// Getting the ID of the selected donation and retrieving the donation details
		// from the database
		int id = Integer.parseInt(request.getParameter("id"));
		Donations existingDonation = null;
		try {
			existingDonation = donationsDAO.getDonation(id);
		} catch (Exception e) {
			// Handling the exceptions and printing the stack trace
			e.printStackTrace();
		}
		// Forwarding the request and response to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/jsp/DonationForm.jsp");
		request.setAttribute("donations", existingDonation);
		page = Integer.parseInt(request.getParameter("page"));
		request.setAttribute("page", page);
		dispatcher.forward(request, response);
	}

	/**
	 * 
	 * Inserts a new donation into the database based on the information provided in
	 * the request parameters.
	 * 
	 * @param request  the HttpServletRequest containing the information to be used
	 *                 to create the new donation.
	 * 
	 * @param response the HttpServletResponse to be sent back to the client.
	 * 
	 * @throws SQLException     if an error occurs when interacting with the
	 *                          database.
	 * 
	 * @throws IOException      if an I/O error occurs while processing the request.
	 * 
	 * @throws ServletException if the servlet encounters difficulty while handling
	 *                          the request.
	 */
	private void insertDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		response.setContentType("text/htm;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {
			// Get the donation information from the request parameters
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
			// Convert start date and end date to Date objects
			if (!startDate.isEmpty() || !endDate.isEmpty()) {
				start = (Date) Utils.convertStringToDate(startDate);
				end = (Date) Utils.convertStringToDate(endDate);
			}

			// Convert total needed to float
			Float totalNeededFloat = Utils.convertStringToFloat(totalNeeded);

			String category = request.getParameter("category");

			// Get the thumbnail file from the request
			Part filePart = request.getPart("thumbnail");
			long fileSize = filePart.getSize();
			String thumbnailPath = null;
			if (fileSize > 0) {
				// Save the thumbnail to the server
				String pathServer = request.getServletContext().getRealPath("");
				String folderThumbnail = "admin/media/thumbnail/";
				File uploadDir = new File(pathServer + folderThumbnail);
				if (!uploadDir.exists())
					uploadDir.mkdir();
				thumbnailPath = folderThumbnail + id + ".jpg";
				filePart.write(pathServer + "/" + thumbnailPath);
			}

			// Create a new donation object with the collected information
			Donations d = new Donations(id, status, title, content, start, end, totalNeededFloat, category,
					thumbnailPath);
			// Insert the donation into the database
			donationsDAO.insertDonation(d);
			// Set attributes for successful notification
			request.setAttribute("notifyDonation", "Thêm thành công.");
			request.setAttribute("statusDonation", "OK");

		} catch (Exception ex) {
			// Set attributes for failed notification
			request.setAttribute("notifyDonation", "Thêm thất bại.");
			request.setAttribute("statusDonation", "FAIL");
		}
		// Forward the request to the DonationForm.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/jsp/DonationForm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * 
	 * Exports donation data to an Excel spreadsheet and sends it as a file
	 * attachment to the HTTP response.
	 * 
	 * @param request  the HTTP request object
	 * 
	 * @param response the HTTP response object
	 * 
	 * @throws SQLException     if there is an error accessing the database
	 * 
	 * @throws ServletException if there is an error with the servlet
	 * 
	 * @throws IOException      if there is an I/O error
	 */
	private void exportDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		ExportService exporter = new ExportService();

		// Construct the download file from the exported data
		File downloadFile = null;
		try {
			downloadFile = new File(exporter.donationExport(searchString, status, category));
			// Open the file input stream
			FileInputStream inStream = new FileInputStream(downloadFile);

			// Set the response content type to Excel
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			// Set the content length of the response
			response.setContentLength((int) downloadFile.length());

			// Set the response headers to force download of the file
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
			response.setHeader(headerKey, headerValue);

			// Open the output stream to the response
			OutputStream outStream = response.getOutputStream();

			// Write the file data to the output stream
			byte[] buffer = new byte[4096];
			int bytesRead = -1;
			while ((bytesRead = inStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			// Close the streams
			inStream.close();
			outStream.close();

		} catch (Exception e) {
			// Log the exception and re-throw it as a ServletException
			e.printStackTrace();
			throw new ServletException("Error exporting donation data", e);
		}
	}

	/**
	 * 
	 * Updates a donation based on the provided parameters in the request object.
	 * 
	 * @param request  the HttpServletRequest object containing the parameters of
	 *                 the donation to update
	 * 
	 * @param response the HttpServletResponse object used to redirect the user
	 *                 after the donation is updated
	 * 
	 * @throws SQLException     if there is an error accessing the database
	 * 
	 * @throws IOException      if there is an error writing to the response output
	 *                          stream
	 * 
	 * @throws ServletException if there is an error with the servlet
	 */
	private void updateDonation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {

		// Get parameters from request
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

		// Get thumbnail image if it exists and save it to server
		Part filePart = request.getPart("thumbnail");
		long fileSize = filePart.getSize();
		String thumbnailPath = null;
		if (fileSize > 0) {
			String pathServer = request.getServletContext().getRealPath("");
			String folderThumbnail = "admin/media/thumbnail/";
			File uploadDir = new File(pathServer + folderThumbnail);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			thumbnailPath = folderThumbnail + id + ".jpg";
			filePart.write(pathServer + "/" + thumbnailPath);
		}

		// Create Donation object with updated parameters
		Donations d = new Donations(id, status, title, content, start, end, totalNeededFloat, category, thumbnailPath);
		try {
			// Update donation in database
			donationsDAO.updateDonation(d);
			// Set success message attributes
			request.setAttribute("notifyDonation", "Cập nhật thành công.");
			request.setAttribute("statusDonation", "OK");

		} catch (Exception e) {
			// Set error message attributes
			request.setAttribute("notifyDonation", "Cập nhật thất bại.");
			request.setAttribute("statusDonation", "FAIL");
		}
		// Get current page and redirect user to DonationList page
		page = Integer.parseInt(request.getParameter("page"));
		response.sendRedirect("DonationsController?action=DonationList&page=" + page);
	}

	/**
	 * 
	 * Deletes a list of donations based on their IDs.
	 * 
	 * @param request  the HttpServletRequest object containing the ID parameter
	 * 
	 * @param response the HttpServletResponse object for sending a redirect
	 *                 response
	 * 
	 * @throws SQLException if there is an error with the database connection
	 * 
	 * @throws IOException  if there is an error with the input or output
	 * 
	 * @throws Exception    if there is an error while deleting the donations
	 */
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
