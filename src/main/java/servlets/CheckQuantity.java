package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import foods.Cart;

/**
 * Servlet implementation class CheckQuantity
 */
@WebServlet("/CheckQuantity")
public class CheckQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckQuantity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// return PrintWriter object to print anything on the browser as response
		PrintWriter out = response.getWriter();

		String foodIdt = request.getParameter("foodid");
		String page = request.getParameter("page");
		int foodId = 0 , quantity = 1; 

		try{
			foodId = Integer.parseInt(foodIdt);
		}catch(Exception e){
			response.sendRedirect("CA2/Cart.jsp?errCode=invalidFoodId");
		}
		
		HttpSession session = request.getSession(true);
		ArrayList<Cart> cartlist = (ArrayList<Cart>)session.getAttribute("cartlist");

		if(cartlist == null) {

		}else {
			for(int i=0 ; i< cartlist.size() ; i++){
				Cart cart = cartlist.get(i);
				quantity = cart.getQuantity();
				if(cart.getFoodId() == foodId){
					quantity += 1;
					if(cart.getStock() >= quantity) {
					cart.setQuantity(quantity);
					if(page.equals("product")) {
						response.sendRedirect("CA2/Product.jsp?foodlist=true&&foodid=" + foodId + "&&quantity=" + quantity);
						return;
					}else {
						response.sendRedirect("CA2/Product-Listing.jsp?foodid=" + foodId + "&&quantity=" + quantity);
						return;
					}
					}else {
						response.sendRedirect("CA2/Cart.jsp?errCode=invalidStock");
						return;
					}
				} 
		}
		} 
		response.sendRedirect("AddToCart?foodid=" + foodId + "&&quantity=" + quantity + "&&page=" + page);
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
