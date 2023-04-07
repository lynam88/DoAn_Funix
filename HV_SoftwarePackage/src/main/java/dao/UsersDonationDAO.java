
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

public class UsersDonationDAO {

	private int noOfRecords;

	public List<UsersDonation> search(String character, String searchStatus) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<UsersDonation> list = new ArrayList<>();
		try {
			String sql = "SELECT user_donation_id, name, email, phone, bank, transaction_id, donation_amount, user_donation_status, UD.donation_id, donation_title, donation_date "
						+ "FROM Users_Donation AS UD "
						+ "LEFT JOIN Donations AS D "
						+ "ON UD.donation_id = D.donation_id "
						+ (character.isEmpty() ? "" : "WHERE name LIKE ? OR phone = ? OR email LIKE ? OR bank LIKE ? OR donation_title LIKE ? ")
						+ (searchStatus.equals("0") ? "" : (character.isEmpty() ? "WHERE " : "AND ") + "user_donation_status = ? ");

			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;

			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
				stmt.setString(index++,  "%" + character + "%");
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, "%" + character + "%");
			}

			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}

			ResultSet rs = stmt.executeQuery();
			this.noOfRecords = 0;

			while (rs.next()) {
				UsersDonation u = new UsersDonation();
				
				u.setUserDonationId(rs.getInt("user_donation_id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("phone"));				
				u.setBank(rs.getString("bank"));
				u.setTransactionId(rs.getString("transaction_id"));
				u.setDonationAmount(rs.getFloat("donation_amount"));
				u.setUserDonationStatus(rs.getString("user_donation_status"));
				u.setDonationId(rs.getInt("donation_id"));
				u.setDonationTitle(rs.getString("donation_title"));;
				u.setDonationDate(rs.getDate("donation_date"));			

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

	public List<UsersDonation> getRecord(String character, String searchStatus, int pageNo, int recordPerPage)
			throws Exception {
		Connection connection = new DBContext().getConnection();
		List<UsersDonation> list = new ArrayList<>();
		try {
			String sql = "SELECT user_donation_id, name, email, phone, bank, transaction_id, donation_amount, user_donation_status, UD.donation_id, donation_title, donation_date "
					+ "FROM Users_Donation AS UD " 
					+ "LEFT JOIN Donations AS D "
					+ "ON UD.donation_id = D.donation_id "
					+ (character.isEmpty() ? "" : "WHERE name LIKE ? OR phone = ? OR email LIKE ? OR bank LIKE ? OR donation_title LIKE ? ")
					+ (searchStatus.equals("0") ? "" : (character.isEmpty() ? "WHERE " : "AND ") + "user_donation_status = ? ")
					+ "ORDER BY donation_date DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";

			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;

			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
				stmt.setString(index++,  "%" + character + "%");
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, "%" + character + "%");
			}

			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}
			
			stmt.setInt(index++, pageNo);
			stmt.setInt(index++, recordPerPage);
			stmt.setInt(index++, recordPerPage);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				UsersDonation u = new UsersDonation();
				
				u.setUserDonationId(rs.getInt("user_donation_id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("phone"));				
				u.setBank(rs.getString("bank"));
				u.setTransactionId(rs.getString("transaction_id"));
				u.setDonationAmount(rs.getFloat("donation_amount"));
				u.setUserDonationStatus(rs.getString("user_donation_status"));
				u.setDonationId(rs.getInt("donation_id"));
				u.setDonationTitle(rs.getString("donation_title"));;
				u.setDonationDate(rs.getDate("donation_date"));			

				list.add(u);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Users getDonation(String id) throws Exception {
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
	
	public void insertUsersDonation(UsersDonation u) throws Exception {
	    Connection connection = new DBContext().getConnection();
	    String sql = "INSERT INTO Users_Donation (name, email, phone, bank, transaction_id, donation_amount, donation_id, donation_date) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";

	    PreparedStatement stmt = connection.prepareStatement(sql);

	    stmt.setString(1, u.getName());
	    stmt.setString(2, u.getEmail());
	    stmt.setString(3, u.getPhone());		    
	    stmt.setString(4, u.getBank());
	    stmt.setString(5, u.getTransactionId());
	    stmt.setFloat(6, u.getDonationAmount());
	    stmt.setInt(7, u.getDonationId());
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
	
	public void updateStatus(UsersDonation ud) throws Exception {
    	Connection connection = new DBContext().getConnection(); 
        String sql = "UPDATE Users_Donation SET user_donation_status = ? WHERE user_donation_id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);

        if (ud.getUserDonationStatus().equals("R")) {
            stmt.setString(1, "1");
        } else if (ud.getUserDonationStatus().equals("P")) {
        	stmt.setString(1, "2");
        } else if (ud.getUserDonationStatus().equals("A")) {
        	stmt.setString(1, "3");
        }
        
        stmt.setInt(2, ud.getUserDonationId()); 
        stmt.executeUpdate();
        stmt.close();
	}

}