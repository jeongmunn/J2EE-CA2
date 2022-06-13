package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import foods.Food;

/**
 * Servlet implementation class LoadAllFood
 */
@WebServlet("/LoadAllFood")
public class LoadAllFood extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoadAllFood() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				// TODO Auto-generated method stub

		
				// return PrintWriter object to print anything on the browser as response
				PrintWriter out = response.getWriter();
				String foodName, briefDesc, detailDesc, pictureURL, categoryName ;
				int foodId, stock, sales;
				double retailPrice, costPrice ;
				
				String page = "" , pages = "" ;
				int cartFoodId = 0 ;				
				if(request.getParameter("foodid")!=null) {
					try {
						cartFoodId = Integer.parseInt(request.getParameter("foodid"));
					}catch(Exception e) {
						response.sendRedirect("CA2/Cart.jsp?errCode=invalidFoodId");
					}
		            page = "user" ;
		            pages = request.getParameter("page");
		        }else {
		            page = "admin" ;
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
					
					// Create SQL query
					String sqlStr = "{call getAllFood() }";
					
					// Create CallableStatement object
					CallableStatement cs = conn.prepareCall(sqlStr);

					// Execute SQL command
					ResultSet rs = cs.executeQuery();
				
					// Process result
					while (rs.next()) {
						// Store data respectively
						foodId = rs.getInt("food_id");
						foodName = rs.getString("food_name");
						briefDesc = rs.getString("brief_description");
						costPrice = rs.getDouble("cost_price");
						retailPrice = rs.getDouble("retail_price");
						stock = rs.getInt("stock");
						categoryName = rs.getString("category_name");
						pictureURL = rs.getString("picture");
						detailDesc = rs.getString("detail_description");
						sales = rs.getInt("sales");
						// Create a new instance of Food
						foodlist.add(new Food(foodId,foodName,briefDesc,costPrice,retailPrice,stock,categoryName,pictureURL,detailDesc, sales));
					}
					
					// Close connection
					conn.close();
					} catch (Exception e) {
						out.println("Couldn't load all food");
						out.println("Err = " + e);
						if(page == "user") {
							response.sendRedirect("CA2/Cart.jsp?errCode=invalid");
							return;
						}else {
							response.sendRedirect("CA2/Product-Management.jsp?errCode=invalid");
							return;
						}
					}
					
					// return current HttpSession associated with request, if there is no current session, returns a new session
					HttpSession session = request.getSession(true);
					// Create session attributes
					session.setAttribute("allFood",foodlist);
					
					if(page == "user") {
						RequestDispatcher rd = request.getRequestDispatcher("CheckQuantity?foodid=" + cartFoodId + "&&page=" + pages);
						rd.forward(request,response);
					}else {
						RequestDispatcher rd = request.getRequestDispatcher("LoadCategory?admin=true");
						rd.forward(request,response);
					}
					
					
					//response.sendRedirect("CA1/Administrator.jsp?allfoodlist=true");
				//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
