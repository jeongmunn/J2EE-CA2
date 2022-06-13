<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="foods.Food" import="foods.Category" import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator</title>
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
String toDisplay = "inline-block" , isAdmin = "none" , toLogout = "none", toCart = "none", toOrderHistory = "none";
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
            <a class="nav-item nav-link" href="Cart.jsp" style="display : <%out.println(toCart);%>">CART</a> 
            <a class="nav-item nav-link" href="Profile.jsp" style="display : <%out.println(toLogout);%>">PROFILE</a> 
            <a class="nav-item nav-link" href="purchaseHistory.jsp" style="display : <%out.println(toOrderHistory);%>">PURCHASE HISTORY</a> 
            <a class="nav-item nav-link active" href="Administrator.jsp" style="display : <%out.println(isAdmin);%>">ADMIN</a> 
            <a class="nav-item nav-link" href="Login.jsp" style="display : <%out.println(toDisplay);%>">LOGIN</a> 
            <a class="nav-item nav-link" href="MemberRegister.jsp" style="display : <%out.println(toDisplay);%>">REGISTER</a> 
            <a class="nav-item nav-link" href="Logout.jsp" style="display : <%out.println(toLogout);%>">LOGOUT</a>
        </div>
</nav>
<h1 class="d-flex justify-content-center">ADMINISTRATOR</h1>
<div class="d-flex align-items-center justify-content-center">
    <div class="card mb-3" style="height: 35rem; width: 25rem; margin:2rem">
    <img class="card-img-top" src="https://img.icons8.com/bubbles/10x/product.png" alt="Card image cap">
    <div class="card-body text-center">
    <h4 class="card-title">Product Management</h4>
    <a href="../LoadAllFood" class="btn btn-outline-danger" role="button">View</a> 
    </div>
    </div>
        <div class="card mb-3" style="height: 35rem; width: 25rem; margin:2rem">
    <img class="card-img-top" src="https://img.icons8.com/bubbles/500/000000/gender-neutral-user.png" alt="Card image cap">
    <div class="card-body text-center">
    <h4 class="card-title">Customer Management</h4>
    <a href="../LoadUser" class="btn btn-outline-danger" role="button">View</a> 
    </div>
    </div>
    <div class="card mb-3" style="height: 35rem; width: 25rem; margin:2rem">
    <img class="card-img-top" src="https://img.icons8.com/bubbles/500/000000/purchase-order.png" alt="Card image cap">
    <div class="card-body text-center">
    <h4 class="card-title">Order Management</h4>
    <a href="../LoadAllOrder" class="btn btn-outline-danger" role="button">View</a> 
    </div>
    </div>
</div>
<%@ include file = "Footer.html" %>

</body>
</html>