<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Food" import="foods.Cart"  import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart & Checkout</title>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://js.stripe.com/v3/"></script>
<script>
	//Set your publishable key: remember to change this to your live publishable key in production
	//See your keys here: https://dashboard.stripe.com/apikeys
	var stripe = Stripe('pk_test_51JKPZKJW2czgnqf8YZ4nLq0Aq16MEljkzJBPw5A9dE0K3yIfCT87k0fF8PaIzW6juEDQx2a53xG7YbngMkHdyzfW009DvsX0Gf');
	var elements = stripe.elements();
</script>
<style>
	    div.content { padding: 0 2em 0 2em}
	    row { margin: 2em 2em 0 2em}
</style>
<body>
<%

String role = "" , name = "" , email = "" , password = "" ;


if (session.isNew()) {
role = null;
} else {
role = (String) session.getAttribute("sessUserRole");
name = (String)session.getAttribute("sessUsername");
email = (String)session.getAttribute("sessUserEmail");
}

String admin = "admin", customer = "customer";
String toDisplay = "inline-block", isAdmin = "none", toCart = "none", toOrderHistory = "none", toLogout = "none";
if (role == null || role.isEmpty()) {

} else {
if (role.equals(admin)) {
	toDisplay = "none";
	isAdmin = "inline-block";
	toLogout = "inline-block";
} else {
	toDisplay = "none";
	toCart = "inline-block";
	toOrderHistory = "inline-block";
	toLogout = "inline-block";
}
}
%>
<nav class="navbar bg-light navbar-light navbar-expand-lg sticky-top">
		<a class="navbar-brand" href="#"> <img id="logo"
			src="./img/hawkerlogo.png" />
		</a>
		<!--Hamburger menu-->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#TogglerNav" aria-controls="TogglerNav"
			aria-expand="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="TogglerNav">
			<a class="nav-item nav-link" href="Home.jsp">HOME</a> 
			<a class="nav-item nav-link" href="../LoadCategory">FOOD</a> 
			<a class="nav-item nav-link active" href="Cart.jsp">CART</a> 
			<a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a> 
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
			<a class="nav-item nav-link" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
</nav>
<%
	// Getting response from AddToCart
	String errCode = request.getParameter("errCode");
	// failed if there is errCode
	if(errCode == null){
		
%>
<h1 class="d-flex justify-content-center">YOUR FOOD CART</h1>
<%
	ArrayList<Cart> cartlist = (ArrayList<Cart>)session.getAttribute("cartlist");
	double totalPrice = 0;
	if(cartlist == null || cartlist.size() == 0){
		out.println("<div id=\"divForCart\" class=\"d-flex justify-content-center text-center\">");
		out.println("<div id=\"forTheCart\">");
		out.println("<p>Hungry? Browse and add food to cart now !</p>");
		out.println("<a href=\"../LoadCategory\" class=\"btn btn-outline-danger\" role=\"button\">Browse</a>");
		out.println("</div>");
		out.println("</div>");
	}else{
%>
<div id="divForCart" class="d-flex align-items-center justify-content-center">
<div id="forTheCart" class="table-responsive">
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">Image</th>
      <th scope="col">Food Name</th>
      <th scope="col">Unit Price ($)</th>
      <th scope="col">Total Price ($)</th>
      <th scope="col">Quantity</th>
      <th scope="col">Remove?</th>
    </tr>
  </thead>
  <tbody>
  
<%
	for(int i = 0 ; i < cartlist.size(); i ++){
		Cart cart = cartlist.get(i);
			//Display
			out.println("<tr>");
			out.println("<td><img id=\"imageForCart\" class=\"rounded img-responsive\" src=\" " + cart.getPictureURL() +" \" alt=\"Card image cap\"> </td>");
			out.println("<td>" + cart.getFoodName() + "</td>");
			out.println("<td>"+ cart.getRetailPrice() + "</td>");
			out.println("<td>"+ String.format("%.2f", (cart.getRetailPrice() * cart.getQuantity())) + "</td>");
			out.println("<td><p><a href=\"../EditQuantity?foodid="+ cart.getFoodId() +"&&edit=minus\" class=\"btn btn-outline-primary\" role=\"button\" style=\"margin-right:0.5em\">-</a>Quantity : "+ cart.getQuantity() + " <a href=\"../EditQuantity?foodid="+ cart.getFoodId() +"&&edit=plus\" class=\"btn btn-outline-primary\" role=\"button\" style=\"margin-right:0.5em\">+</a></p></td>");
			out.println("<td><a href=\"../DeleteFromCart?foodid="+ cart.getFoodId() +"\" class=\"btn btn-outline-primary\" role=\"button\">Delete</a></td>");
			out.println("</tr>");
			totalPrice += (cart.getRetailPrice() * cart.getQuantity());
	}
	session.setAttribute("totalPriceForCart", String.valueOf(totalPrice));
	
%>
</tbody>
</table>
</div>
</div>



<div class="container">
	<div id="divForCheckout" class="row align-items-center justify-content-center">
		<div id="forTheCart">
		<%
			out.println("<p>Total Price excluding GST: $" + String.format("%.2f", totalPrice/107*100) + "</p>");
			out.println("<p>Total Price: $" + String.format("%.2f", totalPrice) + "</p>");
		%>
		<a href="../DeleteCart" class="btn btn-outline-warning" role="button" style="width:30em">Clear</a>
		</div>
	</div>
	<div id="divForCheckout" class="row align-items-center justify-content-center">
		<div id="forTheCart">
		<h5>Currency Converter</h5>
		<form action="../CurrencyConverter" method="POST">
			<%
				String currencyType = "SGD";
				double totalPriceCurrency = 0;
				System.out.println(currencyType);
			%>
			<%
			try {
				totalPriceCurrency = (double) session.getAttribute("totalPriceConverted");
			} catch (Exception e) {
			}
			%>
			<select name="currency" value=<%=currencyType%>>
				<option value="USD">USD</option>
				<option value="FJD">FJD</option>
			</select> 
			<input id="thisField" name="totalPrice" value=<%=totalPrice%>> <input type="submit" value="Convert">
		</form>
		<p style="padding-top: 10px; text-align: center;">Total Converted Currency amount : <%=String.format("%.2f", totalPriceCurrency)%></p>
		</div>
	</div>
	
	<div class="row align-items-center justify-content-center">
	<form action="../Payment" method="post" id="payment-form">
		<div class="flex-column">
			
			<label for="card-element"> Payment Details: </label>
			<div id="card-element" class="form-control">
				<!-- A Stripe Element will be inserted here. -->
			</div>

			<!-- Used to display Element errors. -->
			<div id="card-errors" role="alert"></div>
		</div>
		<br>
		<button class="btn btn-outline-warning" role="button" style="width:30em">Checkout</button>
	</form>
	</div>
</div>
<% 
	}
	}else if(errCode.equals("invalidFoodId")){
		out.print("<div class=\"d-flex justify-content-center\">Add to cart failed.Please try again.</div>");
	}else if(errCode.equals("invalidStock")){
		out.print("<div class=\"d-flex justify-content-center\">Add to cart failed.This product is currently out of stock.</div>");	
	}else if(errCode.equals("invalidFoodIdforDelete")){
		out.print("<div class=\"d-flex justify-content-center\">Delete from cart failed. Please try again.</div>");	
	}else if(errCode.equals("unsuccessfulPayment")){
		out.print("<div class=\"d-flex justify-content-center\">Unsuccessful Payment. Please try again.</div>");	
	}else{
		out.print("<div class=\"d-flex justify-content-center\">Some error while loading the cart ! Please try again.</div>");
	};%>
	
<script>
 		// Custom styling can be passed to options when creating an Element.
		var style = {
			base : {
				// Add your base input styles here. For example:
				fontSize : '16px',
				color : '#32325d',
			},
		};

		// Create an instance of the card Element.
		var card = elements.create('card', {
			style : style
		});

		// Add an instance of the card Element into the `card-element` <div>.
		card.mount('#card-element');

		// Create a token or display an error when the form is submitted.
		var form = document.getElementById('payment-form');
		form.addEventListener('submit', function(event) {
			event.preventDefault();

			stripe.createToken(card).then(function(result) {
				if (result.error) {
					// Inform the customer that there was an error.
					var errorElement = document.getElementById('card-errors');
					errorElement.textContent = result.error.message;
				} else {
					// Send the token to your server.
					stripeTokenHandler(result.token);
				}
			});
		});

		function stripeTokenHandler(token) {
			// Insert the token ID into the form so it gets submitted to the server
			var form = document.getElementById('payment-form');
			var hiddenInput = document.createElement('input');
			hiddenInput.setAttribute('type', 'hidden');
			hiddenInput.setAttribute('name', 'stripeToken');
			hiddenInput.setAttribute('value', token.id);
			form.appendChild(hiddenInput);

			// Submit the form
			form.submit();
		}
	</script>	
	
	
	
	<%@ include file="Footer.html"%>

</body>
</html>