package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserDatabase;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditProfile() {
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
		HttpSession session = request.getSession(true);
		int userid = 0;
		String useridt = String.valueOf(session.getAttribute("sessUserId"));
		try {
			userid = Integer.parseInt(useridt);
		} catch (Exception e) {
			response.sendRedirect("CA2/Profile.jsp?errCode=invalidInput");
		}
		String uname = request.getParameter("username");
		String uemail = request.getParameter("email");
		String pwd = request.getParameter("password");
		String uphoneNumber = request.getParameter("phoneNumber");
		String uroadName = request.getParameter("roadName");
		String ufloorNumber = request.getParameter("floorNumber");
		if (ufloorNumber == "null") {
			ufloorNumber = null;
		}
		String ucountry = request.getParameter("country");
		String ucityState = request.getParameter("city");
		int uzip = Integer.parseInt(request.getParameter("zip"));

		// Database
		try {
			UserDatabase UserDatabase = new UserDatabase();
			session.setAttribute("sessUsername", uname);
			session.setAttribute("sessUserEmail", uemail);
			session.setAttribute("sessUserPassword", pwd);
			session.setAttribute("sessPhoneNumber", uphoneNumber);
			session.setAttribute("sessRoadName", uroadName);
			session.setAttribute("sessFloorNumber", ufloorNumber);
			session.setAttribute("sessCountry", ucountry);
			session.setAttribute("sessCityState", ucityState);
			session.setAttribute("sessZip", uzip);
			UserDatabase.editUser(uname, uemail, pwd, uphoneNumber, uroadName, ufloorNumber, ucountry, ucityState, uzip, useridt);

		} catch (Exception e) {
			out.println("Error :  + e");
			response.sendRedirect("CA2/EditProfile.jsp?errCode=invalidUpdate");
		}
		response.sendRedirect("CA2/Profile.jsp");
		

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
