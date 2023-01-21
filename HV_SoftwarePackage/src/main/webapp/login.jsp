<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<title>Đăng nhập hệ thống | Website Từ Thiện</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="/HV_SoftwarePackage/css/project.css">

<!-- Latest compiled and minified CSS -->
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
							<div class="col-lg-6">
								<div class="card-body p-md-5 mx-md-4">

									<div class="text-center">
										<img
											src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp"
											style="width: 185px;" alt="logo">
										<h4 class="mt-1 mb-5 pb-1">Quỹ Từ Thiện Sen Vàng</h4>
									</div>

									<form>
										<form>
											<p style="">Vui lòng đăng nhập vào tài khoản</p>

											<div class="form-outline mb-4"
												style="position: relative; bottom: -20px;">
												<input type="email" id="form2Example11" name="email"
													class="form-control" placeholder="Địa chỉ email"
													style="position: absolute; padding-left: 30px; top: -15px;">
												<span class="focus-input100"></span> <span
													class="symbol-input100"
													style="top: -7px; left: 9px; position: absolute;"> <i
													class="bx bx-user"></i>
												</span>

											</div>

											<div class="form-outline mb-4">
												<input type="password" id="form2Example22" name="password"
													placeholder="Mật khẩu" class="form-control"
													style="position: relative; top: 44px; padding-left: 30px;">
												<span toggle="#form2Example22"
													class="bx fa-fw field-icon click-eye bx-hide"
													style="position: relative; left: 90%; top: 15px;"></span> <span
													class="focus-input100"></span> <span
													class="symbol-input100"
													style="position: relative; top: 14px; right: 15px;">
													<i class="bx bx-key"></i>
												</span>
											</div>
											<div>
												<input type="checkbox" name="remember" value="remember"
													value="on"> <label for="remember">Remember
													me</label>
											</div>
											<div class="text-center pt-1 mb-5 pb-1">
												<button
													class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
													type="button">Đăng nhập</button>
												<a class="text-muted" href="#!">Bạn quên mật khẩu?</a>
											</div>
											<div class="error">
												<c:if test="${error != null}">
													<p><c:out value="${error}"></c:out></p>
												</c:if>
											</div>

										</form>
								</div>
							</div>
							<div class="col-lg-6 d-flex align-items-center gradient-custom-2">
								<div class="text-white px-3 py-4 p-md-5 mx-md-4">
									<h4 class="text-center mb-4">Cho đi là còn mãi</h4>
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
	<script type="text/javascript">
		//show - hide mật khẩu
		$(".click-eye").click(function() {
			$(this).toggleClass("bx-show bx-hide");
			var input = $($(this).attr("toggle"));
			if (input.attr("type") == "password") {
				input.attr("type", "text");
			} else {
				input.attr("type", "password");
			}
		});
	</script>
</body>

</html>