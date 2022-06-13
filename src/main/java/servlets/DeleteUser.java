package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import java.util.ArrayList;

import foods.Food;
import foods.User;

/**
 * Servlet implementation class DeleteUser
 */
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		int userid = 0;
		String useridt = request.getParameter("userid");
		try {
			userid = Integer.parseInt(useridt);
		} catch (Exception e) {
			out.println("Invalid userid");
			response.sendRedirect("CA2/Customer-Management?errCode=invalidUserId");
		}

		// Create an ArrayList
		ArrayList<User> userlist = new ArrayList<User>(0);

		// Database
		try {
			// Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");

			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Create SQL query
			String sqlStr = "DELETE FROM user WHERE userid = ?";

			// Create PreparedStatement object
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1,userid);

			// Execute SQL command
			int count = pstmt.executeUpdate();

			// Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Couldn't delete food");
			out.println("Err = " + e);
			response.sendRedirect("CA2/Customer-Management?errCode=invalid");
		}

		response.sendRedirect("LoadUser");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
