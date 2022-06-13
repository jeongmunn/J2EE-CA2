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
 * Servlet implementation class EditQuantity
 */
@WebServlet("/EditQuantity")
public class EditQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditQuantity() {
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
		String edit = request.getParameter("edit");
		int foodId = 0 , index = 0, quantity = 0;

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
				if(cart.getFoodId() == foodId){
					index = i ;
			}
			}
	
			Cart cart = cartlist.get(index);
			quantity = cart.getQuantity();
			if(edit.equals("plus")) {
				quantity += 1 ;
				if(cart.getStock() >= quantity) {
				cart.setQuantity(quantity);
				}else {
					response.sendRedirect("CA2/Cart.jsp?errCode=invalidStock"); 
					return;
				}
			}else if(edit.equals("minus")) {
				if(quantity == 1) {
					cartlist.remove(index);					
				}else {
					quantity -= 1 ;
					if(cart.getStock() >= quantity) {
						cart.setQuantity(quantity);
						}else {
							response.sendRedirect("CA2/Cart.jsp?errCode=invalidStock"); 
							return;
						}
				}
			}else {
				out.println("edit :" + edit);
				response.sendRedirect("CA2/Cart.jsp?errCode=invalid");
			}
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
