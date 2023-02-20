<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:import url="header.jsp">
	<c:param name="title" value="Đăng ký thành viên mới | Website Từ Thiện"></c:param>
</c:import>

<section class="h-100 gradient-form"
	style="background-image: url('${pageContext.request.contextPath}/assets/img/carousel-4.jpg');">
	<div class="row">
		<div class="col">
			<a href="signup.jsp" class="btn btn-outline-light btn-bg-left"><i
				class='bx bxs-left-arrow-square'></i> Đăng Ký</a>
		</div>
		<div class="col text-center">
			<a href="index.jsp" class="btn btn-outline-light btn-bg-center"><i
				class='bx bxs-home'></i> Trang chủ</a>
		</div>
		<div class="col text-right">
			<a href="login.jsp" class="btn btn-outline-light btn-bg-right">Đăng
				Nhập <i class='bx bxs-right-arrow-square'></i>
			</a>
		</div>
	</div>
	<div class="container py-5 h-100">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-10">
				<div class="card rounded-3 text-black" style="background-image: url('${pageContext.request.contextPath}/media/background.jpg');">
					<div class="row g-0" style="display: block;">
						<div class="text-center" style="width: 100%;">
							<img src="media/logo.jpg" style="width: 185px;" alt="logo">
							<h4 class="mt-1 mb-5 pb-1" style="color: orangered;">Quỹ Từ
								Thiện Liên Hoa</h4>
						</div>
						<form action="UsersController?action=register" method="post">
							<div class="row">
								<div class="col-md-6">
									<div class="card-body p-md-5 mx-md-4">
										<h6 style="color: blue;">ĐĂNG KÝ THÀNH VIÊN MỚI</h6>
										<div class="form-outline my-3">
											<label for="name">Họ và tên: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-user"></i></span>
												<input type="text" id="name" name="name"
													class="form-control" placeholder="Xin Nhập họ và tên">
											</div>
											<p id="name_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline my-3">
											<label for="phone">Số điện thoại: <span
												class="require" style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-phone"></i></span>
												<input type="text" id="phone" name="phone"
													class="form-control" placeholder="Xin Nhập số điện thoại">
											</div>
											<p id="phone_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline my-3">
											<label for="email">Email: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-envelope"></i></span> <input type="email" id="email"
													name="email" class="form-control"
													placeholder="Xin Nhập email">
											</div>
											<p id="email_error" style="color: red; position: inherit;"></p>
										</div>
										<p>
											<span class="require" style='color: red;'>(*) Bắt buộc</span>
										</p>
									</div>

								</div>
								<div class="col-md-6">
									<div class="card-body p-md-5 mx-md-4">
										<p style="height: 24px;" />
										<div class="form-outline my-3">
											<label for="address">Địa chỉ:</label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-map"></i></span>
												<input type="text" id="address" name="address"
													class="form-control" placeholder="Xin Nhập địa chỉ">
											</div>
											<p id="address_error" style="color: red; position: inherit;"></p>
										</div>
										<div class="form-outline my-3">
											<label for="password">Mật khẩu: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-lock"></i></span>
												<input type="password" id="password" name="password"
													class="form-control" placeholder="Xin Nhập mật khẩu"><span
													class="input-group-text bx click-eye bx-hide"></span>
											</div>
											<p id="password_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline my-3">
											<label for="retype_password">Xin Nhập lại mật khẩu: <span
												class="require" style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-lock-alt"></i></span> <input type="password"
													id="retype_password" name="retype_password"
													class="form-control" placeholder="Xin Nhập lại mật khẩu">
												<span class="input-group-text bx click-eye bx-hide"></span>

											</div>
											<p id="retype_password_error"
												style="color: red; position: inherit;"></p>											
										</div>																				
									</div>
								</div>
							</div>
							<div class="row justify-content-center mt-4" style="margin-top: 0.5rem!mportant;">
								<div class="col-lg-6">
									<input type="radio" id="agree" name="agree" value="yes"
										onclick="enableButton()"/> <label for="agree">Tôi
										đã đọc và đồng ý với các quy định của trang web</label>
								</div>
							</div>
							<div class="row justify-content-center mt-4" style="margin-top: 1rem!important;">
								<div class="col-lg-6 text-center">
									<button class="btn btn-primary fa-lg gradient-custom-2 mb-3"
										type="submit" id="submit-button" onclick="return validateSignup()"disabled>Đăng ký</button>
								</div>								
							</div>
							<span class="text-center" style="display: flow-root; padding-bottom: 2%;">Bạn đã có tài khoản? Xin Đăng Nhập!</span>
						</form>									
					</div>					
				</div>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>