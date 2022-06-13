package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;

import foods.Food;

/**
 * Servlet implementation class LoadOrder
 */
@WebServlet("/LoadOrder")
public class LoadOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadOrder() {
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
		int orderId = 0 ;
		double retailPrice ;
		String foodName, pictureURL ;
		String orderid = request.getParameter("orderid");
		try {
			orderId = Integer.parseInt(orderid);
		}catch(Exception e) {
			response.sendRedirect("CA2/Order-Management.jsp?errCode=invalid");
		}
						
		// Create an ArrayList
		ArrayList<Food>foodlist = new ArrayList<Food>(0);
		
		// Database 
		try {
			// Load JDBC Driver 
			Class.forName("com.mysql.jdbc.Driver");
			
			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";
			
			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			
			//Execute SQL Command
			String sqlStr = "SELECT f.food_name, f.picture, f.retail_price FROM order_history as o , purchase_history as p, user as u, food as f \r\n" + 
							"WHERE o.order_id = ? && o.order_id = p.order_id && o.user_id = u.userid && p.food_id = f.food_id ;";
			
			
			//Create PreparedStatement object
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1,orderId);
			
			// Execute SQL command  
			 ResultSet rs = pstmt.executeQuery();
			
			// Process result
			while (rs.next()) {
				// Store data respectively
				retailPrice = rs.getDouble("retail_price");
				foodName = rs.getString("food_name");
				pictureURL = rs.getString("picture");
				
				// Create a new instance of Food
				foodlist.add(new Food(0, foodName,"",0, retailPrice,0,"",pictureURL,"",0));
			}
			
			// Close connection
			conn.close();
			} catch (Exception e) {
				out.println("Couldn't load all order");
				out.println("Err = " + e);
				response.sendRedirect("CA2/Order-Management.jsp?errCode=invalid");
			}
			
			// return current HttpSession associated with request, if there is no current session, returns a new session
			HttpSession session = request.getSession(true);
			// Create session attributes
			session.setAttribute("orderFood", foodlist);
			response.sendRedirect("CA2/Order.jsp?orderId=" + orderId);
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
