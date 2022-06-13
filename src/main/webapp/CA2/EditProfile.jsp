<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Profile</title>
</head>
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style>
	    img.d-block { height: 30em; width: 88%}
	    div.section1 { margin: 1em 0 0 0 }
</style>
<body>
<%
String role = "" , name = "" , email = "" , password = "", phoneNumber ="", roadName = "", floorNumber = "", country = "", cityState = "";
int zip = 0;
if(session.isNew()){
	response.sendRedirect("Home.jsp");
}else{
	role = (String)session.getAttribute("sessUserRole");
	name = (String)session.getAttribute("sessUsername");
	email = (String)session.getAttribute("sessUserEmail");
	password = (String)session.getAttribute("sessUserPassword");	
	phoneNumber = (String)session.getAttribute("sessPhoneNumber");
	roadName = (String)session.getAttribute("sessRoadName");
	floorNumber = (String)session.getAttribute("sessFloorNumber");
	country = (String)session.getAttribute("sessCountry");
	cityState = (String)session.getAttribute("sessCityState");
	zip = (Integer)session.getAttribute("sessZip");
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
			<a class="nav-item nav-link active" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a> 
			<a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
			<a class="nav-item nav-link" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
</nav>
<h1 class="d-flex justify-content-center">EDIT PROFILE</h1>
<div class="d-flex align-items-center justify-content-center">
	<form method="POST" action="../EditProfile">  
	<%
		// Getting response from editProfile
		String errCode = request.getParameter("errCode");
		// Edit failed if there is errCode
		if(errCode != null || errCode == "invalidEdit"){
			out.print("Edit Profile Failed.You have entered an invalid input");
		}
	%>
		<br>
		<div class="form-group row">
			<label for="username" class="col-sm-2 col-form-label">USERNAME:</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" value="<%out.println(name);%>" name="username" required/>
			</div>
		</div>
		<div class="form-group row">
			<label for="email" class="col-sm-2 col-form-label">EMAIL:</label>
			<div class="col-sm-10">
				<input type="email" class="form-control" value="<%out.println(email);%>" name="email" required/>
			</div>
		</div>
		<div class="form-group row">
			<label for="password" class="col-sm-2 col-form-label">PASSWORD:</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" value="<%out.println(password);%>" name="password" required/>
			</div>
		</div>
		<div class="form-group row">
			<label for="phoneNumber" class="col-sm-2 col-form-label">PHONE NUMBER:</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" value="<%out.println(phoneNumber);%>" name="phoneNumber" required/>
			</div>
		</div>
		<br>
		<div class="form-group">
    		<label for="inputAddress">ADDRESS</label>
    		<input type="text" class="form-control" id="inputAddress" value="<%out.println(roadName);%>" name="roadName" placeholder="1234 Main St" required>
    		<br>
    		<input type="text" class="form-control" id="inputAddress2" value="<%out.println(floorNumber);%>" name="floorNumber" placeholder="Unit/Floor Number For Apartments/Buildings">
  		</div>
   		<div class="form-row">
    		<div class="col-7">
      			<input type="text" class="form-control" value="<%out.println(country);%>" name="country" placeholder="Country" required>
   			 </div>
    		<div class="col">
      			<input type="text" class="form-control" value="<%out.println(cityState);%>" name="city" placeholder="City/State" required>
   			 </div>
   			 <div class="col">
      			<input type="number" class="form-control" value="<%=zip%>" name="zip" placeholder="Zip/Postal Code" required>
   			 </div>
  		</div>
  		<br>
	<div class="d-flex flex-column justify-content-center">
		<button type="submit" name="btnSubmit" class="btn btn-secondary" id="EditButton">Edit</button>
	</div>
</form>
</div>
<%@ include file = "Footer.html"%>

</body>
</html>