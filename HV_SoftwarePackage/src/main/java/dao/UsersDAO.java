
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import model.Users;
import model.UsersDonation;

public class UsersDAO {

	private int noOfRecords;

	public List<Users> search(String character, String searchRole, String searchStatus) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, address, registration_date, user_role, status " + "FROM Users "
					+ (character.isEmpty() ? "" : "WHERE name LIKE ? OR phone = ? OR address LIKE ? ")
					+ (searchRole.equals("0") ? "" : (character.isEmpty() ? "WHERE " : "AND ") + "user_role = ? ")
					+ (searchRole.equals("1") ? "OR user_role = 0 " : "")
					+ (searchStatus.equals("0") ? "" : ((character.isEmpty() && searchRole.equals("0")) ? "WHERE " : "AND ") + "status = ? ");
					
			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;

			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
				stmt.setString(index++, "%" + character + "%");
			}

			if (!searchRole.equals("0")) {
				stmt.setString(index++, searchRole);
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
				u.setStatus(rs.getInt("status"));

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

	public List<Users> getRecord(String character, String searchRole, String searchStatus, int pageNo, int recordPerPage)
			throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, address, registration_date, user_role, status, COUNT(*) OVER() AS total "
					+ "FROM Users " + (character.isEmpty() ? "" : "WHERE name LIKE ? OR phone = ? OR address LIKE ? ")
					+ (searchRole.equals("0") ? "" : (character.isEmpty() ? "WHERE " : "AND ") + "user_role = ? ")
					+ (searchRole.equals("1") ? "OR user_role = 0 " : "")
					+ (searchStatus.equals("0") ? "" : ((character.isEmpty() && searchRole.equals("0")) ? "WHERE " : "AND ") + "status = ? ")
					+ "ORDER BY registration_date DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";			

			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;

			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
				stmt.setString(index++, "%" + character + "%");
			}

			if (!searchRole.equals("0")) {
				stmt.setString(index++, searchRole);
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
				u.setStatus(rs.getInt("status"));

				list.add(u);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Users getUser(String id) throws Exception {
		Connection connection = new DBContext().getConnection();
		Users u = null;
		String sql = "SELECT * FROM Users WHERE (email = ? OR phone = ?)";

		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, id);

		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			u = new Users();
			u.setName(rs.getString("name"));
			u.setPhone(rs.getString("phone"));
			u.setEmail(rs.getString("email"));
			u.setAvatarPath(rs.getString("avatar_path"));
			u.setPassword(rs.getString("password"));
			u.setAddress(rs.getString("address"));
			u.setRegistrationDate(rs.getDate("registration_date"));
			u.setRole(Integer.parseInt(rs.getString("user_role")));
			u.setStatus(Integer.parseInt(rs.getString("status")));
		}
		return u;
	}

	public void insertUser(Users u) throws Exception {
		Connection connection = new DBContext().getConnection();
		String sql = "MERGE INTO Users AS target " +
	                 "USING (VALUES (?, ?, ?, ?, ?, ?, GETDATE())) AS source (name, phone, email, avatar_path, address, password, registration_date) " +
	                 "ON target.email = source.email " +
	                 "AND target.phone = source.phone " +
	                 "WHEN NOT MATCHED BY TARGET THEN " +
	                 "INSERT (name, phone, email, avatar_path, address, password, registration_date) " +
	                 "VALUES (source.name, source.phone, source.email, source.avatar_path, source.address, source.password, GETDATE());";

		PreparedStatement stmt = connection.prepareStatement(sql);

		stmt.setString(1, u.getName());
		int index = 2;
		if (!u.getPhone().isEmpty()) {
			stmt.setString(index++, u.getPhone());
		}
		stmt.setString(index++, u.getEmail());
		stmt.setString(index++, u.getAvatarPath());
		stmt.setString(index++, u.getAddress());
		stmt.setString(index++, u.getPassword());
		int run = stmt.executeUpdate();
		stmt.close();
		if (run == 0)
			throw new Exception();
	}

	public void updateUser(Users u, String originEmail) throws Exception {
		Connection connection = new DBContext().getConnection();
		String sql = "UPDATE Users SET name = ?, phone = ?, email = ?, avatar_path = ?, address = ? WHERE email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		stmt.setString(1, u.getName());
		stmt.setString(2, u.getPhone());
		stmt.setString(3, u.getEmail());
		stmt.setString(4, u.getAvatarPath());
		stmt.setString(5, u.getAddress());
		stmt.setString(6, originEmail);
		stmt.executeUpdate();
		stmt.close();
	}

	public void updateRole(Users u) throws Exception {
		Connection connection = new DBContext().getConnection();

		String sql = "UPDATE Users SET user_role = ? WHERE email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		if (u.getRole() == 1)
			stmt.setInt(1, 2);
		else
			stmt.setInt(1, 1);
		stmt.setString(2, u.getEmail());
		stmt.executeUpdate();

		stmt.close();
	}

	public void deleteUser(List<Users> us) throws Exception {
		Connection connection = new DBContext().getConnection();

		String sql = "UPDATE Users SET status = 0 WHERE email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		for (Users u : us) {
			stmt.setString(1, u.getEmail());
			stmt.executeUpdate();
		}

		stmt.close();
	}

	public void updatePass(Users u, String password) throws Exception {
		Connection connection = new DBContext().getConnection();

		String sql = "UPDATE Users SET password = ? WHERE email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		stmt.setString(1, password);
		stmt.setString(2, u.getEmail());
		stmt.executeUpdate();
		stmt.close();

	}

	public void updateFeedback(Users u, String feedback) throws Exception {
		Connection connection = new DBContext().getConnection();

		String sql = "UPDATE Users SET feedback = ? WHERE email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		stmt.setString(1, feedback);
		stmt.setString(2, u.getEmail());
		stmt.executeUpdate();
		stmt.close();

	}

	public void updateStatus(Users u) throws Exception {
		Connection connection = new DBContext().getConnection();

		String sql = "UPDATE Users SET status = ? WHERE email = ?";
		PreparedStatement stmt = connection.prepareStatement(sql);

		if (u.getStatus() == 1)
			stmt.setInt(1, 2);
		else
			stmt.setInt(1, 1);
		stmt.setString(2, u.getEmail());
		stmt.executeUpdate();

		stmt.close();

	}
	
	public List<UsersDonation> getDonationHistory(String email)
			throws Exception {
		Connection connection = new DBContext().getConnection();
		List<UsersDonation> list = new ArrayList<>();
		try {
			String sql = "SELECT UD.donation_id, donation_amount, user_donation_status, donation_title, donation_date "
					+ "FROM Users_Donation AS UD "
					+ "LEFT JOIN Donations AS D "
					+ "ON UD.donation_id = D.donation_id "
					+ "WHERE email LIKE ?";		
			

			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, "%" + email + "%");			

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				UsersDonation u = new UsersDonation();				
			
				u.setDonationAmount(rs.getFloat("donation_amount"));
				u.setUserDonationStatus(rs.getString("user_donation_status"));
				u.setDonationTitle(rs.getString("donation_title"));
				u.setDonationDate(rs.getDate("donation_date"));	
				u.setDonationId(Integer.parseInt(rs.getString("donation_id")));				

				list.add(u);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

}