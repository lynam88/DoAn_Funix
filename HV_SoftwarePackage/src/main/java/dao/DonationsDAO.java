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

/**
 * Access donations in Database
 *
 */
public class DonationsDAO {

	private int noOfRecords;

	/**
	 * @param character text in the input for searching name
	 * @param searchStatus status of the donation for searching
	 * @return list of donations
	 * @throws Exception
	 */
	public List<Donations> search(String character, String searchStatus) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			String sql = null;
			if (searchStatus.equals("0")) {
				sql = "SELECT * FROM Donations WHERE donation_title like N'%" + character + "%' AND use_yn = 1";
			} else {
				sql = "SELECT * FROM Donations WHERE donation_title like N'%" + character + "%' AND donation_status = " + searchStatus + " AND use_yn = 1";
			}
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			this.noOfRecords = 0;
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getString("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));
				d.setSrc(rs.getString("thumbnail"));

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

	public List<Donations> getRecord(String character, String searchStatus, int start, int total) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			String sql = null;
			if (searchStatus.equals("0")) {
				sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id DESC) as rownb FROM donations WHERE donation_title like N'%"	+ character + "%' AND use_yn = 1) a" + " WHERE rownb >= " + start + "AND rownb <= " + total;
			} else {
				sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id DESC) as rownb FROM donations WHERE donation_title like N'%"	+ character + "%' AND donation_status = " + searchStatus + " AND use_yn = 1) a" + " WHERE rownb >= " + start + "AND rownb <= " + total;
			}
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getString("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));
				d.setSrc(rs.getString("thumbnail"));

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
			ResultSet rs = statement
					.executeQuery("SELECT * FROM donations WHERE donation_id = " + id + "AND use_yn = 1");

			if (rs.next()) {
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getString("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));
				d.setSrc(rs.getString("thumbnail"));

			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return d;
	}

	public void insertDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
			String sql = "INSERT INTO Donations (donation_status, donation_title, donation_content, start_date, end_date, total_needed, thumbnail) VALUES (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, d.getStatus());
			stmt.setString(2, d.getTitle());
			stmt.setString(3, d.getContent());
			stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
			stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
			stmt.setFloat(6, d.getTotalNeeded());
			stmt.setString(7, d.getSrc());
			stmt.executeUpdate();
			stmt.close();
	}

	public void deleteDonation(List<Donations> ds) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "BEGIN TRANSACTION\n";
			sql += "UPDATE Donations SET use_yn = 0 WHERE donation_id in (";
			String separator = "";
			for (Donations d : ds) {
				sql += separator + d.getId();
				separator = ", ";
			}
			sql += ")\n";
			sql += "COMMIT TRANSACTION";
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public void updateDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "UPDATE Donations SET donation_status = ?, donation_title = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?, thumbnail = ? WHERE donation_id = "
					+ d.getId();
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setString(1, d.getStatus());
			stmt.setString(2, d.getTitle());
			stmt.setString(3, d.getContent());
			stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
			stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
			stmt.setFloat(6, d.getTotalNeeded());
			stmt.setString(7, d.getSrc());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
}
