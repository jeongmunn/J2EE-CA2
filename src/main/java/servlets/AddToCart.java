package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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

import foods.Food;
import foods.Cart;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCart() {
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
		String quantityt = request.getParameter("quantity"); 
		String page = request.getParameter("page");
		int foodId = 0 , quantity = 0;

		HttpSession session = request.getSession(true);
		ArrayList<Cart> cartlist = (ArrayList<Cart>)session.getAttribute("cartlist");
		if(cartlist != null) {
			cartlist = (ArrayList<Cart>)session.getAttribute("cartlist");
		}else {
			// Create an ArrayList
			cartlist = new ArrayList<Cart>(0);
		}
		
		try{
			foodId = Integer.parseInt(foodIdt);
		}catch(Exception e){
			response.sendRedirect("CA2/Cart.jsp?errCode=invalidFoodId");
		}
		
		try{
			quantity = Integer.parseInt(quantityt);
		}catch(Exception e){
			response.sendRedirect("CA2/Cart.jsp?errCode=invalid");
		}
		
		ArrayList<Food> foodlist = (ArrayList<Food>)session.getAttribute("allFood");
		//out.println("foodlist.size : " + foodlist.size());
		for(int i=0 ; i< foodlist.size() ; i++){
			Food food = foodlist.get(i);
			if(food.getFoodId() == foodId){
				if(food.getStock() >= quantity) { 
				Cart zero = new Cart(food.getFoodName(),food.getPictureURL(),food.getPictureURL(),food.getFoodId(),food.getStock(),quantity,food.getRetailPrice());
				cartlist.add(zero);
				// Create session attributes
				session.setAttribute("cartlist",cartlist);
				if(page.equals("product")) {
					int category = (int)session.getAttribute("catid");
					response.sendRedirect("LoadFood?catid=" + category + "&&page=true");
				}else {
					response.sendRedirect("CA2/Product-Listing.jsp?foodid=" + foodId);
				}
				}else {
					response.sendRedirect("CA2/Cart.jsp?errCode=invalidStock");
				}
			}
		}
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
