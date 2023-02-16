<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<title>Đăng ký thành viên mới | Website Từ Thiện</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/main.css">
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

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
	<section class="h-100 gradient-form" style="background-color: #eee;">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-xl-10">
					<div class="card rounded-3 text-black">
						<div class="row g-0">
							<div class="text-center" style="width: 100%;">
								<img
									src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp"
									style="width: 185px;" alt="logo">
								<h4 class="mt-1 mb-5 pb-1">Quỹ Từ Thiện Sen Vàng</h4>
							</div>
							<div class="col-lg-6">

								<div class="card-body p-md-5 mx-md-4">
									<p>ĐĂNG KÝ THÀNH VIÊN MỚI</p>
									<form action="UsersController?action=register" method="post"
										onsubmit="return validateRegistration()">

										<div class="form-outline mb-4">
											<label for="name">Họ và tên: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-user"></i></span>
												<input type="text" id="name" name="name"
													class="form-control" placeholder="Nhập họ và tên">
											</div>
											<p id="name_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline mb-4">
											<label for="phone">Số điện thoại: <span
												class="require" style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-phone"></i></span>
												<input type="text" id="phone" name="phone"
													class="form-control" placeholder="Nhập số điện thoại">
											</div>
											<p id="phone_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline mb-4">
											<label for="email">Email: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-envelope"></i></span> <input type="email" id="email"
													name="email" class="form-control" placeholder="Nhập email">
											</div>
											<p id="email_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline mb-4">
											<label for="address">Địa chỉ:</label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-map"></i></span>
												<input type="text" id="address" name="address"
													class="form-control" placeholder="Nhập địa chỉ">
											</div>
										</div>

										<div class="form-outline mb-4">
											<label for="password">Mật khẩu: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-lock"></i></span>
												<input type="password" id="password" name="password"
													class="form-control" placeholder="Nhập mật khẩu"><span
													class="input-group-text bx click-eye bx-hide"></span>
											</div>
											<p id="password_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline mb-4">
											<label for="retype_password">Nhập lại mật khẩu: <span
												class="require" style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-lock-alt"></i></span> <input type="password"
													id="retype_password" name="retype_password"
													class="form-control" placeholder="Nhập lại mật khẩu">
												<span class="input-group-text bx click-eye bx-hide"></span>

											</div>
											<p id="retype_password_error"
												style="color: red; position: inherit;"></p>
									</form>
								</div>

							</div>

						</div>

					</div>
				</div>
			</div>
		</div>
	</section>
	<script src="js/user.js"></script>
</body>

</html>