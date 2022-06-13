package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import foods.Food;

/**
 * Servlet implementation class LoadFood
 */
@WebServlet("/LoadFood")
public class LoadFood extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoadFood() {
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
		String categoryt = "", page = "" , cart = "false";
		int category ;
		if(request.getParameter("category")!=null) {
            categoryt = request.getParameter("category");
            page = "admin" ;
        }else {
            categoryt = request.getParameter("catid");
            page = "user" ;
            cart = request.getParameter("page");
        }
		
		if(categoryt.equals("all")) {
			response.sendRedirect("LoadAllFood");
			return;
		}else {
			category = Integer.parseInt(categoryt);
		}

		String foodName, briefDesc, detailDesc, pictureURL, categoryName;
		int foodId, stock, sales;
		double retailPrice, costPrice;

		// Create an ArrayList
		ArrayList<Food> foodlist = new ArrayList<Food>(0);

		// Database
		try {
			// Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");

			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Create SQL query
			String sqlStr = "{call getAllFoodByCategory(?) }";

			// Create CallableStatement object
			CallableStatement cs = conn.prepareCall(sqlStr);
			cs.setInt(1, category);

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
				foodlist.add(new Food(foodId, foodName, briefDesc, costPrice, retailPrice, stock, categoryName,
						pictureURL, detailDesc, sales));
			}

			// Close connection
			conn.close();
		} catch (Exception e) {
			//out.println("Couldn't load food");
			//out.println("Err = " + e);
			if (page == "admin") {
				response.sendRedirect("CA2/Product-Management.jsp?errCode=invalid");
			} else {
				response.sendRedirect("CA2/Product.jsp?errCode=invalidFoodId");
			}
		}
		
		// return current HttpSession associated with request, if there is no current
		// session, returns a new session
		HttpSession session = request.getSession(true);
		// Create session attributes
		session.setAttribute("food", foodlist);
		if (page == "admin") {
			response.sendRedirect("CA2/Product-Management.jsp?foodlist=true");
		} else {
			session.setAttribute("catid", category);
			response.sendRedirect("CA2/Product.jsp?foodlist=true");
		}

		// response.getWriter().append("Served at: ").append(request.getContextPath());
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
