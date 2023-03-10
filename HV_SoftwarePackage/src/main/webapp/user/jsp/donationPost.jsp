<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="${donation.title} | Quỹ Từ Thiện Liên Hoa"></c:param>
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
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Chi
					tiết đợt quyên góp</h1>
			</div>
		</div>
	</div>
</div>


<section class="ftco-section ftco-degree-bg">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<p class="text-left">
					<fmt:formatDate pattern="dd/MM/yyyy" value="${donation.insertDate}" />
				</p>
			</div>
		</div>
		<div class="row donationPost">
			<div class="col-xl-7 ftco-animate">
				<h2 class="mb-3 text-primary">${donation.title}</h2>
				${donation.content}
			</div>

			<div class="col-xl-5 sidebar ftco-animate">
				<div class="sidebar-box donationInfo">
					<div class="item">
						<div class="cause-entry">
							<div class="text p-3 p-md-4">
								<div>
									<h2 class="text-primary">Thông tin quyên góp</h2>
									<c:if test="${donation.status == 1}">
										<p class="text-success font-weight-bold">Hoàn Thành</p>
									</c:if>
									<c:if test="${donation.status == 2}">
										<p class="text-success font-weight-bold">Chưa Hoàn Thành</p>
									</c:if>
								</div>
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
									<span class="fund-raised d-block float-left leftText">
										Đã quyên góp được 0 trên tổng số tiền <c:out value="${myNum}"></c:out>
										VNĐ
									</span>
									<c:if test="${donation.status == 1}">
										<a href="${pageContext.request.contextPath}/UsersController?action=donations" class="btn btn-info float-right"
											role="button" aria-pressed="true">Hoàn cảnh mới nhất</a>
									</c:if>
									<c:if test="${donation.status == 2}">
										<a href="#" class="btn btn-primary float-right"
											role="button" aria-pressed="true">Quyên góp</a>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
<!-- .section -->

<c:import url="footer.jsp"></c:import>