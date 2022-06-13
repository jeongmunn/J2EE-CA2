package servlets;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
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

/**
 * Servlet implementation class EditFood
 */
@MultipartConfig
@WebServlet("/EditFood")
public class EditFood extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditFood() {
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
		
		String foodidt = request.getParameter("foodid");
		try {
			foodid = Integer.parseInt(foodidt);
		} catch (Exception e) {
			out.println("Invalid foodid");
			response.sendRedirect("CA2/Administrator.jsp?errCode=invalidFoodId");
		}
		
		String foodName = request.getParameter("foodname");
		String briefDes = request.getParameter("briefdes");
		
		String retailPricet = request.getParameter("retailprice");
		try {
			retailPrice = Double.parseDouble(retailPricet);
		} catch (Exception e) {
			out.println("Invalid retail price");
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid&&foodId=" + foodid);
			return;
		}
		
		String costPricet = request.getParameter("costprice");
		try {
			costPrice = Double.parseDouble(costPricet);
		} catch (Exception e) {
			out.println("Invalid cost price");
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid&&foodId=" + foodid);
			return;
		}
		
		String stockt = request.getParameter("stock");
		try {
			stock = Integer.parseInt(stockt);
		} catch (Exception e) {
			out.println("Invalid stock");
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid&&foodId=" + foodid);
			return;
		}
		
		String categoryt = request.getParameter("category");
		try {
			categoryid = Integer.parseInt(categoryt);
		} catch (Exception e) {
			out.println("Invalid categoryd");
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid&&foodId=" + foodid);
			return;
		}
		
		if(retailPrice < 0 || costPrice < 0 || stock < 0 || categoryid < 0) {
			out.println("Negative input value");
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid&&foodId=" + foodid);
			return ;
		}
		
		String fileUploadname = "https://danielfooddiary.com/wp-content/uploads/2018/02/marketstreet18.jpg";
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
				out.println(finalpathing);

				String uploadPath = (finalpathing + timeMilli + imgFileName);
				FileOutputStream fos = new FileOutputStream(uploadPath);
				InputStream is = pictureURL.getInputStream();
				byte[] data = new byte[is.available()];
								is.read(data);
								fos.write(data);
								fos.close();
				fileUploadname = "./img/" + timeMilli + imgFileName;
			} else {
				out.print("image upload complete failure");
				response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid");
				return;
			}
		} 
		}catch(Exception e){
			out.print("Error : " + e);
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid");
			return;
		}
		
		String detailDes = request.getParameter("detaildes");

		// Database
		try {
			// Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");

			// Define connection URL
			String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";

			// Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Create SQL query
			String sqlStr = "{call editFoodById(?,?,?,?,?,?,?,?,?,?)}";

			// Create CallableStatement object
			CallableStatement cs = conn.prepareCall(sqlStr);
			cs.setString(1, foodName);
			cs.setString(2, briefDes);
			cs.setDouble(3, costPrice);
			cs.setDouble(4, retailPrice);
			cs.setInt(5, stock);
			cs.setInt(6, categoryid);
			cs.setString(7, fileUploadname);
			cs.setString(8, detailDes);
			cs.setInt(9, sales);
			cs.setInt(10, foodid);
			
			// Execute SQL command
			int count = cs.executeUpdate();

			// Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Couldn't update food");
			out.println("Err = " + e);
			response.sendRedirect("CA2/Edit-Product.jsp?errCode=invalid&&foodId=" + foodid);
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
