package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import foods.User;

public class UserDatabase {
	
	public boolean verifyUser(String uname) {
		try {
			// Establish connection to URL
			Connection conn = DBConnection.getConnection();
			// Create Statement object
			Statement stmt = conn.createStatement();

			// Execute SQL command
			String sqlStr = "SELECT * FROM user WHERE username = '" + uname + "'";
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Process result
			if (rs.next()) {
				System.out.println("Verification is a success");
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public User retrieveUserInfo(String uname) {
		try {
			// Establish connection to URL
			Connection conn = DBConnection.getConnection();
			// Create Statement object
			Statement stmt = conn.createStatement();

			// Execute SQL command
			String sqlStr = "SELECT * FROM user WHERE username = '" + uname + "'";
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Process result
			if (rs.next()) {
				User User = new User(rs.getInt("userid"), rs.getString("username"), rs.getString("email"), rs.getString("password"), rs.getString("phoneNumber"), rs.getString("roadName"), rs.getString("floorNumber"), rs.getString("country"), rs.getString("cityState"), rs.getInt("zip"), rs.getString("role"));
				System.out.println("Successfully retrieved");
				return User;
			} else {
				return null;
			}
		} catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
	
	public boolean registerUser(String uname, String uemail, String pwd, String uphoneNumber, String uroadName, String ufloorNumber, String uCountry, String ucityState, int uzip, String urole) {
		try {
			// Establish connection to URL
			Connection conn = DBConnection.getConnection();
			
			// Create SQL query
			String sqlStr = "INSERT INTO user(username, email, password, phoneNumber, roadName, floorNumber, country, cityState, zip, role) VALUES (?,?,?,?,?,?,?,?,?,?)";

			// Create Prepared Statement object
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, uname);
			pstmt.setString(2, uemail);
			pstmt.setString(3, pwd);
			pstmt.setString(4, uphoneNumber);
			pstmt.setString(5, uroadName);
			pstmt.setString(6, ufloorNumber);
			pstmt.setString(7, uCountry);
			pstmt.setString(8, ucityState);
			pstmt.setInt(9, uzip);
			pstmt.setString(10, urole);
			
			// Execute SQL command
			int count = pstmt.executeUpdate();
			
			if (count > 0) {
				System.out.println("User registered successfully");
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			System.out.println("Failure to register user");
			return false;
		}
		
	}
	
	
	public boolean editUser(String uname, String uemail, String pwd, String uphoneNumber, String uroadName, String ufloorNumber, String uCountry, String ucityState, int uzip, String userid) {
		try {
			// Establish connection to URL
			Connection conn = DBConnection.getConnection();
			
			// Create SQL query
			String sqlStr = "UPDATE user SET username = ? , email = ? , password = ? , phoneNumber = ?, roadName = ?, floorNumber = ?, country = ?, cityState = ?, zip = ? WHERE userid = ?";

			// Create Prepared Statement object
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, uname);
			pstmt.setString(2, uemail);
			pstmt.setString(3, pwd);
			pstmt.setString(4, uphoneNumber);
			pstmt.setString(5, uroadName);
			pstmt.setString(6, ufloorNumber);
			pstmt.setString(7, uCountry);
			pstmt.setString(8, ucityState);
			pstmt.setInt(9, uzip);
			pstmt.setString(10, userid);
			
			// Execute SQL command
			int count = pstmt.executeUpdate();
			
			if (count > 0) {
				System.out.println("User details updated successfully");
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			System.out.println("Failure to update user details");
			return false;
		}
		
	}
	
	
	public boolean editUserAdminSide(String uname, String uemail, String pwd, String uphoneNumber, String uroadName, String ufloorNumber, String uCountry, String ucityState, int uzip, String urole, int userid) {
		try {
			// Establish connection to URL
			Connection conn = DBConnection.getConnection();
			
			// Create SQL query
			String sqlStr = "UPDATE user SET username = ? , email = ? , password = ? , phoneNumber = ?, roadName = ?, floorNumber = ?, country = ?, cityState = ?, zip = ?, role = ? WHERE userid = ?";

			// Create Prepared Statement object
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, uname);
			pstmt.setString(2, uemail);
			pstmt.setString(3, pwd);
			pstmt.setString(4, uphoneNumber);
			pstmt.setString(5, uroadName);
			pstmt.setString(6, ufloorNumber);
			pstmt.setString(7, uCountry);
			pstmt.setString(8, ucityState);
			pstmt.setInt(9, uzip);
			pstmt.setString(10, urole);
			System.out.println("User details updated successfully?");
			pstmt.setInt(11, userid);
			System.out.println("User details updated successfully?");
			
			// Execute SQL command
			int count = pstmt.executeUpdate();
			
			if (count > 0) {
				System.out.println("User details updated successfully");
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			System.out.println(e);
			System.out.println("Failure to update user details");
			return false;
		}
		
	}
}
