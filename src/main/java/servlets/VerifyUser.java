package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import foods.User;
import model.*;

/**
 * Servlet implementation class VerifyUser
 */
@WebServlet("/VerifyUser")
public class VerifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VerifyUser() {
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

		String uname = request.getParameter("username");
		String pwd = request.getParameter("password");

		try {
			// getting the boolean regarding wehther user has passed the verification or not
			UserDatabase UserDatabase = new UserDatabase();
			
			// getting whether the username is the correct username
			boolean verify = UserDatabase.verifyUser(uname);
			
			if(!verify) {
				System.out.println("Verification failed");
				response.sendRedirect("CA2/Login.jsp?errCode=invalidLogin");
				return;
			}
	
			// retrieving the user's details from the database
			User User = UserDatabase.retrieveUserInfo(uname);
			
			// checking if user password matches before allowing user to get redirected to the home page
			if (pwd.equals(User.getPassword())) {
				// return current HttpSession associated with request, if there is no current
				// session, returns a new session
				HttpSession session = request.getSession(true);
				// Create session attributes
				session.setAttribute("sessUserId", User.getUserid());
				session.setAttribute("sessUsername", User.getUsername());
				session.setAttribute("sessUserEmail", User.getEmail());
				session.setAttribute("sessUserPassword", User.getPassword());
				session.setAttribute("sessPhoneNumber", User.getPhoneNumber());
				session.setAttribute("sessRoadName", User.getRoadName());
				session.setAttribute("sessFloorNumber", User.getFloorNumber());
				session.setAttribute("sessCountry", User.getCountry());
				session.setAttribute("sessCityState", User.getCityState());
				session.setAttribute("sessZip", User.getZip());
				session.setAttribute("sessUserRole", User.getRole());
				
				System.out.println("User details retrieved");
				response.sendRedirect("CA2/Home.jsp");
				return;

			} else {
				response.sendRedirect("CA2/Login.jsp?errCode=invalidLogin");
			}


		} catch (Exception e) {
			out.println("Error :  " + e);
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
