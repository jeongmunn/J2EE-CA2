package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import com.stripe.param.ChargeCreateParams;
import foods.Cart;
/**
 * Servlet implementation class Payment
 */
public class Payment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Payment() {
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
		try {
			 HttpSession session = request.getSession(true);
			 // gets the total price of the order
			 double totalPrice = Double.parseDouble((String) session.getAttribute("totalPriceForCart"));
			 // round it off to 2dp
			 totalPrice = Math.round(totalPrice * 100.0) / 100.0;
			 // converting it to cents for Stripe
			 long totalPriceInCents = (long) Math.round(totalPrice * 100);
			 // Set your secret key. Remember to switch to your live secret key in production.
			 // See your keys here: https://dashboard.stripe.com/apikeys
			 Stripe.apiKey = "sk_test_51JKPZKJW2czgnqf8WznAldE8qJwYsqGPY73ugcLI2KQWupX2yJfz2xxq1uj3Q6XKjDRgHDeEyuxjouxhP6gxzbMC00KxSxkknj";

		 
			 // Token is created using Stripe Checkout or Elements!
			 // Get the payment token ID submitted by the form:
			 String token = request.getParameter("stripeToken");
		 
		 
			 ChargeCreateParams params =
					 ChargeCreateParams.builder()
					 .setAmount(totalPriceInCents)
					 .setCurrency("sgd")
					 .setDescription("Payment successfully made to Market Street Hawker Centre")
					 .setSource(token)
					 .build();

			Charge charge = Charge.create(params);
			
			try {
				// Declaration
				int sessUserId = (int) request.getSession().getAttribute("sessUserId");
				ArrayList<Cart> cartlist = (ArrayList<Cart>) request.getSession().getAttribute("cartlist");
				// Load JDBC Driver
				Class.forName("com.mysql.jdbc.Driver");
				// Define connection URL
				String connURL = "jdbc:mysql://localhost/hawkerfood?user=root&password=password17&serverTimezone=UTC";
				// Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);
				// Create Statement object
				Statement stmt = conn.createStatement();
				String insertSQL = "INSERT INTO hawkerfood.order_history(user_id, totalAmount) VALUES (?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(insertSQL);
				pstmt.setInt(1, sessUserId);
				pstmt.setDouble(2, totalPrice);
				int count = pstmt.executeUpdate();
				String searchSQL = "SELECT * FROM hawkerfood.order_history where user_id = ? ORDER BY order_id DESC";
				pstmt = conn.prepareStatement(searchSQL);
				pstmt.setInt(1, sessUserId);
				ResultSet rs = pstmt.executeQuery();
				int order_id = 0;
				if (rs.next()) {
					order_id = rs.getInt("order_id");
				}
				for (int i = 0; i < cartlist.size(); i++) {
					for (int n = 0; n < cartlist.get(i).getQuantity(); n++) {
						insertSQL = "INSERT INTO hawkerfood.purchase_history(order_id, food_id) VALUES (?, ?)";
                        pstmt = conn.prepareStatement(insertSQL);
						pstmt.setInt(1, order_id);
						pstmt.setInt(2, cartlist.get(i).getFoodId());
						count = pstmt.executeUpdate();
					}
				}
				// Close connection
				conn.close();
			} catch (Exception e) {
				response.sendRedirect("CA2/Cart.jsp?errCode=unsuccessfulPayment");
			}
			
			// remove items from cart and amount paid after successful payment
			session.removeAttribute("cartlist");
			session.removeAttribute("totalPriceForCart");
			response.sendRedirect("CA2/Home.jsp");
		} catch (StripeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("CA2/Cart.jsp?errCode=unsuccessfulPayment");
		}
		
	}

}
