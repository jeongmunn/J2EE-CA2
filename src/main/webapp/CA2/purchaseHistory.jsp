<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Food" import="foods.	Order"
	import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order</title>
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
	String role = "";

	if (session.isNew()) {
		role = null;
	} else {
		role = (String) session.getAttribute("sessUserRole");
	}

	String admin = "admin", customer = "customer";
	String toDisplay = "inline-block", isAdmin = "none", toLogout = "none", toOrderHistory ="none", toCart = "none";
	if (role == null || role.isEmpty()) {
		response.sendRedirect("Home.jsp");
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
			<a class="nav-item nav-link active" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
			<a class="nav-item nav-link" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
			<a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
			<a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
			<a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
		</div>
	</nav>
	<h1 class="d-flex justify-content-center">Purchase History</h1>
	<div class="d-flex justify-content-center">
		<div id="divForCart"
			class="d-flex flex-column justify-content-center text-center">

			<div id="forTheCart" class="table-responsive">
				<table id="order" class="table table-hover">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">Total amount paid</th>
							<th scope="col">Retail Price</th>
							<th scope="col">Address</th>
							<th scope="col">Postal Code</th>
						</tr>
					</thead>
					<tbody>
						<%
						// Load JDBC Driver
						Class.forName("com.mysql.jdbc.Driver");

						// Define connection URL
						String connURL = "jdbc:mysql://localhost/hawkerfood?user=adminuser&password=password&serverTimezone=UTC";

						// Establish connection to URL
						Connection conn = DriverManager.getConnection(connURL);

						// Create Statement object
						Statement stmt = conn.createStatement();

						int hashCode = 1;
						String insertSQL = "SELECT * FROM hawkerfood.order_history as order_history, hawkerfood.user as user where order_history.user_id = ? and user.userid = order_history.user_id ORDER BY order_history.date DESC;";
						PreparedStatement pstmt = conn.prepareStatement(insertSQL);
						int sessUserId = (int) session.getAttribute("sessUserId");
						String roadName = (String) session.getAttribute("sessRoadName");
						pstmt.setInt(1, sessUserId);

						ResultSet rs = pstmt.executeQuery();
						boolean hasData = false;

						while (rs.next()) {
						%>
						<tr>
							<td><%=hashCode%></td>
							<td><%=String.format("%.2f", rs.getDouble("totalAmount"))%></td>
							<td><%=rs.getString("date")%></td>
							<td><%=roadName%></td>
							<td><%=rs.getString("zip")%>
						</tr>
						<%
						hashCode++;
						hasData = true;
						}
						%>
						<%
						if (!hasData) {
						%>
						<tr>
							<td colspan="5">You have bought nothing so far...</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="Footer.html"%>
</body>
<script type="text/javascript">
	
</script>
</html>