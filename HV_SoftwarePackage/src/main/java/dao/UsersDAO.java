
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
					+ "WHERE status = 1 " + (character.isEmpty() ? "" : "AND (name like ? ESCAPE '!' OR phone = ?) ")
					+ (searchStatus.equals("0") ? "" : "AND user_role = ?");

			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;

			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
			}

			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}

			ResultSet rs = stmt.executeQuery();
			this.noOfRecords = 0;

			while (rs.next()) {
				Users u = new Users();
				u.setName(rs.getString("name"));
				u.setPhone(rs.getString("phone"));
				u.setEmail(rs.getString("email"));
				u.setAddress(rs.getString("address"));
				u.setRegistrationDate(rs.getDate("registration_date"));
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
			String sql = "SELECT name, phone, email, address, registration_date, user_role, COUNT(*) OVER() AS total "
					+ "FROM Users " 
					+ "WHERE status = 1 " + (character.isEmpty() ? "" : "AND (name like ? ESCAPE '!' OR phone = ?) ");
			if (!searchStatus.equals("0")) {
				sql += " AND user_role = ?";
			}
			sql += " ORDER BY registration_date DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";

			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;

			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
			}
			
			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}
			stmt.setInt(index++, pageNo);
			stmt.setInt(index++, recordPerPage);
			stmt.setInt(index++, recordPerPage);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Users u = new Users();
				u.setName(rs.getString("name"));
				u.setPhone(rs.getString("phone"));
				u.setEmail(rs.getString("email"));
				u.setAddress(rs.getString("address"));
				u.setRegistrationDate(rs.getDate("registration_date"));
				u.setRole(rs.getInt("user_role"));

				list.add(u);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Users getUser(String id, String password, boolean isLogin) throws Exception {
		Connection connection = new DBContext().getConnection();
		Users u = null;
		String sql = "SELECT * FROM Users WHERE (email = ? OR phone = ?)";
		if (isLogin) {
			sql += " AND password = ? ";
		}

		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, id);
		
		if (isLogin) {
			stmt.setString(3, password);
		}		

		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			u = new Users();
			u.setName(rs.getString("name"));
			u.setPhone(rs.getString("phone"));
			u.setEmail(rs.getString("email"));
			u.setPassword(rs.getString("password"));
			u.setAddress(rs.getString("address"));
			u.setRegistrationDate(rs.getDate("registration_date"));
			u.setRole(Integer.parseInt(rs.getString("user_role")));
			u.setStatus(Integer.parseInt(rs.getString("status")));
		}
		return u;

	}

	public void deleteUser(List<Users> us) throws Exception {
		Connection connection = new DBContext().getConnection();
		for (Users u : us) {
			if (u.getRole() == 1) {
				throw new Exception("Cannot delete ADMIN");
			}	
		}
		
		String sql = "BEGIN TRANSACTION\n";
		sql += "UPDATE Users SET status = 0 WHERE user_role = 2 AND email in (?)\n";
		sql += "COMMIT TRANSACTION";
		PreparedStatement stmt = connection.prepareStatement(sql);

		for (Users u : us) {			
			stmt.setString(1, u.getEmail());
		}

		stmt.executeUpdate();
		stmt.close();

	}
	
	
	
	public void updatePass(Users u, String password) throws Exception {
		Connection connection = new DBContext().getConnection();
		
		String sql = "UPDATE Users SET password = ? WHERE status = 1 AND email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		stmt.setString(1, password);
		stmt.setString(2, u.getEmail());
		stmt.executeUpdate();
		stmt.close();

	
	}

}