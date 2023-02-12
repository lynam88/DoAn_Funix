
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
			String sql = "SELECT name, phone, email, address, registration_date, user_role " + "FROM Users "
					+ "WHERE (name like N'%' + ? + '%' OR phone = ?) " + "AND status = 1"
					+ (searchStatus.equals("0") ? "" : " AND user_role = ?");

			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, character);
			stmt.setString(2, character);
			if (!searchStatus.equals("0")) {
				stmt.setString(3, searchStatus);
			}
			ResultSet rs = stmt.executeQuery();
	
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

	public List<Users> getRecord(String character, String searchStatus, int pageNo, int recordPerPage)
			throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, address, registration_date, user_role, COUNT(*) OVER() AS total"
					+ " FROM Users" + " WHERE" + " status = 1" + " AND (name like N'%?%' OR phone = '?')";
			if (!searchStatus.equals("0")) {
				sql += " AND user_role = ?";
			}
			sql += " ORDER BY registration_date DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";

			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, "%" + character + "%");
			stmt.setString(2, character);
			if (!searchStatus.equals("0")) {
				stmt.setInt(3, Integer.parseInt(searchStatus));
			}
			stmt.setInt(4, pageNo);
			stmt.setInt(5, recordPerPage);
			stmt.setInt(6, recordPerPage);

			ResultSet rs = stmt.executeQuery();
			
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

		String sql = "SELECT * FROM Users WHERE (email = '?' OR phone = '?') AND password = '?' AND status = 1";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, password);

		ResultSet rs = stmt.executeQuery(sql);
		stmt.close();

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