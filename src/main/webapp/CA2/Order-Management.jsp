<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Order" import="foods.SumOfOrder" import="java.util.ArrayList"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Management</title>

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
String toDisplay = "inline-block" , isAdmin = "none" , toLogout = "none", toOrderHistory = "none";
if(role==null||role.isEmpty()){
	response.sendRedirect("Home.jsp");
}else{
	if(role.equals(admin)){
    	toDisplay = "none" ;
    	toOrderHistory = "inline-block";
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
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
			<a class="nav-item nav-link active" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
</nav>
<h1 class="d-flex justify-content-center">Order Management</h1>
<div class="d-flex align-items-center justify-content-center">
<a href="../LoadAllOrder" class="btn btn-outline-warning" role="button" style="margin:1em">All Orders</a>
<a href="../LoadUser?page=order" class="btn btn-outline-warning" role="button" style="margin:1em">Top 10 Customers</a>
</div>
<br>
<div class="d-flex justify-content-center">
	<div id="divForCart" class="d-flex flex-column justify-content-center text-center">
<%
String errCode = request.getParameter("errCode");
if(errCode != null || errCode == "invalid"){
	out.println("No order found.");
}else{
	
	//Declare those variables to be stored
	String loadAll = "" ;
	try{
		loadAll = request.getParameter("orderlist");
	}catch(Exception e){
		out.println("error : " + e);
	}
	String loadUserByPurchase = request.getParameter("customerlist");
	String loadUserByFood = request.getParameter("foodlist");
	
	if(loadAll != null && loadAll.equals("true")){
	
	%>
		<div id="forTheCart" class="table-responsive">
		<table id="order" class="table table-hover">
		<thead>
			<tr>
			  <th scope="col">Order ID</th>
		      <th scope="col">Customer</th>
		      <th scope="col">Purchase Amount</th>
		      <th scope="col">Date and Time</th>
		      <th scope="col">Details</th>
		     </tr>
		</thead>
		<tbody>
	<%
	
	//Retrieve the ArrayList that you stored in session attribute allFood
	ArrayList<Order> orderlist = (ArrayList<Order>)session.getAttribute("allOrder");
	for(int i=0 ; i< orderlist.size() ; i++){
		Order order = orderlist.get(i);
		//Display
		out.println("<tr>");
		out.println("<td>" + order.getOrderId() +"</td>");
		out.println("<td>" + order.getUsername() + "</td>");
		out.println("<td>" + order.getTotalPrice() + "</td>");
		out.println("<td>" + order.getDate() + "</td>");
		out.println("<td><a href=\"../LoadOrder?orderid="+ order.getOrderId() +"\" class=\"btn btn-outline-primary\" role=\"button\">View</a></td>");
		out.println("</tr>");
	}
	%>
	</tbody>
	</table>
	</div>
	<%
	}else if(loadUserByPurchase != null || loadUserByPurchase.equals("true")){
		
		%>
		<div id="forTheCart" class="table-responsive">
		<table id="orders" class="table table-hover">
		<thead>
			<tr>
			  <th scope="col">Customer</th>
		      <th scope="col">Total Purchase Amount</th>
		      <th scope="col">Number of Orders</th>
		      <!--<th scope="col">Details</th>-->
		     </tr>
		</thead>
		<tbody>
		<%
		
		//Retrieve the ArrayList that you stored in session attribute food
		ArrayList<SumOfOrder> userlist = (ArrayList<SumOfOrder>)session.getAttribute("customer");
		int index = 1;
		for(int i=0 ; i< userlist.size() ; i++){
			SumOfOrder user = userlist.get(i);
			//Display
			out.println("<tr>");
			out.println("<td>" + user.getUsername() + "</td>");
			out.println("<td>" + user.getSumOfOrderAmount() + "</td>");
			out.println("<td>" + user.getCountOfOrder() + "</td>");
			//out.println("<td><a href=\"../LoadOrders?userid="+ user.getUserId() +"\" class=\"btn btn-outline-primary\" role=\"button\">View</a></td>");
			out.println("</tr>");
		}
		%>
		</tbody>
		</table>
		</div>
		<%

	}else{
		out.println("Error");
	}
}
%>
</div>
</div>
<%@ include file = "Footer.html" %>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#order').DataTable({
			"order" : [ [ 0, "asc" ] ]
		});
		$('#orders').DataTable({
			"order" : [ [ 0, "desc" ] ]
		});
	});
</script>
</html>