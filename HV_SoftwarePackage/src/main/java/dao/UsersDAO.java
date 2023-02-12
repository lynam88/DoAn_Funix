
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

	public List<Users> searchName(String character, String searchStatus) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, address, registration_date, user_role "
					+ "FROM Users "
					+ "WHERE (name like N'%" + character + "%' OR phone = '" + character + "') "
							+ "AND status = 1" + (searchStatus.equals("0") ? "" : " AND user_role = " + searchStatus);

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
				u.setRole(rs.getInt("user_role"));

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

	public List<Users> getRecord(String character, String searchStatus, int pageNo, int recordPerPage) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {			
			String sql = "SELECT name, phone, email, address, registration_date, user_role, COUNT(*) OVER() AS total"
					+ " FROM Users"
					+ " WHERE"
					+ " status = 1"
					+ " AND (name like N'%" + character + "%' OR phone = '" + character + "')";
			if (!searchStatus.equals("0")) {
				sql+= " AND user_role = " + searchStatus;
			}
			sql+= " ORDER BY registration_date DESC OFFSET ("
					+ pageNo + "  - 1)*"
					+ recordPerPage + " ROWS FETCH NEXT "
					+ recordPerPage + " ROWS ONLY";		

			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Users u = new Users();
				u.setName(rs.getString("name"));
				u.setPhone(rs.getString("phone"));
				u.setEmail(rs.getString("email"));
				u.setAddress(rs.getString("address"));
				u.setRegistration_date(rs.getDate("registration_date"));
				u.setRole(rs.getInt("user_role"));

				list.add(u);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Users getUser(String id, String password) throws Exception {
		Connection connection = new DBContext().getConnection();
		Users u = new Users();

		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(
				"SELECT * FROM Users WHERE (email = '" + id + "' OR phone = '" + id + "') AND password = '" + password + "' AND status = 1");

		if (rs.next()) {
			u.setName(rs.getString("name"));
			u.setPhone(rs.getString("phone"));
			u.setEmail(rs.getString("email"));
			u.setPassword(rs.getString("password"));
			u.setAddress(rs.getString("address"));
			u.setRegistration_date(rs.getDate("registration_date"));

		}
		return u;
	}

	public void deleteUser(List<Users> us) throws Exception {
		Connection connection = new DBContext().getConnection();
		
		String sql = "BEGIN TRANSACTION\n";
		sql += "UPDATE Users SET status = 0 WHERE user_role = 2 AND email in (?)\n";		
		sql += "COMMIT TRANSACTION";
		PreparedStatement stmt = connection.prepareStatement(sql);

		for (Users u : us) {
			if (u.getRole() == 1) {
		        throw new Exception("Cannot delete ADMIN");
		    }
			stmt.setString(1, u.getEmail());
		}

		stmt.executeUpdate();
		stmt.close();
		
	}

}