package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.sql.*;

import foods.Order;
import foods.User;

/**
 * Servlet implementation class LoadAllOrder
 */
@WebServlet("/LoadAllOrder")
public class LoadAllOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadAllOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// return PrintWriter object to print anything on the browser as response
		PrintWriter out = response.getWriter();
		int orderId ;
		double totalAmount ;
		String date, username ;
						
		// Create an ArrayList
		ArrayList<Order>orderlist = new ArrayList<Order>(0);
		
		// Database 
		try {
			// Load JDBC Driver 
			Class.forName("com.mysql.jdbc.Driver");
			
			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";
			
			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			
			//Create Statement object
			Statement stmt = conn.createStatement();

			//Execute SQL Command
			String sqlStr = "SELECT o.order_id, o.totalAmount, o.date, u.username FROM hawkerfood.order_history as o , user as u WHERE o.user_id = u.userid;";
			ResultSet rs = stmt.executeQuery(sqlStr);
			
			// Process result
			while (rs.next()) {
				// Store data respectively
				orderId = rs.getInt("order_id");
				username = rs.getString("username");
				totalAmount = rs.getDouble("totalAmount");
				date = rs.getString("date");
				
				// Create a new instance of Food
				orderlist.add(new Order(orderId,username,totalAmount,date));
			}
			
			// Close connection
			conn.close();
			// return current HttpSession associated with request, if there is no current session, returns a new session
			HttpSession session = request.getSession(true);
			// Create session attributes
			session.setAttribute("allOrder",orderlist);
			response.sendRedirect("CA2/Order-Management.jsp?orderlist=true");

			} catch (Exception e) {
				out.println("Couldn't load all order");
				out.println("Err = " + e);
				response.sendRedirect("CA2/Order-Management.jsp?errCode=invalid");
				return;
			}
			
			
			
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
