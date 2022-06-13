<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Food" import="foods.Category" import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit-Product</title>
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
			<a class="nav-item nav-link" href="Cart.jsp" style="display : <%out.println(toCart);%>">CART</a>  
			<a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a> 
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
			<a class="nav-item nav-link active" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
</nav>
<%
	//Declare those variables to be stored
	String foodIdt = request.getParameter("foodid");
	String foodName="", briefDesc="", category="", pictureURL="", detailDesc="" ;
	double retailPrice=0.0 , costPrice=0.0 ;
	int foodId = 0 , stock=0 ;
	
	// Getting response from editFood
	String errCode = request.getParameter("errCode");
	// Update failed if there is errCode
	if(errCode != null || errCode == "invalid"){
		out.print("<div class=\"d-flex justify-content-center\">Update Product Failed.Please try again.</div>");
	}else{
		try{
			foodId = Integer.parseInt(foodIdt);
		}catch(Exception e){
			out.println("Invalid foodid");
			response.sendRedirect("Product.jsp?errCode=invalidFoodId");
		}
		
	//Retrieve the ArrayList that you stored in session attribute food
	ArrayList<Food> foodlist = (ArrayList<Food>)session.getAttribute("allFood");
	
	for(int i=0 ; i< foodlist.size() ; i++){
		Food food = foodlist.get(i);
		if(food.getFoodId() == foodId){
			// store data
			foodName = food.getFoodName();
			briefDesc = food.getBriefDesc();
			retailPrice = food.getRetailPrice();
			costPrice = food.getCostPrice();
			stock = food.getStock();
			category = food.getCategory();
			pictureURL = food.getPictureURL();
			detailDesc = food.getDetailDesc();
		}
	}

%>
<h1 class="d-flex justify-content-center">EDIT FOOD</h1>
<div class="d-flex justify-content-center">
	<div class="d-flex flex-column justify-content-center">
<form method="POST" enctype="multipart/form-data" action="../EditFood?foodid=<%out.println(foodId);%>">
	<p><label for="foodname">Food Name :</label><input type="text" name="foodname" value="<%out.println(foodName);%>" class="form-control" required/></p>
	<p><label for="briefdes">Brief Description :</label><textarea name="briefdes" class="form-control"><%=briefDesc%></textarea></p>
	<p><label for="retailprice">Retail Price :</label><input type="text" name="retailprice" class="form-control" value="<%out.println(retailPrice);%>" required/></p>
	<p><label for="costprice">Cost Price :</label><input type="text" name="costprice" class="form-control" value="<%out.println(costPrice);%>" required/></p>
	<p><label for="stock">Stock :</label><input type="number" name="stock" class="form-control" value="<%=stock%>" required/></p>
	<p><label for="detaildes">Detail Description :</label><textarea name="detaildes" class="form-control"><%=detailDesc%></textarea></p>
	<p><label for="category">Choose Category : </label>
	<select name="category" id="category">
	<option value="value" selected></option>
	<%
	//Retrieve the ArrayList that you stored in session attribute food
	ArrayList<Category> catlist = (ArrayList<Category>)session.getAttribute("category");
 	for(int i=0 ; i< catlist.size() ; i++){
	Category categoryOption = catlist.get(i);
	//Display
	out.println("<option value=\"" + categoryOption.getCatId() + "\">" + categoryOption.getCatName() + "</option>");
	}
	%>
	</select></p>
	<p>Current image :</p><img src="<%out.println(pictureURL);%>" style="width:230px; height:180px"> 
	<p><label for="pictureURL">Picture URL :</label><input type="file" class="form-control-file" name="pictureURL"/></p>
	<div class="row justify-content-center">
	<input type="submit" name="btnSubmit" class="btn btn-outline-danger" value="Edit"/>
	</div>
</form>
</div>
</div>
<% } %>
</body>
</html>