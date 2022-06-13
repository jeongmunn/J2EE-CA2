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

import foods.Category;

/**
 * Servlet implementation class LoadCategory
 */
@WebServlet("/LoadCategory")
public class LoadCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoadCategory() {
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
		String isAdmin;
		try {
			isAdmin = request.getParameter("admin");
		} catch (Exception e) {
			isAdmin = null;
			System.out.println("error getting admin");
		}

		String catName, pictureURL;
		int catId;

		// Create an ArrayList
		ArrayList<Category> catlist = new ArrayList<Category>(0);

		// Database
		try {
			// Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");

			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Create Statement object
			Statement stmt = conn.createStatement();

			// Execute SQL command
			String sqlStr = "SELECT * FROM category";
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Process result
			while (rs.next()) {
				// Store data respectively
				catId = rs.getInt("cat_id");
				catName = rs.getString("category_name");
				pictureURL = rs.getString("category_picture");

				// Create a new instance of Food
				catlist.add(new Category(catId, catName, pictureURL));
			}

			// Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Error :  + e");
			response.sendRedirect("CA2/Product-Categories.jsp?errCode=invalid");
		}

		// return current HttpSession associated with request, if there is no current
		// session, returns a new session
		HttpSession session = request.getSession(true);
		// Create session attributes
		session.setAttribute("category", catlist);

		if (isAdmin != null || isAdmin == "true") {
			response.sendRedirect("CA2/Product-Management.jsp?allfoodlist=true");
		} else {
			response.sendRedirect("CA2/Product-Categories.jsp?catlist=true");
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
