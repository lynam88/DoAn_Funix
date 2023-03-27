<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Tạo Quyên Góp | Quỹ Từ Thiện Liên Hoa"></c:param>
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
							Chủ</a></span> <span>Quyên góp</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Quyên
					góp</h1>
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
						<div class="col-lg-6">
							<div class="card-body p-md-5 mx-md-4">
							<div class="signUpTitle">
								<h3 class="text-center text-primary" >THỰC HIỆN QUYÊN GÓP</h3>
							</div>
								<form action="#">
										<span class="require">(*) Bắt buộc</span>
										<div class="form-outline my-3">
										  <label for="name">Họ và tên: <span class="require">*</span></label>
										  <div class="input-group">
										    <span class="input-group-text"><i class="bx bx-user"></i></span>
										    <input type="text" id="name" name="name" class="form-control" placeholder="Xin nhập họ và tên" value="<c:out value='${inputUser.name}'/>">
										  </div>
										  <p id="name_error"></p>
										</div>
										
										<div class="form-outline my-3">
										  <label for="phone">Số điện thoại: <span class="require">*</span></label>
										  <div class="input-group">
										    <span class="input-group-text"><i class="bx bx-phone"></i></span>
										    <input type="text" id="phone" name="phone" class="form-control" placeholder="Xin nhập số điện thoại" value="<c:out value='${inputUser.phone}'/>">
										  </div>
										  <p id="phone_error">${phone_error}</p>
										  
										</div>										

										<div class="form-outline my-3">
											<label for="email">Email: <span class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-envelope"></i></span> <input type="email" id="email"
													name="email" class="form-control"
													placeholder="Xin nhập email"
													value="<c:out value='${inputUser.email}'/>">
											</div>
											<p id="email_error">${email_error}</p>											
										</div>
										<div class="form-outline my-3">
											<label for="amount">Số tiền bạn muốn quyên góp: <span class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class='bx bx-donate-heart'></i></span> <input type="text" id="amount"
													name="amount" class="form-control"
													placeholder="Xin nhập số tiền"
													value="<c:out value='${inputUser.amount}'/>">
											</div>
											<p id="email_error">${email_error}</p>											
										</div>										
									<div class="form-outline my-3">
									<label for="message">Gửi phản hồi: </label>
										<textarea name="" id="" cols="30" rows="7"
											class="form-control" placeholder="Nội dung tin nhắn"></textarea>
									</div>
									<div class="form-group">
										<input type="submit" value="Quyên góp"
											class="btn btn-primary py-3 px-5">
									</div>
								</form>
							</div>
						</div>

						<div
							class="col-lg-6 d-flex align-items-center gradient-custom-2 rightSide">
							<div class="text-white px-3 py-4 rightText">
								<h1 class="text-center mb-4">Cho đi là còn mãi</h1>
								<p class="text-center small mb-0">Một khi bạn cho đi, chính
									là lúc bạn được nhận lại.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>