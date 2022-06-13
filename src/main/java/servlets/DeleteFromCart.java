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
 * Servlet implementation class DeleteFromCart
 */
@WebServlet("/DeleteFromCart")
public class DeleteFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteFromCart() {
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
		int foodId = 0 ;

		try{
			foodId = Integer.parseInt(foodIdt);
		}catch(Exception e){
			out.println("invalidfoodID");
			response.sendRedirect("CA2/Cart.jsp?errCode=invalidFoodIdforDelete");
		}
		try {
		HttpSession session = request.getSession(true);
		ArrayList<Cart> cartlist = (ArrayList<Cart>)session.getAttribute("cartlist");
		if(cartlist != null) {
			cartlist = (ArrayList<Cart>)session.getAttribute("cartlist");
			for(int i = 0; i < cartlist.size() ; i++) {
				Cart cart = cartlist.get(i);
				if(cart.getFoodId() == foodId) {
					cartlist.remove(i);
					out.println("successfully removed");
					break;
				}
			}
		}
		}catch(Exception e) {
			out.println("error");
			response.sendRedirect("CA2/Cart.jsp?errCode=invalidFoodIdforDelete");
		}
		
		response.sendRedirect("CA2/Cart.jsp");	
		
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
