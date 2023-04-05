<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Lịch sử quyên góp | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

<div class="hero-wrap"
	style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');"
	data-stellar-background-ratio="0.5">
	<div class="overlay"></div>
	<div class="container">
		<div
			class="row no-gutters slider-text align-items-center justify-content-center"
			data-scrollax-parent="true">
			<div class="col-md-7 ftco-animate text-center"
				data-scrollax=" properties: { translateY: '70%' }">
				<p class="breadcrumbs"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">
					<span class="mr-2"><a
						href="${pageContext.request.contextPath}/UsersController?action=user">Trang
							Chủ</a></span> <span>Lịch sử quyên góp</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Lịch
					sử quyên góp</h1>
			</div>
		</div>
	</div>
</div>

<section class="ftco-section ftco-degree-bg">
	<div class="container-fluid" id="donationPost">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>STT</th>
					<th>Tên đợt quyên góp</th>
					<th>Số tiền</th>
					<th>Trạng thái</th>
					<th>Ngày quyên góp</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="userDonation" items="${donationHistory}"
					varStatus="loop">
					<input type="hidden" value='${donation.donationId}' name="donationId">
					<tr>						
						<td>${loop.index + 1}</td>
						<td><a href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&donationId=${userDonation.donationId}">${userDonation.donationTitle}</a></td>
						<td><fmt:formatNumber type="number" pattern="0,000"
													value="${userDonation.donationAmount}" /></td>
						<c:if test="${userDonation.userDonationStatus == 1}">
							<td><h6 class="badge badge-sm bg-gradient-warning">Từ chối </h6></td>
						</c:if>
						<c:if test="${userDonation.userDonationStatus == 2}">
							<td><h6 class="badge badge-sm bg-gradient-secondary">Đang chờ </h6></td>
						</c:if>
						<c:if test="${userDonation.userDonationStatus == 3}">
							<td><h6 class="badge badge-sm bg-gradient-success">Xác thực</td>
						</c:if>
						<td>${userDonation.donationDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>
</section>
<!-- .section -->

<c:import url="footer.jsp"></c:import>