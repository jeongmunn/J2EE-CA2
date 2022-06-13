<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Member Login</title>
</head>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style> 
    body { margin:0; padding:0;}
    label { margin: 20px;}
    div > input { border-radius: 10px;}
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
		<a class="navbar-brand" href="#"> 
			<img id="logo" src="./img/hawkerlogo.png" />
		</a> 
		<!--Hamburger menu-->
      	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#TogglerNav" aria-controls="TogglerNav" aria-expand="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>
      	<div class="collapse navbar-collapse" id="TogglerNav">
			<a class="nav-item nav-link" href="Home.jsp">HOME</a> 
			<a class="nav-item nav-link" href="../LoadCategory">FOOD</a> 
			<a class="nav-item nav-link" href="Cart.jsp" style="display : <%out.println(toCart);%>">CART</a> 
			<a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a>
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a>  
			<a class="nav-item nav-link" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link active" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
	</nav>
	<h1 id="loginTitle" class="d-flex justify-content-center">LOGIN</h1>
	<div id="administratorControls" class="d-flex align-items-center justify-content-center">
		<form method="POST" action="../VerifyUser">  
		<%
		// Getting response from verifyUser 
		String errCode = request.getParameter("errCode");
		// Login failed if there is errCode
		if(errCode != null || errCode == "invalidLogin"){
			out.print("Login Failed. You have entered an invalid Username / Password!");
		}
		%>
			<div class="d-flex flex-column justify-content-center">
				<p><label for="username">USERNAME:</label><input type="text" class="form-control" name="username" required/></p></div>
				<p><label for="password">PASSWORD:</label><input type="password" class="form-control" name="password" required/></p>
				<div class="d-flex flex-column justify-content-center">
				<button type="submit" name="btnSubmit" class="btn btn-secondary" id="LoginButton">Login</button>
				</div>
		</form>
	</div>
</body>
<%@ include file = "Footer.html"%>
</html>
