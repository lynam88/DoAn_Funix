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
	 * @param character    text in the input for searching name
	 * @param searchStatus status of the donation for searching
	 * @param category
	 * @return list of donations
	 * @throws Exception
	 */
	public List<Donations> search(String character, String searchStatus, String category) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM Donations WHERE donation_title like ? AND use_yn = 1";
			if (!searchStatus.equals("0")) {
				sql += " AND donation_status = ?";
			}
			if (!category.equals("0")) {
				sql += " AND category = ?";
			}
			sql += " ORDER BY end_date DESC";

			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, "%" + character + "%");
			int index = 2;
			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}
			if (!category.equals("0")) {
				stmt.setString(index++, category);
			}
			ResultSet rs = stmt.executeQuery();

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
				d.setCategory(rs.getString("category"));
				d.setSrc(rs.getString("thumbnail"));
				d.setInsertDate(rs.getDate("insertDate"));

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

	public List<Donations> getRecord(String character, String searchStatus, String category, int pageNo,
			int recordPerPage) throws Exception {
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			String sql = "SELECT donation_id, donation_content, donation_status, donation_title, start_date, end_date, category, thumbnail, COUNT(*) OVER() AS total"
					+ " FROM Donations" + " WHERE use_yn = 1" + " AND donation_title like ? ESCAPE '!'";
			if (!searchStatus.equals("0")) {
				sql += " AND donation_status = ?";
			}
			if (!category.equals("0")) {
				sql += " AND category = ?";
			}
			sql += " ORDER BY end_date DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";

			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, "%" + character + "%");
			int index = 2;
			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}
			if (!category.equals("0")) {
				stmt.setString(index++, category);
			}
			stmt.setInt(index++, pageNo);
			stmt.setInt(index++, recordPerPage);
			stmt.setInt(index++, recordPerPage);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Donations d = new Donations();
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getString("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setCategory(rs.getString("category"));
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
			String sql = "SELECT * FROM donations WHERE donation_id = ? AND use_yn = 1";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setInt(1, id);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				d.setId(rs.getInt("donation_id"));
				d.setStatus(rs.getString("donation_status"));
				d.setTitle(rs.getString("donation_title"));
				d.setContent(rs.getString("donation_content"));
				d.setStartDate(rs.getDate("start_date"));
				d.setEndDate(rs.getDate("end_date"));
				d.setTotalNeeded(rs.getFloat("total_needed"));
				d.setCategory(rs.getString("category"));
				d.setSrc(rs.getString("thumbnail"));
				d.setInsertDate(rs.getDate("insertDate"));

			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return d;
	}

	public void insertDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		String sql = "MERGE INTO Donations AS target "
				+ "USING (VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())) AS source (donation_status, donation_title, donation_content, start_date, end_date, total_needed, category, thumbnail, insertDate) "
				+ "ON target.donation_title = source.donation_title " + "WHEN NOT MATCHED BY TARGET THEN "
				+ "INSERT (donation_status, donation_title, donation_content, start_date, end_date, total_needed, category, thumbnail, insertDate) "
				+ "VALUES (source.donation_status, source.donation_title, source.donation_content, source.start_date, source.end_date, source.total_needed, source.category, source.thumbnail, GETDATE())";

		PreparedStatement stmt = connection.prepareStatement(sql);

		stmt.setString(1, d.getStatus());
		stmt.setString(2, d.getTitle());
		stmt.setString(3, d.getContent());
		stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
		stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
		stmt.setFloat(6, d.getTotalNeeded());
		stmt.setString(7, d.getCategory());
		stmt.setString(8, d.getSrc());
		int run = stmt.executeUpdate();
		stmt.close();
		if (run == 0)
			throw new Exception();
	}

	public void deleteDonation(List<Donations> ds) throws Exception {
		Connection connection = new DBContext().getConnection();

		String sql = "BEGIN TRANSACTION\n";
		sql += "UPDATE Donations SET use_yn = 0 WHERE donation_id in (";
		for (int i = 0; i < ds.size() - 1; i++) {
			sql += "?,";
		}
		sql += "?)\n";
		sql += "COMMIT TRANSACTION";
		PreparedStatement stmt = connection.prepareStatement(sql);

		for (int i = 0; i < ds.size(); i++) {
			stmt.setInt(i + 1, ds.get(i).getId());
		}

		stmt.executeUpdate();
		stmt.close();

	}

	public void updateDonation(Donations d) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			String sql = "UPDATE Donations SET donation_status = ?, donation_title = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?, category = ?, thumbnail = ?, updateDate = GETDATE() WHERE donation_id = "
					+ d.getId();
			PreparedStatement stmt = connection.prepareStatement(sql);

			stmt.setString(1, d.getStatus());
			stmt.setString(2, d.getTitle());
			stmt.setString(3, d.getContent());
			stmt.setDate(4, new java.sql.Date(d.getStartDate().getTime()));
			stmt.setDate(5, new java.sql.Date(d.getEndDate().getTime()));
			stmt.setFloat(6, d.getTotalNeeded());
			stmt.setString(7, d.getCategory());
			stmt.setString(8, d.getSrc());
			stmt.executeUpdate();
			stmt.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public int getMaxId() throws Exception {
		Connection connection = new DBContext().getConnection();
		Statement stmt = connection.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT MAX(donation_id) as maxId FROM Donations");
		int maxId = 0;

		if (rs.next()) {
			maxId = rs.getInt("maxId");
		}
		return maxId;
	}
}
