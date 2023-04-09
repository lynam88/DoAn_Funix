<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Thông tin người dùng | Quỹ Từ Thiện Liên Hoa"></c:param>
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
							Chủ</a></span> <span>Thông tin người dùng</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Thông
					tin người dùng</h1>
			</div>
		</div>
	</div>
</div>

<section class="ftco-section ftco-degree-bg">
	<div class="container">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-12">
				<div class="card rounded-3 text-black">
					<div class="row g-0">
						<div class="signUpTitle">
							<h3 class="text-center text-primary">THÔNG TIN NGƯỜI DÙNG</h3>
						</div>						
							<div class="row infoForm">
								<div class="col-md-6">
									<div class="card-body p-md-5">
										<div class="form-outline my-3">
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-user"></i></span>
												<span>Họ và tên: ${user.name}</span>
											</div>
										</div>

										<div class="form-outline my-3">
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-phone"></i></span>
												<span>Số điện thoại: ${user.phone}</span>
											</div>
										</div>

										<c:if test="${user.avatarPath != null }">
											<div class="form-outline my-3">
												<div class="input-group">
													<span class="input-group-text"><i
														class="bx bx-image"></i></span> <span>Ảnh đại diện:</span>
												</div>
												<img src="${user.avatarPath}" alt="Avatar"
													class="avatarInfo">
											</div>
										</c:if>
									</div>
								</div>

								<div class="col-md-6">
									<div class="card-body p-md-5">
										<div class="form-outline my-3">
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-envelope"></i></span> <span>Email:
													${user.email}</span>
											</div>
										</div>

										<div class="form-outline my-3">
											<div class="input-group rightInfo">
												<span class="input-group-text"><i class="bx bx-map"></i></span>
												<span>Địa chỉ: ${user.address}</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6 text-center">
									<a class="btn btn-primary fa-lg gradient-custom-2 mb-3" type="button"
										href="${pageContext.request.contextPath}/UsersController?action=showUpdateInfoForm" id="show-update-button">Cập nhật tài khoản</a>
								</div>
							</div>							
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>