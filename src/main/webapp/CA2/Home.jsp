<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style>
img.d-block {
	height: relative;
	width: 80%
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
			<a class="navbar-brand" href="#"> 
			<img id="logo" src="./img/hawkerlogo.png" />
			</a> 
			<!--Hamburger menu-->
      		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#TogglerNav" aria-controls="TogglerNav" aria-expand="false" aria-label="Toggle navigation">
        		<span class="navbar-toggler-icon"></span>
      		</button>
      		<div class="collapse navbar-collapse" id="TogglerNav">
			<a class="nav-item nav-link active" href="Home.jsp">HOME</a> 
			<a class="nav-item nav-link" href="../LoadCategory">FOOD</a> 
			<a class="nav-item nav-link" href="Cart.jsp" style="display : <%out.println(toCart);%>">CART</a> 
			<a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a>
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
			<a class="nav-item nav-link" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
			</div>
		</nav>
	<div id="carouselExampleControls"
		class="carousel slide align-self-center data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img class="rounded mx-auto d-block" src="./img/carousel1.png"
					alt="First slide">
			</div>
			<div class="carousel-item">
				<img class="rounded mx-auto d-block"
					src="./img/carousel2.png"
					alt="Second slide">
			</div>
			<div class="carousel-item">
				<img class="rounded mx-auto d-block"
					src="./img/carousel3.png"
					alt="Third slide" />
			</div>
		</div>

		<a class="carousel-control-prev" href="#carouselExampleControls"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleControls"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<%@ include file="Footer.html"%>
</body>
</html>