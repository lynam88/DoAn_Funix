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

}
