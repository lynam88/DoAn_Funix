<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:import url="header.jsp">
	<c:param name="title" value="Đăng Ký Thành Viên Mới | Website Từ Thiện"></c:param>
</c:import>

<%
	String notifySignup = (String) request.getAttribute("notifyLogin");
	String statusSignup = (String) request.getAttribute("statusLogin");

	if (notifySignup != null) {
%>
<div class="modal" id="signupModal" role="dialog">
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
					style="font-size: large; color: red;"><%=notifySignup%></p>
			</div>
		</div>

	</div>
</div>

<script>
		setTimeout(function() {
			$("#signupModal").modal("show");
		}, 500);
		setTimeout(function() {
			$('#signupModal').modal().hide();
			var st = "<%=statusSignup%>";
				if (st == "Ok") {
					window.location.href = '/HV_SoftwarePackage/UsersController?action=login';
				} else {
					// remove class modal-backdrop in
					$(".modal-backdrop").removeClass("modal-backdrop in");
					window.history.back();
				}
			}, 5000);
</script>
<%
	}
%>
<div class="container py-5 h-100">
	<div class="row d-flex justify-content-center align-items-center h-100">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="#"> <img src="media/logo.jpg"
					alt="logo" style="width: 185px;"> Quỹ Từ Thiện Liên Hoa
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse justify-content-end"
					id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/UsersController?action=signup"><i
								class='bx bxs-left-arrow-square'></i> Đăng Ký</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/UsersController?action=resetPassword"><i
								class='bx bxs-lock-open'></i> Cấp Lại Mật Khẩu</a></li>
						<li class="nav-item"><a class="nav-link" href="index.jsp"><i
								class='bx bxs-home'></i> Trang chủ</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/UsersController?action=recoverUser"><i
								class='bx bxs-shield'></i> Phục Hồi Tài Khoản</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/UsersController?action=login">Đăng
								Nhập <i class='bx bxs-right-arrow-square'></i>
						</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<div class="row d-flex justify-content-center align-items-center h-100">
		<div class="col-xl-10">
			<div class="card rounded-3 text-black"
				style="background-image: url('${pageContext.request.contextPath}/media/background.jpg');">
				<div class="row g-0" style="display: block;">
					<div class="text-center" style="width: 100%;">
						<h4 class="mt-1 mb-5 pb-1" style="color: orangered;">Quỹ Từ
							Thiện Liên Hoa</h4>
					</div>
					<div>
						<form action="UsersController?action=signup" method="post"
							enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-6">
									<div class="card-body p-md-5 mx-md-4">
										<h6 style="color: blue; display: inline-block;">ĐĂNG KÝ
											THÀNH VIÊN MỚI</h6>
										<span class="require" style="color: red;">(*) Bắt buộc</span>
										<div class="form-outline my-3">
											<label for="name">Họ và tên: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-user"></i></span>
												<input type="text" id="name" name="name"
													class="form-control" placeholder="Xin nhập họ và tên"
													value="<c:out value='${inputUser.name}'/>">
											</div>
											<p id="name_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline my-3">
											<label for="phone">Số điện thoại: <span
												class="require" style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-phone"></i></span>
												<input type="text" id="phone" name="phone"
													class="form-control" placeholder="Xin nhập số điện thoại"
													value="<c:out value='${inputUser.phone}'/>">
											</div>
											<p id="phone_error" style="color: red; position: inherit;"></p>
											<div class="phone_error"
												style="color: red; position: inherit;">
												<%
													String phone_error = (String) session.getAttribute("phone_error");
													if (phone_error != null) {
														out.println(phone_error);
													}
												%>
											</div>
										</div>

										<div class="form-outline my-3">
											<label for="email">Email: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-envelope"></i></span> <input type="email" id="email"
													name="email" class="form-control"
													placeholder="Xin nhập email"
													value="<c:out value='${inputUser.email}'/>">
											</div>
											<p id="email_error" style="color: red; position: inherit;"></p>
											<div class="email_error"
												style="color: red; position: inherit;">
												<%
													String email_error = (String) session.getAttribute("email_error");
													if (email_error != null) {
														out.println(email_error);
													}
												%>
											</div>
										</div>

										<div class="form-outline my-3">
											<label for="avatar">Ảnh đại diện: </label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-image"></i></span>
												<input type="file" id="avatar" name="avatar"
													class="form-control"
													value="<c:out value='${inputUser.avatarPath}'/>">
											</div>
										</div>

									</div>

								</div>
								<div class="col-md-6">
									<div class="card-body p-md-5 mx-md-4 rightForm">
										<div class="form-outline my-3">
											<label for="address">Địa chỉ:</label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-map"></i></span>
												<input type="text" id="address" name="address"
													class="form-control" placeholder="Xin nhập địa chỉ"
													value="${inputUser.address}">
											</div>
											<p id="address_error" style="color: red; position: inherit;"></p>
										</div>
										<div class="form-outline my-3">
											<label for="password">Mật khẩu: <span class="require"
												style="color: red;">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-lock"></i></span>
												<input type="password" id="password" name="password"
													class="form-control" placeholder="Xin nhập mật khẩu"
													value="<c:out value='${inputUser.password}'/>"><span
													class="input-group-text bx click-eye bx-hide"></span>
											</div>
											<p id="password_error" style="color: red; position: inherit;"></p>
										</div>

										<div class="form-outline my-3">
											<label for="retype_password">Xin nhập lại mật khẩu: <span
												class="require" style="color: red;">*</span>
											</label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-lock-alt"></i></span> <input type="password"
													id="retype_password" name="retype_password"
													class="form-control" placeholder="Xin nhập lại mật khẩu"
													value="<c:out value='${inputUser.password}'/>"> <span
													class="input-group-text bx click-eye bx-hide"></span>

											</div>
											<p id="retype_password_error"
												style="color: red; position: inherit;"></p>
										</div>
									</div>
								</div>
							</div>
							<div class="row justify-content-center mt-4"
								style="margin-top: -1.5rem !important;">
								<div class="col-lg-6" style="text-align: center !important;">
									<input type="radio" id="agree" name="agree" value="yes"
										onclick="enableButton()" /> <label for="agree">Tôi đã
										đọc và đồng ý với các quy định của trang web</label>
								</div>
							</div>
							<div class="row justify-content-center mt-4"
								style="margin-top: 1rem !important;">
								<div class="col-lg-6 text-center">
									<button class="btn btn-primary fa-lg gradient-custom-2 mb-3"
										type="submit" id="submit-button"
										onclick="return validateSignup()" disabled>Đăng ký</button>
								</div>
							</div>
							<div class="col text-center">
								<div style="display: flow-root; padding-bottom: 2%;">
									<span class="text-center">Bạn đã có tài khoản? </span> <a
										href="#" id="login" style="color: aquamarine;">Xin Đăng
										Nhập!</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<c:import url="footer.jsp"></c:import>