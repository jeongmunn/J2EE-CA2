<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Category" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Categories</title>
</head>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style>
div.content {
	padding: 0 2em 0 2em
}

row {
	margin: 2em 2em 0 2em
}
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
	
			<h1 class="d-flex justify-content-center">PRODUCT CATEGORIES</h1>
			<div class="d-flex align-items-center justify-content-center">
				<div class="d-flex flex-column justify-content-center">
				<p id="productCategoriesDescription" class="d-flex">We have a wide range of food items from multiple categories, feel free to search for your favourite food item!</p>
				</div>
			</div>
		<div class="d-flex justify-content-center">
			<div class="d-flex flex-column justify-content-center">
			<%
				String errCode = request.getParameter("errCode");
			if (errCode != null || errCode == "invalid") {
				out.println("Nothing found.");
			} else {
				String isLoad = request.getParameter("catlist");

				if (isLoad != null || isLoad == "true") {

					//Retrieve the ArrayList that you stored in session attribute food
					ArrayList<Category> catlist = (ArrayList<Category>)session.getAttribute("category");

					for (int i = 0; i < catlist.size(); i++) {
						Category category = catlist.get(i);
					//Display
				
				
					out.println("<div class=\"card mb-3\" style=\"width: 30rem;\">");
					out.println("<img class=\"card-img-top\" src=\" " + category.getPictureURL() +" \" alt=\"Card image cap\"> ");
					out.println("<div class=\"card-body text-center\">");
					out.println("<h4 class=\"card-title\">" + category.getCatName() + "</h4>");
					out.println("<a href=\"../LoadFood?catid=" + category.getCatId()
						+ "\" class=\"btn btn-outline-danger\" role=\"button\">View</a>");
					out.println("</div>");
					out.println("</div>");
					}
				} else {
					out.println("Error loading category");
				}
			}
			%>
			</div>
		</div>
	<%@ include file="Footer.html"%>
</body>
</html>