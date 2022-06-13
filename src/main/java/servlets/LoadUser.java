package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.util.ArrayList;

import foods.Food;
import foods.User;

/**
 * Servlet implementation class LoadUser
 */
public class LoadUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String username, email, password, phoneNumber, roadName, floorNumber, country, cityState, role, page = "";
		int userId, zip;

		if(request.getParameter("page")!=null) {
			page = "order";
		}
		
		// Create an ArrayList
		ArrayList<User> userlist = new ArrayList<User>(0);

		PrintWriter out = response.getWriter();

		// Database
		try {
			// Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");

			//Define Connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

			//Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			//Create Statement object
			Statement stmt = conn.createStatement();

			//Execute SQL Command
			String sqlStr = "SELECT * FROM user";
			ResultSet rs = stmt.executeQuery(sqlStr);
			
			// Process result
			while (rs.next()) {
				// Store data respectively
				userId = rs.getInt("userid");
				username = rs.getString("username");
				email = rs.getString("email");
				password = rs.getString("password");
				phoneNumber = rs.getString("phoneNumber");
				roadName = rs.getString("roadName");
				floorNumber = rs.getString("floorNumber");
				country = rs.getString("country");
				cityState = rs.getString("cityState");
				zip = rs.getInt("zip");
				role = rs.getString("role");
				
				// Create a new instance of Food
				userlist.add(new User(userId,username,email,password, phoneNumber, roadName, floorNumber, country, cityState, zip, role));
			}

			// Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Error :  + e");
			if(page == "order") {
				response.sendRedirect("CA2/Order-Management.jsp?errCode=invalid");
				return;
			}else {
				response.sendRedirect("CA2/Customer-Management.jsp?errCode=invalid");
				return;
			}
		}
		
		// return current HttpSession associated with request, if there is no current
		// session, returns a new session
		HttpSession session = request.getSession(true);
		// Create session attributes
		session.setAttribute("user", userlist);
		if(page == "order") {
			response.sendRedirect("LoadUserByPurchase?userlist=true");
		}else {
			response.sendRedirect("CA2/Customer-Management.jsp?userlist=true");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}



