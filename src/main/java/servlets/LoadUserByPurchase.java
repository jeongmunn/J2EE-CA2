package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import foods.SumOfOrder;
import foods.User;

/**
 * Servlet implementation class LoadUserByPurchase
 */
@WebServlet("/LoadUserByPurchase")
public class LoadUserByPurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadUserByPurchase() {
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
		String username ;
		int userId , numberOfOrder ;
		double sumOfOrderAmount ;
		ArrayList<User>userlist ;
		
		// return current HttpSession associated with request, if there is no current session, returns a new session
		HttpSession session = request.getSession(true);
		
		if(request.getParameter("userlist") != null || request.getAttribute("userlist").equals("true")) {
			userlist = (ArrayList<User>)session.getAttribute("user");
		}else {
			response.sendRedirect("CA2/Order-Management.jsp?errCode=invalid");
			return;
		}
		
		
		// Create an ArrayList
		ArrayList<SumOfOrder>customerlist = new ArrayList<SumOfOrder>(10);
		
		
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

			for(int i = 0 ; i < userlist.size() ; i++) {
				User user = userlist.get(i);
				
			//Execute SQL Command
			String sqlStr = "SELECT u.userid, u.username, SUM(o.totalAmount), COUNT(order_id) FROM order_history as o , user as u WHERE o.user_id = u.userid && u.userid = "+ user.getUserid() +";";
			ResultSet rs = stmt.executeQuery(sqlStr);
			
			// Process result
			while (rs.next()) {
				// Store data respectively
				userId = rs.getInt("userid");
				sumOfOrderAmount = rs.getDouble("SUM(o.totalAmount)");
				numberOfOrder = rs.getInt("COUNT(order_id)");
				username = rs.getString("username");
				
				if(numberOfOrder > 0) {
				// Create a new instance of Food
				customerlist.add(new SumOfOrder(userId,sumOfOrderAmount,numberOfOrder,username));
				}
			}
			} //close for loop
			// Close connection
			conn.close();
			} catch (Exception e) {
				out.println("Couldn't load all order");
				out.println("Err = " + e);
			}

			// Create session attributes
			session.setAttribute("customer",customerlist);
			
			response.sendRedirect("CA2/Order-Management.jsp?customerlist=true");
			
			
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
