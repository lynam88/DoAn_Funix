package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import commons.Utils;
import context.DBContext;

/**
 * Access donations in Database
 *
 */
public class StatisticsDAO {
	private int noOfRecords;

	public Map<String, String> getStatistic() throws Exception {
		Connection connection = new DBContext().getConnection();
		Map<String, String> map = new HashMap<String, String>();
		try {
			String sql = "SELECT (SELECT COUNT(*) FROM Donations) AS total_donations, "
					+ "(SELECT COUNT(*) FROM Users) AS total_users, "
					+ "(SELECT SUM(donation_amount) FROM Users_Donation WHERE donation_date = CONVERT(date, GETDATE())) AS total_donations_today, "
					+ "(SELECT SUM(donation_amount) FROM Users_Donation) AS total_donation_amount";

			PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				map.put("totalDonations", String.valueOf(rs.getInt("total_donations")));
				map.put("totalUsers", String.valueOf(rs.getInt("total_users")));
				map.put("todayDonationAmount", String.valueOf(rs.getFloat("total_donations_today")));
				map.put("totalDonationAmount", String.valueOf(rs.getFloat("total_donation_amount")));
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return map;
	}

	public List<Map<String, String>> getMostRecentDonations() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Map<String, String>> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 5 donation_title, start_date, end_date, thumbnail " + "FROM Donations "
					+ "ORDER BY end_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("title", rs.getString("donation_title"));
				// Format the date to dd/mm/yy
				String startDate = Utils.formatDate(rs.getDate("start_date"));
				map.put("startDate", startDate);
				String endDate = Utils.formatDate(rs.getDate("start_date"));
				map.put("startDate", endDate);
				map.put("thumbnail", rs.getString("thumbnail"));

				list.add(map);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Map<String, String>> getMostDonationUsers() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Map<String, String>> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 5 name, email, donation_amount, user_donation_status, donation_date "
					+ "FROM Users_Donation " + "WHERE user_donation_status = 3" + "ORDER BY donation_amount DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("name", rs.getString("name"));
				map.put("email", rs.getString("email"));
				map.put("donationAmount", String.valueOf(rs.getFloat("donation_amount")));
				map.put("userDonationStatus", rs.getString("user_donation_status"));

				// Format the date to dd/mm/yy
				String donationDate = Utils.formatDate(rs.getDate("donation_date"));
				map.put("donationDate", donationDate);

				list.add(map);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Map<String, String>> getCategory() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Map<String, String>> list = new ArrayList<>();
		try {
			String sql = "SELECT category, COUNT(donation_title) AS posts FROM donations GROUP BY category";
			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("category", rs.getString("category"));
				map.put("posts", rs.getString("posts"));

				list.add(map);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Map<String, String>> getMostRecentDonationUsers() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Map<String, String>> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 3 UD.name, UD.email, donation_amount, DATEDIFF(day, donation_date, GETDATE()) AS days_since_donation, category, avatar_path "
					+ "FROM Users_Donation AS UD " + "LEFT JOIN Donations AS D " + "ON UD.donation_id = D.donation_id "
					+ "LEFT JOIN Users AS U " + "ON UD.email = U.email " + "WHERE user_donation_status = 3 "
					+ "ORDER BY donation_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, String> map = new HashMap<String, String>();

				map.put("name", rs.getString("name"));
				map.put("email", rs.getString("email"));
				map.put("donationAmount", String.valueOf(rs.getFloat("donation_amount")));
				map.put("dayDiff", String.valueOf(rs.getInt("days_since_donation")));		
				map.put("category", rs.getString("category"));
				map.put("avatarPath", rs.getString("avatar_path"));

				list.add(map);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Map<String, String>> getDonationStats() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Map<String, String>> list = new ArrayList<>();
		try {
			String sql = "SELECT D.donation_id, donation_status, donation_title, insertDate, total_needed, category, thumbnail, DATEDIFF(day, donation_date, GETDATE()) AS days_since_donation, SUM(donation_amount) AS donation_amount "
					+ "FROM Donations D " + "LEFT JOIN Users_Donation UD ON D.donation_id = UD.donation_id "
					+ "GROUP BY D.donation_id, donation_status, donation_title, insertDate, end_date, total_needed, category, thumbnail, DATEDIFF(day, donation_date, GETDATE()) "
					+ "ORDER BY end_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, String> map = new HashMap<String, String>();

				map.put("donationId", String.valueOf(rs.getInt("donation_id")));
				map.put("status", rs.getString("donation_status"));
				map.put("title", rs.getString("donation_title"));
				// Format the date to dd/mm/yy
				String insertDate = Utils.formatDate(rs.getDate("insertDate"));
				map.put("insertDate", insertDate);
				map.put("totalNeeded", String.valueOf(rs.getFloat("total_needed")));
				map.put("src", rs.getString("thumbnail"));
				map.put("dayDiff", String.valueOf(rs.getInt("days_since_donation")));
				map.put("donationAmount", String.valueOf(rs.getFloat("donation_amount")));

				list.add(map);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public int getNoOfRecords() {
		return noOfRecords;
	}

}