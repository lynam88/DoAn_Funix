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
			String sql = "SELECT * FROM Donations WHERE donation_title like N'%" + character + "%' AND use_yn = 1" + (searchStatus.equals("0") ? "" : " AND donation_status = " + searchStatus);
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

	public List<Donations> getRecord(String character, String searchStatus, int pageNo, int recordPerPage) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {			
			String sql = "SELECT donation_id, donation_content, donation_status, donation_title, start_date, end_date, COUNT(*) OVER() AS total"
					+ " FROM Donations"
					+ " WHERE"
					+ " use_yn = 1"
					+ " AND donation_title like N'%" + character + "%'";
			if (!searchStatus.equals("0")) {
				sql+= " AND donation_status = " + searchStatus;
			}
			sql+= " ORDER BY end_date DESC OFFSET ("
					+ pageNo + "  - 1)*"
					+ recordPerPage + " ROWS FETCH NEXT "
					+ recordPerPage + " ROWS ONLY";			 
			
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
		String sql = "MERGE INTO Donations AS target " +
               "USING (VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())) AS source (donation_status, donation_title, donation_content, start_date, end_date, total_needed, thumbnail, insertDate) " +
               "ON target.donation_title = source.donation_title " +
               "WHEN NOT MATCHED BY TARGET THEN " +
               "INSERT (donation_status, donation_title, donation_content, start_date, end_date, total_needed, thumbnail, insertDate) " +
               "VALUES (source.donation_status, source.donation_title, source.donation_content, source.start_date, source.end_date, source.total_needed, source.thumbnail, GETDATE());";
       
		PreparedStatement stmt = connection.prepareStatement(sql);
		
		stmt.setString(1, d.getStatus());
		stmt.setString(2, d.getTitle());
		stmt.setString(3, d.getContent());
		stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
		stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
		stmt.setFloat(6, d.getTotalNeeded());
		stmt.setString(7, d.getSrc());
		int run = stmt.executeUpdate();
		stmt.close();
		if(run == 0) throw new Exception();
			
			
	}

	public void deleteDonation(List<Donations> ds) throws Exception {
		Connection connection = new DBContext().getConnection();

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
		
	}

	public void updateDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "UPDATE Donations SET donation_status = ?, donation_title = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?, thumbnail = ?, updateDate = GETDATE() WHERE donation_id = "
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
