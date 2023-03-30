<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Hoàn cảnh quyên góp | Quỹ Từ Thiện Liên Hoa"></c:param>
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
							Chủ</a></span> <span>Hoàn cảnh quyên góp</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Hoàn
					cảnh quyên góp</h1>
			</div>
		</div>
	</div>
</div>

<section class="ftco-section">
	<div class="container">
		<div class="row">
			<c:forEach var="donation" items="${DonationList}">
				<div class="col-md-4 ftco-animate">
					<div class="cause-entry">
						<a
							href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&id=${donation.id}"
							class="img donationThumbnail"
							style="background-image: url(${donation.src});"></a>
						<div class="text p-3 p-md-4">
							<h4>
								<a
									href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&id=${donation.id}">
									${donation.title} </a>
							</h4>
							<span class="donation-time mb-3 d-block"> Quyên góp mới
								nhất cách đây 0 ngày </span>
							<div class="progress custom-progress-success">
								<div class="progress-bar bg-primary" role="progressbar"
									style="width: 50%" aria-valuenow="50" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
							<fmt:formatNumber type="number" pattern="#,##0"
								value="${donation.totalNeeded}" var="myNum" />
							<div>
								<span class="fund-raised d-block float-left leftText"> Đã
									quyên góp được 0 trên tổng số tiền <c:out value="${myNum}"></c:out>
									VNĐ
								</span>
								<c:if test="${donation.status == 1}">
									<a
										href="${pageContext.request.contextPath}/UsersDonationController?action=donations"
										class="btn btn-success float-right" role="button"
										aria-pressed="true">Đã hoàn thành</a>
								</c:if>
								<c:if test="${donation.status == 2}">
									<a type="button" class="btn btn-primary float-right"
										href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&id=${donation.id}">Quyên
										góp</a>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="row mt-5">
			<div class="col text-center">
				<div class="block-27">
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/UsersDonationController?action=donations&page=1"
							tabindex="-1">&lt;</a></li>
						<c:forEach var="i" begin="1" end="${noOfPage}">
							<c:choose>
								<c:when test="${currentPage eq i}">
									<li class="active"><a> ${i}</a></li>
								</c:when>
								<c:otherwise>
									<li><a type="button"
										href="${pageContext.request.contextPath}/UsersDonationController?action=donations&page=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<li><a
							href="${pageContext.request.contextPath}/UsersDonationController?action=donations&page=${noOfPage}">&gt;</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="ftco-section-3 img"
	style="background-image: url(${pageContext.request.contextPath}/template/user/images/bg_3.jpg);">
	<div class="overlay"></div>
	<div class="container">
		<div class="row d-md-flex">
			<div class="col-md-6 d-flex ftco-animate">
				<div class="img img-2 align-self-stretch"
					style="background-image: url('${pageContext.request.contextPath}/template/user/images/bg_4.jpg');"></div>
			</div>
			<div class="col-md-6 volunteer pl-md-5 ftco-animate">
				<h3 class="mb-3">Be a volunteer</h3>
				<form action="#" class="volunter-form">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Your Name">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Your Email">
					</div>
					<div class="form-group">
						<textarea name="" id="" cols="30" rows="3" class="form-control"
							placeholder="Message"></textarea>
					</div>
					<div class="form-group">
						<input type="submit" value="Send Message"
							class="btn btn-white py-3 px-5">
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>