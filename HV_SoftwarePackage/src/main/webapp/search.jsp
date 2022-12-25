<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Result</title>
<link rel="stylesheet" href="css/Assignment.css">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="row">
		<c:forEach var="product" items="${result}">
			<div class="col-xl-3 col-lg-4 col-md-6 col-12 border"
				style="margin: 2%;">
				<img class="text-center" style="width: 70%;" src="${product.src}"
					alt="${product.name}"
					onclick="location.href='./InformationProductController?id=${product.id}';">
				<p class="text-uppercase" style="margin-top: 20px;">${product.type}</p>
				<p class="font-weight-bold">${product.name}</p>
				<p class="font-weight-bold text-danger">$ ${product.price}</p>
			</div>
		</c:forEach>
		<div>
			<%
			ArrayList<String> pr = (ArrayList<String>) request.getAttribute("result");
			if (pr == null || pr.size() == 0) {
			%>
			<img class="container" id="imgNF" src="media/no-products.jpg">
			<% } %>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>