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
 * Servlet implementation class DeleteFood
 */
@WebServlet("/DeleteFood")
public class DeleteFood extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteFood() {
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
		int foodid = 0;
		String foodidt = request.getParameter("foodid");
		try {
			foodid = Integer.parseInt(foodidt);
		} catch (Exception e) {
			out.println("Invalid foodid");
			response.sendRedirect("CA2/Product-Management.jsp?errCode=invalidFoodId");
		}

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
			String sqlStr = "{call deleteFoodById(?)}";

			// Create CallableStatement object
			CallableStatement cs = conn.prepareCall(sqlStr);
			cs.setInt(1, foodid);

			// Execute SQL command
			int count = cs.executeUpdate();

			// Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Couldn't delete food");
			out.println("Err = " + e);
			response.sendRedirect("CA2/ProductManagement.jsp?errCode=invalid");
		}

		response.sendRedirect("LoadAllFood");

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
