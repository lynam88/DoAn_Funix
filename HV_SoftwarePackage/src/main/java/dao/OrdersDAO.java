package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import context.DBContext;
import model.Cart;
import model.Orders;
import model.Product;

public class OrdersDAO {

	public void insertOrder(Orders o, Cart c) throws Exception {
		Connection connection = new DBContext().getConnection();
		try {
			List<Product> pr = c.getItems();
			String sql = "INSERT INTO orders_detail VALUES (?, ?, ?, NULL)";
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT TOP 1 order_id FROM orders_detail ORDER BY order_id DESC");
			int id = 0;
			if (rs.next()) {
				id = rs.getInt("order_id");
			}
			id = id + 1;
			String sql2 = "SET IDENTITY_INSERT orders ON"
					+ " INSERT INTO orders (user_mail, order_id, order_status, order_date, order_discount_code, order_address) VALUES (?, ?, ?, ?, ?, ?)"
					+ " SET IDENTITY_INSERT orders OFF";
			PreparedStatement stmt2 = connection.prepareStatement(sql2);
			
			stmt2.setString(1, o.getUserMail());
			stmt2.setString(2, ""+id);
			stmt2.setString(3, ""+ o.getStatus());
			
			Date date = new Date(Calendar.getInstance().getTime().getTime());
			SimpleDateFormat f = new SimpleDateFormat("yyyy-mm-dd");
			String validDate = f.format(date);
			stmt2.setDate(4, date);
			stmt2.setString(5, o.getDiscount());
			stmt2.setString(6, o.getAddress());
			
			stmt2.executeUpdate();
			stmt2.close();
			
			PreparedStatement stmt3 = connection.prepareStatement(sql);
			for (Product p : pr) {
				stmt3.setString(1, "" + id);
				stmt3.setString(2, "" + p.getId());
				stmt3.setString(3, "" + 1);
				
				stmt3.executeUpdate();
			}
			stmt3.close();
			
		} catch (SQLException ex) {
			// TODO: handle exception
			ex.printStackTrace();
		}
	}
}
