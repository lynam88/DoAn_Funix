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
			ResultSet rs = stmt.executeQuery("SELECT * FROM Donations WHERE donation_name like '%" + character + "%'");
			this.noOfRecords = 0;
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setName(rs.getString("donation_name"));
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
					"SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id) as rownb FROM donations) a"
							+ " WHERE rownb >= " + start + "AND rownb <= " + total);
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setName(rs.getString("donation_name"));
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
				d.setName(rs.getString("donation_name"));
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
			String sql = "INSERT INTO Donations (donation_name, donation_content, start_date, end_date, total_needed) VALUES ( ?, ?, ?, ?, ?)";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setString(1, d.getName());
			stmt.setString(2, d.getContent());
			stmt.setDate(3, d.getStartDate());
			stmt.setDate(4, d.getEndDate());
			stmt.setFloat(5, d.getTotalNeeded());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public void deleteDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "DELETE FROM Donations WHERE dontation_id = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setInt(1, d.getId());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public void updateDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "UPDATE Donations SET donation_name = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setString(1, d.getName());
			stmt.setString(2, d.getContent());
			stmt.setDate(3, d.getStartDate());
			stmt.setDate(4, d.getEndDate());
			stmt.setFloat(5, d.getTotalNeeded());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
}
