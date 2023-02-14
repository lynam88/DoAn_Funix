<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<title>Đăng nhập hệ thống | Website Từ Thiện</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
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
<%
	String notifyLogin = (String) request.getAttribute("notifyLogin");
	String statusLogin = (String) request.getAttribute("statusLogin");
	
	if(notifyLogin != null) {
	%>
	<div class="modal" id="loginModal" role="dialog">
		<div class="modal-dialog">
	
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p class="text-center" id="insertMsg"
						style="font-size: large; color: red;"><%=notifyLogin%></p>
				</div>
			</div>
	
		</div>
	</div>
	
	<script>
		setTimeout(function() {
			$("#loginModal").modal("show");
		}, 500);
		setTimeout(function() {
			$('#loginModal').modal().hide();
			var st = "<%=statusLogin%>";
			if (st == "Admin") {
				window.location.href = '/HV_SoftwarePackage/UsersController?action=index';
			} else if (st == "User") {
				window.history.back();			
			} else {
				// remove class modal-backdrop in
				$(".modal-backdrop").removeClass( "modal-backdrop in");
				window.history.back();
			} 
		}, 3000);
		
	</script>
	
	<%}%>
	
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

									<form action="UsersController?action=login" method="post" onsubmit="return validateLogin()">
											<p>Vui lòng đăng nhập vào tài khoản</p>

											<%
												Cookie[] cookies = request.getCookies();
												String id = "";
												String pword = "";
												if (cookies != null) {
													for (Cookie retrievedCookies: cookies){
														if (retrievedCookies.getName().equals("loginId")){
															id = retrievedCookies.getValue();
														}
														if (retrievedCookies.getName().equals("password")){
															pword = retrievedCookies.getValue();
														}
													}
												}
												if (id =="" && pword ==""){
											%>			
											<div class="form-outline mb-4"
												style="position: relative; bottom: -20px;">
												<input type="text" id="loginId" name="loginId"
													class="form-control" placeholder="Số Điện Thoại Hoặc Địa Chỉ Email"
													style="position: absolute; padding-left: 30px; top: -15px;" value="<%=id %>">
												<span class="focus-input100"></span> <span
													class="symbol-input100"
													style="top: -7px; left: 9px; position: absolute;"> <i
													class="bx bx-user"></i>
												</span>									
												<p id="loginId_error" style="color: red;position: inherit;bottom: -25px;" />	
											</div>																			

											<div class="form-outline mb-4">
												<input type="password" id="password" name="password"
													placeholder="Mật khẩu" class="form-control"
													style="position: relative; top: 44px; padding-left: 30px;" value="<%=pword %>">
												<span toggle="#form2Example22"
													class="bx fa-fw field-icon click-eye bx-hide"
													style="position: relative; left: 90%; top: 15px;"></span> <span
													class="focus-input100"></span> <span
													class="symbol-input100"
													style="position: relative; top: 14px; right: 15px;">
													<i class="bx bx-key"></i>
												</span>
												<p id="password_error" style="color: red;position: relative;bottom: -20px;padding-bottom: 10px;" />
												
											</div>
											<%} else {%>											
											<div class="form-outline mb-4"
												style="position: relative; bottom: -20px;">
												<input type="text" id="loginId" name="loginId"
													class="form-control" placeholder="Số Điện Thoại Hoặc Địa Chỉ Email"
													style="position: absolute; padding-left: 30px; top: -15px;">
												<span class="focus-input100"></span> <span
													class="symbol-input100"
													style="top: -7px; left: 9px; position: absolute;"> <i
													class="bx bx-user"></i>
												</span>									
												<p id="loginId_error" style="color: red;position: inherit;bottom: -25px;" />	
											</div>																			

											<div class="form-outline mb-4">
												<input type="password" id="password" name="password"
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
												<p id="password_error" style="color: red;position: relative;bottom: -20px;padding-bottom: 10px;" />
												
											</div>
											<%} %>
											<div>
												<input type="checkbox" name="remember" value="remember"
													value="on"> <label for="remember">Remember
													me</label>
											</div>
											<div class="text-center pt-1 mb-5 pb-1">
												<button
													class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
													type="submit">Đăng nhập</button>
												<a class="text-muted" href="#!">Bạn quên mật khẩu?</a>
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
	<script src="${pageContext.request.contextPath}/js/user.js"></script>
</body>

</html>