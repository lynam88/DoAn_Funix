<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<div class="p-3 mb-2 bg-light">
	<div class="row">
		<c:forEach var="product" items="${productList}">
			<div class="col-xl-3 col-lg-4 col-md-6 col-12 border" style="margin: 2%;">
				<img class="text-center"style="width: 70%;" src="${product.src}" alt="${product.name}"
					onclick="location.href='./InformationProductController?id=${product.id}';">
				<p class="text-uppercase" style="margin-top: 20px;">${product.type}</p>
				<p class="font-weight-bold">${product.name}</p>
				<p class="font-weight-bold text-danger">$
					${product.price}</p>
			</div>
		</c:forEach>
	</div>

	<%--displaying Page numbers --%>
	<div class="row justify-content-center" style="margin-top: 20px;">
		<div class="text-center">
			<a class="page-link rounded-circle border-info"
				href="/PRJ321x_A3/HomeProductController?page=${currentPage-1}"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span> <span
				class="sr-only">Previous</span>
			</a>
		</div>
		<c:forEach var="i" begin="1" end="${noOfPage}">
			<div class="text-center">
				<c:choose>
					<c:when test="${currentPage eq i}">
						<button class="btn btn-outline-info rounded-circle" disabled>${i}</button>
					</c:when>
					<c:otherwise>
						<a class="btn btn-outline-info rounded-circle"
							href="/PRJ321x_A3/HomeProductController?page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:forEach>
		<div class="text-center">
			<a class="page-link rounded-circle border-info"
				href="/PRJ321x_A3/HomeProductController?page=${currentPage+1}"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
				class="sr-only">Next</span>
			</a>
		</div>

	</div>
</div>
