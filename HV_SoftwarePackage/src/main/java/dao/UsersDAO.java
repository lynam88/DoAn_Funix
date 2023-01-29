/*
 * package dao;
 * 
 * import java.sql.Connection; import java.sql.PreparedStatement; import
 * java.sql.ResultSet; import java.sql.SQLException; import java.sql.Statement;
 * import java.util.ArrayList; import java.util.List;
 * 
 * import context.DBContext; import model.Users;
 * 
 * public class UsersDAO {
 * 
 * private int noOfRecords;
 * 
 * public List<Users> search(String character, String phone) throws Exception {
 * Connection connection = new DBContext().getConnection(); List<Users> list =
 * new ArrayList<>(); try { String sql =
 * "SELECT * FROM Users WHERE username like '%" + character +
 * "%' AND phone like '%" + character + "%' AND status = 1";
 * 
 * Statement stmt = connection.createStatement(); ResultSet rs =
 * stmt.executeQuery(sql); this.noOfRecords = 0; while (rs.next()) { Users a =
 * new Users(); a.setId(rs.getInt("donation_id"));
 * a.setStatus(rs.getInt("account_role")); a.setTitle(rs.getString("name"));
 * a.setContent(rs.getString("donation_content"));
 * a.setStartDate(rs.getDate("start_date"));
 * a.setEndDate(rs.getDate("end_date"));
 * a.setTotalNeeded(rs.getFloat("total_needed"));
 * a.setSrc(rs.getString("thumbnail"));
 * 
 * list.add(d); this.noOfRecords++; }
 * 
 * } catch (SQLException ex) { ex.printStackTrace(); } return list; }
 * 
 * public int getNoOfRecords() { return noOfRecords;
 * 
 * }
 * 
 * public List<Users> getRecord(String character, String searchStatus, int
 * start, int total) throws Exception { Connection connection = new
 * DBContext().getConnection(); List<Users> list = new ArrayList<>(); try {
 * String sql = null; if (searchStatus.equals("0")) { sql =
 * "SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id DESC) as rownb FROM Users WHERE name like '%"
 * + character + "%' AND use_yn = 1) a" + " WHERE rownb >= " + start +
 * "AND rownb <= " + total; } else { sql =
 * "SELECT * FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY donation_id DESC) as rownb FROM Users WHERE name like '%"
 * + character + "%' AND account_role = " + searchStatus + " AND use_yn = 1) a"
 * + " WHERE rownb >= " + start + "AND rownb <= " + total; } Statement stmt =
 * connection.createStatement(); ResultSet rs = stmt.executeQuery(sql); while
 * (rs.next()) { Users a = new Users(); a.setId(rs.getInt("donation_id"));
 * a.setStatus(rs.getInt("account_role")); a.setTitle(rs.getString("name"));
 * a.setContent(rs.getString("donation_content"));
 * a.setStartDate(rs.getDate("start_date"));
 * a.setEndDate(rs.getDate("end_date"));
 * a.setTotalNeeded(rs.getFloat("total_needed"));
 * a.setSrc(rs.getString("thumbnail"));
 * 
 * list.add(d); } } catch (SQLException ex) { ex.printStackTrace(); } return
 * list; }
 * 
 * public Users getDonation(int id) throws Exception { Connection connection =
 * new DBContext().getConnection(); Users a = new Users(); try { Statement
 * statement = connection.createStatement(); ResultSet rs = statement
 * .executeQuery("SELECT * FROM Users WHERE donation_id = " + id +
 * "AND use_yn = 1");
 * 
 * if (rs.next()) { a.setId(rs.getInt("donation_id"));
 * a.setStatus(rs.getInt("account_role")); a.setTitle(rs.getString("name"));
 * a.setContent(rs.getString("donation_content"));
 * a.setStartDate(rs.getDate("start_date"));
 * a.setEndDate(rs.getDate("end_date"));
 * a.setTotalNeeded(rs.getFloat("total_needed"));
 * a.setSrc(rs.getString("thumbnail"));
 * 
 * } } catch (SQLException ex) { ex.printStackTrace(); } return d; }
 * 
 * public void insertDonation(Users a) throws Exception { Connection connection
 * = new DBContext().getConnection(); String sql =
 * "INSERT INTO Users (account_role, name, donation_content, start_date, end_date, total_needed, thumbnail) VALUES (?, ?, ?, ?, ?, ?, ?)"
 * ; PreparedStatement stmt = connection.prepareStatement(sql);
 * 
 * stmt.setInt(1, a.getStatus()); stmt.setString(2, a.getTitle());
 * stmt.setString(3, a.getContent()); stmt.setDate(4, new
 * java.sql.Date(a.getStartDate().getTime())); stmt.setDate(5, new
 * java.sql.Date(a.getEndDate().getTime())); stmt.setFloat(6,
 * a.getTotalNeeded()); stmt.setString(7, a.getSrc()); stmt.executeUpdate();
 * stmt.close(); }
 * 
 * public void deleteDonation(List<Users> ds) throws Exception { Connection
 * connection = new DBContext().getConnection(); try { String sql =
 * "BEGIN TRANSACTION\n"; sql +=
 * "UPDATE Users SET use_yn = 0 WHERE donation_id in ("; String separator = "";
 * for (Users a : ds) { sql += separator + a.getId(); separator = ", "; } sql +=
 * ")\n"; sql += "COMMIT TRANSACTION"; PreparedStatement stmt =
 * connection.prepareStatement(sql);
 * 
 * stmt.executeUpdate(); stmt.close();
 * 
 * } catch (SQLException ex) { ex.printStackTrace(); } }
 * 
 * public void updateDonation(Users a) throws Exception { Connection connection
 * = new DBContext().getConnection(); try { String sql =
 * "UPDATE Users SET account_role = ?, name = ?, donation_content = ?, start_date = ?, end_date = ?, total_needed = ?, thumbnail = ? WHERE donation_id = "
 * + a.getId(); PreparedStatement stmt = connection.prepareStatement(sql);
 * 
 * stmt.setInt(1, a.getStatus()); stmt.setString(2, a.getTitle());
 * stmt.setString(3, a.getContent()); stmt.setDate(4, new
 * java.sql.Date(a.getStartDate().getTime())); stmt.setDate(5, new
 * java.sql.Date(a.getEndDate().getTime())); stmt.setFloat(6,
 * a.getTotalNeeded()); stmt.setString(7, a.getSrc()); stmt.executeUpdate();
 * stmt.close();
 * 
 * } catch (SQLException ex) { ex.printStackTrace(); } } }
 */