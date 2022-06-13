<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Food" import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product</title>
</head>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style>
	    div.content { padding: 0 2em 0 2em}
	    row { margin: 2em 2em 0 2em}
</style>
<body>
<%
String role = "";

if (session.isNew()) {
role = null;
} else {
role = (String) session.getAttribute("sessUserRole");
}

String admin = "admin", customer = "customer";
String toDisplay = "inline-block", isAdmin = "none", toCart = "none", toOrderHistory = "none", toLogout = "none", cartButton = "inline-block";
if (role == null || role.isEmpty()) {
	cartButton = "none";
} else {
if (role.equals(admin)) {
	toDisplay = "none";
	cartButton = "none";
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
			<a class="nav-item nav-link active" href="../LoadCategory">FOOD</a> 
			<a class="nav-item nav-link" href="Cart.jsp" style="display : <%out.println(toCart);%>">CART</a> 
			<a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a> 
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a>
			<a class="nav-item nav-link" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
</nav>
<%
String errCode = request.getParameter("errCode");
if(errCode != null || errCode == "invalidFoodId"){
	out.println("Error! Please select a food category again");
}else{
	//Declare those variables to be stored
	String category = request.getParameter("foodlist");

	if(category != null || category == "true"){
		
	//Retrieve the ArrayList that you stored in session attribute food
	ArrayList<Food> foodlist = (ArrayList<Food>)session.getAttribute("food");
	
%>
<h1 class="d-flex justify-content-center"><%out.println(foodlist.get(1).getCategory());%></h1>
<div class="d-flex justify-content-center">
	<div class="d-flex flex-column justify-content-center">
<!-- default is showing all food -->

	<%
	for(int i=0 ; i< foodlist.size() ; i++){
		Food food = foodlist.get(i);
		//Display	
		out.println("<div class=\"card mb-3\" style=\"width: 30rem;\">");
		out.println("<img class=\"card-img-top\" src=\" " + food.getPictureURL() +" \" alt=\"Card image cap\"> ");
		out.println("<div class=\"card-body text-center\">");
		out.println("<h4 class=\"card-title\">" + food.getFoodName() + "</h4>");
		out.println("<p>"+ food.getBriefDesc() + "</p>");
		out.println("<a href=\"Product-Listing.jsp?foodid="+ food.getFoodId() +"\" class=\"btn btn-outline-danger\" role=\"button\">View</a>  <a style=\"display : " + cartButton + " \" href=\"../LoadAllFood?foodid="+ food.getFoodId() +"&&page=product\" class=\"btn btn-outline-primary\" role=\"button\">Add to cart</a>");
		out.println("</div>");
		out.println("</div>");
	}
	// there is not foodlist in the parameter
	}else{
		out.println("<h1 style=\"text-align: center;\">Error</h1>");
	}
}
%>

</div>
</div>
<%@ include file = "Footer.html" %>
</body>
</html>