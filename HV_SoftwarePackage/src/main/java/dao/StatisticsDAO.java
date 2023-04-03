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

	public List<Donations> getMostRecentDonations() throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 5 donation_status, donation_title, start_date, end_date, category, thumbnail"
					+ " FROM Donations"						
					+ " ORDER BY end_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Donations d = new Donations();
				d.setStatus(rs.getString("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setCategory(rs.getString("category"));
				d.setSrc(rs.getString("thumbnail"));
				
				list.add(d);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}
	
	public List<UsersDonation> getMostDonationUsers()
			throws Exception {
		Connection connection = new DBContext().getConnection();
		List<UsersDonation> list = new ArrayList<>();
		try {
			String sql = "SELECT TOP 5 name, email, donation_amount, user_donation_status, donation_date "
					+ "FROM Users_Donation "									
					+ "ORDER BY donation_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);		
			
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				UsersDonation u = new UsersDonation();				
			
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));				
				u.setDonationAmount(rs.getFloat("donation_amount"));
				u.setUserDonationStatus(rs.getString("user_donation_status"));
				u.setDonationDate(rs.getDate("donation_date"));			

				list.add(u);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}
}