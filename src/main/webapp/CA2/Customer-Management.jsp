<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.User" import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Management</title>
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
String toDisplay = "inline-block" , isAdmin = "none", toLogout = "none" ;
if(role==null||role.isEmpty()){

}else{
	if(role.equals(admin)){
    	toDisplay = "none" ;
    	isAdmin = "inline-block" ;
    	toLogout = "inline-block" ;
	}else{
		toDisplay = "none" ;
		toLogout = "inline-block";
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
<%
String errCode = request.getParameter("errCode");
if(errCode != null || errCode == "invalidFoodId"){
	out.println("Error ! Please select again");
}else{
	//Declare those variables to be stored
	String userdata = request.getParameter("userlist");

	if(userdata != null || userdata == "true"){
		
	//Retrieve the ArrayList that you stored in session attribute food
	ArrayList<User> userlist = (ArrayList<User>)session.getAttribute("user");
	
%>
<h1 class="d-flex justify-content-center">User Management</h1>
<div class="d-flex align-items-center justify-content-center">
<a href="Add-User.jsp" class="btn btn-outline-danger" role="button">Add New User</a>
</div>
<h4 class="d-flex justify-content-center" style="margin-top:50px">Customer</h4>
	<div id="divForCart" class="d-flex align-items-center justify-content-center text-center">
	<div id="forTheCart" class="table-responsive">
		<table id="customer" class="table table-hover">
			<thead>
			<tr>
		  	<th scope="col">Username</th>
	      	<th scope="col">Email</th>
			<th scope="col">Phone Number</th>
			<th scope="col">Address</th>
			<th scope="col">Country</th>
			<th scope="col">City/State</th>
			<th scope="col">Postal/Zip Code</th>
	      	<th scope="col">Role</th>
	      	<th scope="col">Modify?</th>
	      	<th scope="col">Remove?</th>
	     	</tr>
			</thead>
			<tbody>
	<%
	for(int i=0 ; i< userlist.size() ; i++){
		User user = userlist.get(i);
		
		if(user.getRole().equals("customer")){
			//Display	
			out.println("<tr>");
			out.println("<td>" + user.getUsername() +"</td>");
			out.println("<td>" + user.getEmail() + "</td>");
			out.println("<td>" + user.getPhoneNumber() + "</td>");
			out.println("<td>" + user.getRoadName() + "<br>" + user.getFloorNumber() + "</td>");
			out.println("<td>" + user.getCountry() + "</td>");
			out.println("<td>" + user.getCityState() + "</td>");
			out.println("<td>" + user.getZip() + "</td>");
			out.println("<td>" + user.getRole() + "</td>");
			out.println("<td><a href=\"Edit-Profile-ViaAdmin.jsp?userid="+ user.getUserid() +"\" class=\"btn btn-outline-primary\" role=\"button\">Edit</a></td>");
			out.println("<td><a href=\"../DeleteUser?userid="+ user.getUserid() +"\" class=\"btn btn-outline-danger\" role=\"button\">Delete</a></td>");
			out.println("</tr>");
		}
	}
	%>
		</tbody>
		</table>
	</div>
	</div>
	
<h4 class="d-flex justify-content-center" style="margin-top:50px">Admin</h4>
	<div id="divForCart" class="d-flex align-items-center justify-content-center text-center">
	<div id="forTheCart" class="table-responsive">
		<table id="admin" class="table table-hover">
			<thead>
			<tr>
				<th scope="col">Username</th>
				<th scope="col">Email</th>
				<th scope="col">Phone Number</th>
				<th scope="col">Address</th>
				<th scope="col">Country</th>
			  	<th scope="col">City/State</th>
			  	<th scope="col">Postal/Zip Code</th>
				<th scope="col">Role</th>
				<th scope="col">Modify?</th>
				<th scope="col">Remove?</th>
	     	</tr>
			</thead>
			<tbody>

	<%
	for(int i=0 ; i< userlist.size() ; i++){
		User user = userlist.get(i);
		
		if(user.getRole().equals("admin")){
			//Display	
			out.println("<tr>");
			out.println("<td>" + user.getUsername() +"</td>");
			out.println("<td>" + user.getEmail() + "</td>");
			out.println("<td>" + user.getPhoneNumber() + "</td>");
			out.println("<td>" + user.getRoadName() + "<br>" + user.getFloorNumber() + "</td>");
			out.println("<td>" + user.getCountry() + "</td>");
			out.println("<td>" + user.getCityState() + "</td>");
			out.println("<td>" + user.getZip() + "</td>");
			out.println("<td>" + user.getRole() + "</td>");
			out.println("<td><a href=\"Edit-Profile-ViaAdmin.jsp?userid="+ user.getUserid() +"\" class=\"btn btn-outline-primary\" role=\"button\">Edit</a></td>");
			out.println("<td><a href=\"../DeleteUser?userid="+ user.getUserid() +"\" class=\"btn btn-outline-danger\" role=\"button\">Delete</a></td>");
			out.println("</tr>");
		}
	}
	%>
		</tbody>
		</table>
	</div>
	</div>
<%	
	}else{
		out.println("Error loading user");
	}
	}
	%>
<%@ include file = "Footer.html" %>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#customer').DataTable({
			"order" : [ [ 0, "asc" ] ]
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#admin').DataTable({
			"order" : [ [ 0, "asc" ] ]
		});
	});
</script>
</html>