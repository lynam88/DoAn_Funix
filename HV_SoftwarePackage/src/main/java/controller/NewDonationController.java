package controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import commons.Utils;
import dao.DonationsDAO;
import model.Donations;

/**
 * Servlet implementation class NewDonationController
 */

public class NewDonationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewDonationController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/htm;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try {
			HttpSession session = request.getSession(true);
			DonationsDAO dao = new DonationsDAO();
			String title = request.getParameter("title");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			Date start = null, end = null;
			String totalNeeded = request.getParameter("totalNeeded");
			String content = request.getParameter("content");
			if (title == null || title.equals("") || content == null || content.equals("") || totalNeeded == null || totalNeeded.equals("")) {
				session.setAttribute("error", "Xin điền vào đầy đủ các phần bắt buộc");
				response.sendRedirect("newpost.jsp");
				return;
			}
			if (startDate != "" || endDate != "") {
				start = (Date) Utils.convertStringToDate(startDate);
				end = (Date) Utils.convertStringToDate(endDate);
			}
			Float totalNeededFloat = Utils.convertStringToFloat(totalNeeded);
			if (startDate.compareTo(endDate) > 0) {
				session.setAttribute("error", "Ngày Bắt Đầu phải trước Ngày Kết Thúc");
				response.sendRedirect("newpost.jsp");
				return;
			} else {
				Donations d = new Donations(title, content, start, end, totalNeededFloat);
				dao.insertDonation(d);
				response.sendRedirect("DonationController");
				return;
			}
		} catch (Exception ex) {
			response.getWriter().println(ex);
			ex.printStackTrace();
		}
	}
}
