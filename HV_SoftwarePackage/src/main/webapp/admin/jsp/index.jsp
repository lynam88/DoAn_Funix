<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Trang chủ Admin"></c:param>
</c:import>

<div class="container-fluid py-4">
	<div class="row">
		<div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
			<div class="card">
				<div class="card-body p-3">
					<div class="row">
						<div class="col-8">
							<div class="numbers statisticsText">
								<p class="text-sm mb-0 text-uppercase font-weight-bold ">Tổng
									Quyên Góp</p>
								<h5 class="font-weight-bolder">
									<fmt:formatNumber type="number" pattern="0,000"
										value="${statistics.totalDonationAmount}" />
									VNĐ
								</h5>
							</div>
						</div>
						<div class="col-4 text-end">
							<div
								class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
								<i class="ni ni-money-coins text-lg opacity-10"
									aria-hidden="true"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
			<div class="card">
				<div class="card-body p-3">
					<div class="row">
						<div class="col-8">
							<div class="numbers statisticsText">
								<p class="text-sm mb-0 text-uppercase font-weight-bold ">Tổng
									Người Dùng</p>
								<h5 class="font-weight-bolder">${statistics.totalUsers}</h5>
							</div>
						</div>
						<div class="col-4 text-end">
							<div
								class="icon icon-shape bg-gradient-danger shadow-danger text-center rounded-circle">
								<i class="ni ni-world text-lg opacity-10" aria-hidden="true"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
			<div class="card">
				<div class="card-body p-3">
					<div class="row">
						<div class="col-8">
							<div class="numbers statisticsText">
								<p class="text-sm mb-0 text-uppercase font-weight-bold ">Quyên
									Góp Hôm Nay</p>
								<h5 class="font-weight-bolder">
									<fmt:formatNumber type="number" pattern="0,000"
										value="${statistics.todayDonationAmount}" />
									VNĐ
								</h5>
							</div>
						</div>
						<div class="col-4 text-end">
							<div
								class="icon icon-shape bg-gradient-success shadow-success text-center rounded-circle">
								<i class="ni ni-paper-diploma text-lg opacity-10"
									aria-hidden="true"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6">
			<div class="card">
				<div class="card-body p-3">
					<div class="row">
						<div class="col-8">
							<div class="numbers statisticsText">
								<p class="text-sm mb-0 text-uppercase font-weight-bold ">Đợt
									quyên góp</p>
								<h5 class="font-weight-bolder">
									${statistics.totalDonations}</h5>
							</div>
						</div>
						<div class="col-4 text-end">
							<div
								class="icon icon-shape bg-gradient-warning shadow-warning text-center rounded-circle">
								<i class="ni ni-cart text-lg opacity-10" aria-hidden="true"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row mt-4">
		<div class="col-lg-7 mb-lg-0 mb-4">
			<div class="card z-index-2 h-100">
				<div class="card-header pb-0 pt-3 bg-transparent">
					<span>Tổng Quan Quyên Góp</span> <a
						href="${pageContext.request.contextPath}/DonationsController?action=DonationList">(xem
						thêm...)</a>
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Đợt
									quyên góp</th>
								<th
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thời
									gian</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="donation" items="${MostRecentDonations}">
								<tr>
									<td>
										<div class="d-flex flex-column justify-content-center">
											<h6 class="mb-0 text-sm">
												<c:out value="${donation.title}" />
											</h6>
										</div>
									</td>
									<td>
										<p class="text-xs font-weight-bold mb-0">
											<c:out value="${donation.startDate}" />
										</p>
										<p class="text-xs text-secondary mb-0">
											<c:out value="${donation.endDate}" />
										</p>
									</td>								
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
		</div>
		<div class="col-lg-5">
			<div class="card card-carousel overflow-hidden h-100 p-0">
				<div id="carouselExampleCaptions" class="carousel slide h-100"
					data-bs-ride="carousel">
					<div class="carousel-inner border-radius-lg h-100">
						<div class="carousel-item h-100 active"
							style="background-image: url('template/admin/assets/img/carousel-1.jpg'); background-size: cover;">
							<div
								class="carousel-caption d-none d-md-block bottom-0 text-start start-0 ms-5">
								<div
									class="icon icon-shape icon-sm bg-white text-center border-radius-md mb-3">
									<i class="ni ni-camera-compact text-dark opacity-10"></i>
								</div>
								<h5 class="text-white mb-1">Mọi thứ rồi sẽ qua đi</h5>
								<p>chỉ còn tình người là ở lại.</p>
							</div>
						</div>
						<div class="carousel-item h-100"
							style="background-image: url('template/admin/assets/img/carousel-2.jpg'); background-size: cover;">
							<div
								class="carousel-caption d-none d-md-block bottom-0 text-start start-0 ms-5">
								<div
									class="icon icon-shape icon-sm bg-white text-center border-radius-md mb-3">
									<i class="ni ni-bulb-61 text-dark opacity-10"></i>
								</div>
								<h5 class="text-white mb-1">Yêu thương mà chúng ta cho đi</h5>
								<p>là yêu thương mà chúng ta giữ được.</p>
							</div>
						</div>
						<div class="carousel-item h-100"
							style="background-image: url('template/admin/assets/img/carousel-3.jpg'); background-size: cover;">
							<div
								class="carousel-caption d-none d-md-block bottom-0 text-start start-0 ms-5">
								<div
									class="icon icon-shape icon-sm bg-white text-center border-radius-md mb-3">
									<i class="ni ni-trophy text-dark opacity-10"></i>
								</div>
								<h5 class="text-white mb-1">Bạn sẽ tìm thấy niềm vui</h5>
								<p>khi giúp đỡ người khác bằng tất cả tấm lòng.</p>
							</div>
						</div>
					</div>
					<button class="carousel-control-prev w-5 me-3" type="button"
						data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next w-5 me-3" type="button"
						data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row mt-4">
		<div class="col-lg-7 mb-lg-0 mb-4">
			<div class="card ">
				<div class="card-header pb-0 p-3">
					<div class="d-flex justify-content-between">
						<h6 class="mb-2">
							Lịch Sử Quyên Góp <a
								href="${pageContext.request.contextPath}/UsersDonationController?action=UsersDonationList">(xem
								thêm...)</a>
						</h6>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table align-items-center ">
						<tbody>
							<c:forEach var="user" items="${MostDonationUsers}">
								<tr>
									<td class="w-30">
										<div class="d-flex px-2 py-1 align-items-center">
											<div class="ms-4">
												<p class="text-xs font-weight-bold mb-0">Email:</p>
												<h6 class="text-sm mb-0">
													<c:out value="${user.email}" />
												</h6>
											</div>
										</div>
									</td>
									<td>
										<div class="text-center">
											<p class="text-xs font-weight-bold mb-0">Số tiền(VNĐ):</p>
											<h6 class="text-sm mb-0">
												<fmt:formatNumber type="number" pattern="0,000"
													value="${user.donationAmount}" />
											</h6>
										</div>
									</td>
									<td>
										<div class="text-center">
											<p class="text-xs font-weight-bold mb-0">Trạng thái:</p>
											<c:if test="${user.userDonationStatus == 1}">
												<h6 class="badge badge-sm bg-gradient-warning">Từ chối</h6>
											</c:if>
											<c:if test="${user.userDonationStatus == 2}">
												<h6 class="badge badge-sm bg-gradient-secondary">Đang
													chờ</h6>
											</c:if>
											<c:if test="${user.userDonationStatus == 3}">
												<h6 class="badge badge-sm bg-gradient-success">Xác thực</h6>
											</c:if>
										</div>
									</td>
									<td class="align-middle text-sm">
										<div class="col text-center">
											<p class="text-xs font-weight-bold mb-0">Ngày quyên góp:</p>
											<h6 class="text-sm mb-0">
												<c:out value="${user.donationDate}" />
											</h6>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-lg-5">
			<div class="card">
				<div class="card-header pb-0 p-3">
					<h6 class="mb-0">
						Hạng Mục Quyên Góp <a
							href="${pageContext.request.contextPath}/UsersDonationController?action=UsersDonationList">(xem
							thêm...)</a>
					</h6>
				</div>
				<div class="card-body p-3">
					<ul class="list-group">
						<c:forEach var="donation" items="${Category}">
							<li
								class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
								<div class="d-flex align-items-center">
									<div
										class="icon icon-shape icon-sm me-3 bg-gradient-dark shadow text-center">
										<i class="ni ni-mobile-button text-white opacity-10"></i>
									</div>
									<div class="d-flex flex-column">
										<h6 class="mb-1 text-dark text-sm">
											<c:if test="${donation.category == 1}">Vì trẻ em</c:if>
											<c:if test="${donation.category == 2}">Người Già, Người Khuyết Tật</c:if>
											<c:if test="${donation.category == 3}">Bệnh Hiểm Nghèo</c:if>
											<c:if test="${donation.category == 4}">Đầu Tư Cơ Sở Vật Chất</c:if>
											<c:if test="${donation.category == 5}">Bảo Vệ Môi Trường</c:if>
										</h6>
										<span class="text-xs"><c:out value="${donation.posts}" /> bài
											viết</span>
									</div>
								</div>
								<div class="d-flex">
									<button
										class="btn btn-link btn-icon-only btn-rounded btn-sm text-dark icon-move-right my-auto">
										<a href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=${donation.category}"><i class="ni ni-bold-right" aria-hidden="true"></i></a>										
									</button>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<c:import url="footer.jsp"></c:import>