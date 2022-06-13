package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserDatabase;

/**
 * Servlet implementation class RegisterUserAdmin
 */

@WebServlet("/RegisterUserAdmin")
public class RegisterUserAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUserAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				doGet(request, response);
				// return PrintWriter object to print anything on the browser as response
				PrintWriter out = response.getWriter();
				String urole = (String)request.getParameter("role");
				if (urole.equals("Admin")) {
					urole = "admin";
				} else {
					urole = "customer";
				}
				// Database
				try {
					UserDatabase UserDatabase = new UserDatabase();
					String uname = request.getParameter("username");
					String uemail = request.getParameter("email");
					String pwd = request.getParameter("password");
					String uphoneNumber = request.getParameter("phoneNumber");
					String uroadName = request.getParameter("roadName");
					String ufloorNumber = request.getParameter("floorNumber");
					String ucountry = request.getParameter("country");
					String ucityState = request.getParameter("city");
					int uzip = Integer.parseInt(request.getParameter("zip"));
					System.out.println("So far so good");
					UserDatabase.registerUser(uname, uemail, pwd, uphoneNumber, uroadName, ufloorNumber, ucountry, ucityState, uzip, urole);
							
				} catch (Exception e) {
					out.println("Error :  + e");
					response.sendRedirect("CA2/Administrator.jsp?errCode=invalidRegister");
					return;
				}
				response.sendRedirect("CA2/Administrator.jsp");
			}

}
