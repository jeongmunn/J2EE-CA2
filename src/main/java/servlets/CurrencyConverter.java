package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;



/**
 * Servlet implementation class CurrencyConverter
 */
@WebServlet("/CurrencyConverter")
public class CurrencyConverter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CurrencyConverter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		try {
			HttpSession session = request.getSession(true);
			String currency = request.getParameter("currency");
			System.out.println(currency);
			HttpRequest requesta = HttpRequest.newBuilder()
					.uri(URI.create("https://api.exchangerate-api.com/v4/latest/sgd"))
					.method("GET", HttpRequest.BodyPublishers.noBody()).build();
			System.out.println("Request WEB API");
			HttpResponse<String>responsea = HttpClient.newHttpClient().send(requesta,
					HttpResponse.BodyHandlers.ofString());
			System.out.println("Request response is a success");
			JSONObject obj = new JSONObject(responsea.body());
			JSONObject objectRates = new JSONObject(obj.get("rates").toString());
			
			double currencyRate = ((BigDecimal) objectRates.get(currency)).doubleValue();
			
			double totalPrice = Double.parseDouble((String) session.getAttribute("totalPriceForCart"));
			double totalPriceConverted = Math.round(totalPrice * 100.0) / 100.0 * currencyRate;
			session.setAttribute("totalPriceConverted", totalPriceConverted);
			response.sendRedirect("CA2/Cart.jsp");
		} catch (Exception e) {
			System.out.println("Exception error:" + e);
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
