package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import model.Donations;

public class ListDonationsDAO {
	private int noOfRecords;
	
	public List<Donations> search(String character) throws Exception{
		Connection connection = new DBContext().getConnection();
		List<Donations> list = new ArrayList<>();
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Donations WHERE donation_name like '%" + character + "%'"); 
			this.noOfRecords = 0;
			while(rs.next()) {
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
			ResultSet rs = statement
					.executeQuery("SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id) as rownb FROM donations) a"
							+ " WHERE rownb >= " + start + "AND rownb <= " + total);
			while(rs.next()) {
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
	
}
