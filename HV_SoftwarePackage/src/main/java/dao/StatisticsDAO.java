package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import model.Donations;
import model.Statistics;
import model.UsersDonation;

/**
 * Access donations in Database
 *
 */
public class StatisticsDAO {

	/**
	 * @param character    text in the input for searching name
	 * @param searchStatus status of the donation for searching
	 * @param category
	 * @return list of donations
	 * @throws Exception
	 */
	public Statistics getStatistic() throws Exception {
		Connection connection = new DBContext().getConnection();
		Statistics s = null;
		try {
			String sql = "SELECT (SELECT COUNT(*) FROM Donations) AS total_donations, "
					+ "(SELECT COUNT(*) FROM Users) AS total_users, "
					+ "(SELECT SUM(donation_amount) FROM Users_Donation WHERE donation_date = CONVERT(date, GETDATE())) AS total_donations_today, "
					+ "(SELECT SUM(donation_amount) FROM Users_Donation) AS total_user_donations";

			PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				s = new Statistics();
				s.setTotalDonations(rs.getInt("total_donations"));
				s.setTotalUsers(rs.getInt("total_users"));
				s.setTodayDonationAmount(rs.getFloat("total_donations_today"));
				s.setTotalDonationAmount(rs.getFloat("total_user_donations"));
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return s;
	}

	public List<Statistics> getMostRecentDonations() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Statistics> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 5 donation_status, donation_title, start_date, end_date, category, thumbnail"
					+ " FROM Donations" + " ORDER BY end_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Statistics s = new Statistics();
				s.setStatus(rs.getString("donation_status"));
				s.setTitle(rs.getString("donation_title"));
				s.setStartDate(rs.getDate("start_date"));
				s.setEndDate(rs.getDate("end_date"));
				s.setCategory(rs.getString("category"));
				s.setSrc(rs.getString("thumbnail"));

				list.add(s);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Statistics> getMostDonationUsers() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Statistics> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 5 name, email, donation_amount, user_donation_status, donation_date "
					+ "FROM Users_Donation " + "WHERE user_donation_status = 3" + "ORDER BY donation_amount DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Statistics s = new Statistics();

				s.setName(rs.getString("name"));
				s.setEmail(rs.getString("email"));
				s.setDonationAmount(rs.getFloat("donation_amount"));
				s.setUserDonationStatus(rs.getString("user_donation_status"));
				s.setDonationDate(rs.getDate("donation_date"));

				list.add(s);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Statistics> getCategory() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Statistics> list = new ArrayList<>();
		try {
			String sql = "SELECT category, COUNT(donation_title) AS posts FROM donations GROUP BY category";
			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Statistics s = new Statistics();

				s.setCategory(rs.getString("category"));
				s.setPosts(rs.getString("posts"));

				list.add(s);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Statistics> getMostRecentDonationUsers() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Statistics> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 3 UD.name, UD.email, donation_amount, donation_date, DATEDIFF(day, donation_date, GETDATE()) AS days_since_donation, category, avatar_path "
					+ "FROM Users_Donation AS UD " + "LEFT JOIN Donations AS D " + "ON UD.donation_id = D.donation_id "
					+ "LEFT JOIN Users AS U " + "ON UD.email = U.email " + "WHERE user_donation_status = 3 "
					+ "ORDER BY donation_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Statistics s = new Statistics();

				s.setName(rs.getString("name"));
				s.setEmail(rs.getString("email"));
				s.setDonationAmount(rs.getFloat("donation_amount"));
				s.setDayDiff(rs.getInt("days_since_donation"));
				s.setCategory(rs.getString("category"));
				s.setAvatarPath(rs.getString("avatar_path"));

				list.add(s);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public List<Statistics> getDonationList() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Statistics> list = new ArrayList<>();
		try {
			String sql = "SELECT D.donation_id, donation_status, donation_title, insertDate, total_needed, category, thumbnail, DATEDIFF(day, donation_date, GETDATE()) AS days_since_donation, SUM(donation_amount) AS donation_amount "
					+ "FROM Donations D " + "LEFT JOIN Users_Donation UD ON D.donation_id = UD.donation_id "
					+ "GROUP BY D.donation_id, donation_status, donation_title, insertDate, end_date, total_needed, category, thumbnail, DATEDIFF(day, donation_date, GETDATE()) "
					+ "ORDER BY end_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Statistics s = new Statistics();

				s.setDonationId(rs.getInt("donation_id"));
				s.setStatus(rs.getString("donation_status"));
				s.setTitle(rs.getString("donation_title"));
				s.setInsertDate(rs.getDate("insertDate"));
				s.setTotalNeeded(rs.getFloat("total_needed"));
				s.setCategory(rs.getString("category"));
				s.setSrc(rs.getString("thumbnail"));
				s.setDayDiff(rs.getInt("days_since_donation"));
				s.setDonationAmount(rs.getFloat("donation_amount"));

				list.add(s);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}
}