package servlets;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import foods.Food;

/**
 * Servlet implementation class AddFood
 */
@MultipartConfig
@WebServlet("/AddFood")
public class AddFood extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddFood() {
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
		int foodid = 0, stock = 0, categoryid = 0, sales = 0;
		double retailPrice = 0.0, costPrice = 0.0;
		HttpSession session = request.getSession(true);
		String foodName = request.getParameter("foodname");
		String briefDes = request.getParameter("briefdes");
		
		String retailPricet = request.getParameter("retailprice");
		try {
			retailPrice = Double.parseDouble(retailPricet);
		} catch (Exception e) {
			out.println("Invalid retail price");
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
			return;
		}
		
		String costPricet = request.getParameter("costprice");
		try {
			costPrice = Double.parseDouble(costPricet);
		} catch (Exception e) {
			out.println("Invalid cost price");
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
			return;
		}
		
		String stockt = request.getParameter("stock");
		try {
			stock = Integer.parseInt(stockt);
		} catch (Exception e) {
			out.println("Invalid stock");
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
			return;
		}
		
		String categoryt = request.getParameter("category");
		try {
			categoryid = Integer.parseInt(categoryt);
		} catch (Exception e) {
			out.println("Invalid categoryid");
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
			return;
		}
		
		if(retailPrice < 0 || costPrice < 0 || stock < 0 || categoryid < 0) {
			out.println("Negative input value");
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
			return ;
		}
		
		// for default image
		//if(pictureURL.equals(null) || pictureURL.equals("")) {
			//pictureURL = "https://danielfooddiary.com/wp-content/uploads/2018/02/marketstreet18.jpg";
		//}
		
		String fileUploadname = "";
		try {
			// Image storage section
			Part pictureURL = request.getPart("pictureURL");
			String imgFileName = pictureURL.getSubmittedFileName();
			boolean haveImage = true;
			if (imgFileName.equals("") || imgFileName == null) {
					haveImage = false;
			} else {
				Object type = pictureURL.getHeader("content-type");
			if (type.equals("image/jpeg") || type.equals("image/png") || type.equals("image/jpg") || type.equals("image/gif") || type.equals("image/bmp")) {
				// Convert into String to concat with the file
				// Getting the current date
				Date date = new Date();
				// This method returns the time in millis
				long timeMilli = date.getTime();
				// File
				String trial = getServletContext().getRealPath("");
				String[] tokens = trial.replace("\\", "/").split("/");
				String finalpathing = "";
				for (int i = 0; i < tokens.length - 6; i++) {
					finalpathing += tokens[i] + "/";
				}				
				finalpathing+= tokens[tokens.length - 1] + "/src/main/webapp/CA2/img/";

				String uploadPath = (finalpathing + timeMilli + imgFileName);
				
				FileOutputStream fos = new FileOutputStream(uploadPath);
				InputStream is = pictureURL.getInputStream();
				byte[] data = new byte[is.available()];
								is.read(data);
								fos.write(data);
								fos.close();
				fileUploadname = "./img/" + timeMilli + imgFileName;
			} else {
				response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
				return;
			}
		} 
		}catch(Exception e){
			out.print("Error : " + e);
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
		}
		
		String detailDes = request.getParameter("detaildes");

		// Database
		try {
			System.out.println("Yes I reached here");
			// Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");

			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Create SQL query
			String sqlStr = "INSERT INTO food (food_name, brief_description, cost_price, retail_price, stock, category, picture, detail_description, sales) VALUES (?,?,?,?,?,?,?,?,?)";
			// Create CallableStatement object
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, foodName);
			pstmt.setString(2, briefDes);
			pstmt.setDouble(3, costPrice);
			pstmt.setDouble(4, retailPrice);
			pstmt.setInt(5, stock);
			pstmt.setInt(6, categoryid);
			pstmt.setString(7,fileUploadname);
			pstmt.setString(8, detailDes);
			pstmt.setInt(9, sales);
			// Execute SQL command
			int count = pstmt.executeUpdate();
			System.out.println(count);
			// Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Couldn't add food");
			out.println("Err = " + e);
			response.sendRedirect("CA2/Add-Product.jsp?errCode=invalid");
			return;
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
