package model;

import java.sql.*;

public class DBConnection {
	public static Connection getConnection() throws Exception {
		// Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Define connection URL
		String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

		// Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		
		return conn;
	}
}
