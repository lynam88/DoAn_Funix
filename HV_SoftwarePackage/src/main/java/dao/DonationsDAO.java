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

public class DonationsDAO {

	private int noOfRecords;

	public List<Donations> search(String character) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Donations WHERE donation_title like '%" + character + "%'");
			this.noOfRecords = 0;
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getInt("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));

				list.add(d);
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

	public List<Donations> getRecord(int start, int total) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(
					"SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id DESC) as rownb FROM donations) a"
							+ " WHERE rownb >= " + start + "AND rownb <= " + total);
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getInt("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));

				list.add(d);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Donations getDonation(int id) throws Exception {
		Connection connection = new DBContext().getConnection();
		Donations d = new Donations();
		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM donations WHERE donation_id = " + id);

			if (rs.next()) {
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getInt("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));

			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return d;
	}

	public void insertDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "INSERT INTO Donations (donation_status, donation_title, donation_content, start_date, end_date, total_needed) VALUES ( ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setInt(1, d.getStatus());
			stmt.setString(2, d.getTitle());
			stmt.setString(3, d.getContent());		
			stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
			stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
			stmt.setFloat(6, d.getTotalNeeded());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
	
	public void resetId() throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = " DBCC CHECKIDENT ('[Donations]', RESEED, 0)";;	
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public void deleteDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "DELETE FROM Donations WHERE donation_id = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setInt(1, d.getId());
			stmt.executeUpdate();
			stmt.close();
			resetId();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public void updateDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "UPDATE Donations SET donation_status = ?, donation_title = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setInt(1, d.getStatus());
			stmt.setString(2, d.getTitle());
			stmt.setString(3, d.getContent());		
			stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
			stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
			stmt.setFloat(6, d.getTotalNeeded());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
}
