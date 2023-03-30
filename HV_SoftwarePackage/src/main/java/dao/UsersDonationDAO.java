
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import model.Users;

public class UsersDonationDAO {

	private int noOfRecords;

	public List<Users> search(String character, String searchStatus) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Users> list = new ArrayList<>();
		try {
			String sql = "SELECT name, phone, email, address, registration_date, user_role "
						+ "FROM Users "
						+ "WHERE status = 1 " + (character.isEmpty() ? "" : "AND (name like ? OR phone = ?) ")
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
						+ "WHERE status = 1 " + (character.isEmpty() ? "" : "AND (name like ? OR phone = ?) ");
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
	
	public void insertUserDonation(Users u) throws Exception {
	    Connection connection = new DBContext().getConnection();
	    String sql = "INSERT INTO User_Donation (name, phone, email, bank, transaction_id, donation_amount, donation_date)" +
	                 "VALUES (?, ?, ?, ?, ?, ?, GETDATE());";

	    PreparedStatement stmt = connection.prepareStatement(sql);

	    stmt.setString(1, u.getName());
	    stmt.setString(2, u.getPhone());	
	    stmt.setString(3, u.getEmail());
	    stmt.setString(4, u.getBank());
	    stmt.setString(5, u.getTransactionId());
	    stmt.setFloat(6, u.getDonationAmount());
	    int run = stmt.executeUpdate();
	    stmt.close();
	    if (run == 0) throw new Exception();
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


	public void deleteUser(List<Users> us) throws Exception {
		Connection connection = new DBContext().getConnection();
		
		String sql ="UPDATE Users SET status = 0 WHERE email = ?";
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

}