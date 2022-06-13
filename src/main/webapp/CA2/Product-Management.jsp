<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Food" import="foods.Category" import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Management</title>
</head>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"></script>

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">

<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
<body>
<%
String role = "" ;

if(session.isNew()){
	role = null;
}else{
	role = (String)session.getAttribute("sessUserRole");	
}

String admin = "admin" , customer = "customer" ;
String toDisplay = "inline-block" , isAdmin = "none" , toLogout = "none" ;
if(role==null||role.isEmpty()){
	response.sendRedirect("Home.jsp");
}else{
	if(role.equals(admin)){
    	toDisplay = "none" ;
    	isAdmin = "inline-block" ;
    	toLogout = "inline-block" ;
	}else{
		response.sendRedirect("Home.jsp");
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
			<a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a> 
			<a class="nav-item nav-link active" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
</nav>
<h1 class="d-flex justify-content-center">Product Management</h1>
<div class="d-flex align-items-center justify-content-center">
<form action="../LoadFood" method="GET">
<label for="category">Choose Category : </label>
<select name="category" id="category">
<option value="all"></option>
<%
//Retrieve the ArrayList that you stored in session attribute food
ArrayList<Category> catlist = (ArrayList<Category>)session.getAttribute("category");

for(int i=0 ; i< catlist.size(); i++){
	Category category = catlist.get(i);
	//Display
	out.println("<option value=\"" + category.getCatId() + "\">" + category.getCatName() + "</option>");
}

%>
</select>
<input class="btn btn-outline-secondary" type="submit" value="Search">
<a href="Add-Product.jsp" class="btn btn-outline-danger" role="button">Add New Product</a>
</form>
</div>
<br>
	<div id="divForCart" class="d-flex align-items-center justify-content-center text-center">
<%
String errCode = request.getParameter("errCode");
if(errCode != null || errCode == "invalid"){
	out.println("No food found.");
}else{
	
	//Declare those variables to be stored
	String loadAll = request.getParameter("allfoodlist");
	String loadFoodByCategory = request.getParameter("foodlist");

	%>
	<div id="forTheCart" class="table-responsive">
	<table id="food" class="table table-hover">
	<thead>
		<tr>
		  <th scope="col">Image</th>
	      <th scope="col">Food Name</th>
	      <th scope="col">Retail Price</th>
	      <th scope="col">Cost Price</th>
	      <th scope="col">Stock</th>
	      <th scope="col">Sales</th>
	      <th scope="col">Modify?</th>
	      <th scope="col">Remove?</th>
	     </tr>
	</thead>
	<tbody>
	<%
	
	if(loadAll != null || loadAll == "true"){
		
	//Retrieve the ArrayList that you stored in session attribute allFood
	ArrayList<Food> foodlist = (ArrayList<Food>)session.getAttribute("allFood");
	for(int i=0 ; i< foodlist.size() ; i++){
		Food food = foodlist.get(i);
		//Display
		out.println("<tr>");
		out.println("<td><img id=\"imageDisplay\" class=\"rounded\" style=\"width:200px;height:200px\" src=\"" + food.getPictureURL() +"\" alt=\"Card image cap\"> </td>");
		out.println("<td>" + food.getFoodName() +"</td>");
		out.println("<td>" + food.getRetailPrice() + "</td>");
		out.println("<td>" + food.getCostPrice() + "</td>");
		out.println("<td>" + food.getStock() + "</td>");
		out.println("<td>" + food.getSales() + "</td>");
		out.println("<td><a href=\"Edit-Product.jsp?foodid="+ food.getFoodId() +"\" class=\"btn btn-outline-primary\" role=\"button\">Edit</a></td>");
		out.println("<td><a href=\"../DeleteFood?foodid="+ food.getFoodId() +"\" class=\"btn btn-outline-danger\" role=\"button\">Delete</a></td>");
		out.println("</tr>");
	}
	}else if(loadFoodByCategory != null || loadFoodByCategory == "true"){
		
		//Retrieve the ArrayList that you stored in session attribute food
		ArrayList<Food> foodlist = (ArrayList<Food>)session.getAttribute("food");
		for(int i=0 ; i< foodlist.size() ; i++){
			Food food = foodlist.get(i);
			//Display
			//Display
			out.println("<tr>");
			out.println("<td><img id=\"imageDisplay\" class=\"rounded\" style=\"width:200px;height:200px\" src=\"" + food.getPictureURL() +"\" alt=\"Card image cap\"> </td>");
			out.println("<td>" + food.getFoodName() +"</td>");
			out.println("<td>" + food.getRetailPrice() + "</td>");
			out.println("<td>" + food.getCostPrice() + "</td>");
			out.println("<td>" + food.getStock() + "</td>");
			out.println("<td>" + food.getSales() + "</td>");
			out.println("<td><a href=\"Edit-Product.jsp?foodid="+ food.getFoodId() +"\" class=\"btn btn-outline-primary\" role=\"button\">Edit</a></td>");
			out.println("<td><a href=\"../DeleteFood?foodid="+ food.getFoodId() +"\" class=\"btn btn-outline-danger\" role=\"button\">Delete</a></td>");
			out.println("</tr>");
		}
	}else{
		
	}
}
%>
</tbody>
</table>
</div>
</div>
<%@ include file = "Footer.html" %>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#food').DataTable({
			"order" : [ [ 0, "asc" ] ]
		});
	});
</script>
</html>