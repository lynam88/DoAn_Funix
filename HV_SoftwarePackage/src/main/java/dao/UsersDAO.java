
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
import model.Users;

public class UsersDAO {

	private int noOfRecords;
	
	public boolean checkLogin(String character) throws Exception{
		
		return false;		
	}

	public List<Users> searchName(String character) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, address, registration_date FROM Users WHERE name like '%"
					+ character + "%' AND status = 1";

			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			this.noOfRecords = 0;
			while (rs.next()) {
				Users u = new Users();
				u.setName(rs.getString("name"));
				u.setPhone(rs.getString("phone"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("address"));
				u.setRegistration_date(rs.getDate("registration_date"));

				list.add(u);
				this.noOfRecords++;
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public int getNoOfRecords() {
		return noOfRecords;

	}

	public List<Users> getRecord(String character, String searchRole, int pageNo, int recordPerPage) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, registration_date" + " FROM Users" + " WHERE"
					+ " status = 1" + " AND name like N'%" + character + "%'";
			if (!searchRole.equals("0")) {
				sql += " AND donation_status = " + searchRole;
			}
			sql += " ORDER BY registration_date DESC OFFSET (" + pageNo + "  - 1)*" + recordPerPage
					+ " ROWS FETCH NEXT " + recordPerPage + " ROWS ONLY";

			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Users u = new Users();
				u.setName(rs.getString("name"));
				u.setPhone(rs.getString("phone"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("address"));
				u.setRegistration_date(rs.getDate("registration_date"));

				list.add(u);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Users getUser(String email) throws Exception {
		Connection connection = new DBContext().getConnection();
		Users u = new Users();
		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM Users WHERE email = " + email + "AND status = 1");

			if (rs.next()) {
				u.setName(rs.getString("name"));
				u.setPhone(rs.getString("phone"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("address"));
				u.setRegistration_date(rs.getDate("registration_date"));

			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return u;
	}

	/*
	 * public void insertDonation(Users a) throws Exception { Connection connection
	 * = new DBContext().getConnection(); String sql =
	 * "INSERT INTO Users (account_role, name, donation_content, start_date, end_date, total_needed, thumbnail) VALUES (?, ?, ?, ?, ?, ?, ?)"
	 * ; PreparedStatement stmt = connection.prepareStatement(sql);
	 * 
	 * stmt.setInt(1, a.getStatus()); stmt.setString(2, a.getTitle());
	 * stmt.setString(3, a.getContent()); stmt.setDate(4, new
	 * java.sql.Date(a.getStartDate().getTime())); stmt.setDate(5, new
	 * java.sql.Date(a.getEndDate().getTime())); stmt.setFloat(6,
	 * a.getTotalNeeded()); stmt.setString(7, a.getSrc()); stmt.executeUpdate();
	 * stmt.close(); }
	 * 
	 * public void deleteDonation(List<Users> ds) throws Exception { Connection
	 * connection = new DBContext().getConnection(); try { String sql =
	 * "BEGIN TRANSACTION\n"; sql +=
	 * "UPDATE Users SET use_yn = 0 WHERE donation_id in ("; String separator = "";
	 * for (Users a : ds) { sql += separator + a.getId(); separator = ", "; } sql +=
	 * ")\n"; sql += "COMMIT TRANSACTION"; PreparedStatement stmt =
	 * connection.prepareStatement(sql);
	 * 
	 * stmt.executeUpdate(); stmt.close();
	 * 
	 * } catch (SQLException ex) { ex.printStackTrace(); } }
	 * 
	 * public void updateDonation(Users a) throws Exception { Connection connection
	 * = new DBContext().getConnection(); try { String sql =
	 * "UPDATE Users SET account_role = ?, name = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?, thumbnail = ? WHERE donation_id = "
	 * + a.getId(); PreparedStatement stmt = connection.prepareStatement(sql);
	 * 
	 * stmt.setInt(1, a.getStatus()); stmt.setString(2, a.getTitle());
	 * stmt.setString(3, a.getContent()); stmt.setDate(4, new
	 * java.sql.Date(a.getStartDate().getTime())); stmt.setDate(5, new
	 * java.sql.Date(a.getEndDate().getTime())); stmt.setFloat(6,
	 * a.getTotalNeeded()); stmt.setString(7, a.getSrc()); stmt.executeUpdate();
	 * stmt.close();
	 * 
	 * } catch (SQLException ex) { ex.printStackTrace(); } }
	 */

}