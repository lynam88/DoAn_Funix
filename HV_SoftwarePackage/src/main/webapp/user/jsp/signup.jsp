<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:import url="header.jsp">
	<c:param name="title" value="Đăng Ký Thành Viên Mới | Từ Thiện Liên Hoa"></c:param>
</c:import>

<%
String notifySignup = (String) request.getAttribute("notifySignup");
String statusSignup = (String) request.getAttribute("statusSignup");

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
				if (st == "OK") {
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
<section class="h-100 gradient-form"
	style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');">
	<div class="container py-5 h-100">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-12">
				<div class="card rounded-3 text-black">
					<div class="row g-0">
						<div class="signUpTitle">
							<h3 class="text-center" >ĐĂNG KÝ THÀNH
								VIÊN MỚI</h3>
						</div>
						<form class="signupForm" action="${pageContext.request.contextPath}/UsersController?action=signup"
							method="post" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-6">
									<div class="card-body p-md-5">																				
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
										  <label for="phone">Số điện thoại: </label>
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
									<div class="card-body p-md-5 rightForm">
										<div class="form-outline my-3">
											<label for="address">Địa chỉ:</label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-map"></i></span>
												<input type="text" id="address" name="address"
													class="form-control" placeholder="Xin nhập địa chỉ"
													value="${inputUser.address}"/>
											</div>
											<p id="address_error"></p>
										</div>
										<div class="form-outline my-3">
											<label for="password">Mật khẩu: <span class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-lock"></i></span>
												<input type="password" id="signupPass" name="signupPass"
													class="form-control" placeholder="Xin nhập mật khẩu" value="${signupPass}"/><span
													class="input-group-text bx click-eye bx-hide signupPassIcon"></span>
											</div>
											<p id="signupPass_error" ></p>
										</div>

										<div class="form-outline my-3">
											<label for="password">Xin nhập lại mật khẩu: <span
												class="require" >*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class="bx bx-lock-alt"></i></span> <input type="password"
													id="retype_signupPass" name="retype_signupPass"
													class="form-control" placeholder="Xin nhập lại mật khẩu"
													value="${signupPass}"/> <span
													class="input-group-text bx click-eye bx-hide signupPassIcon"></span>

											</div>
											<p id="retype_signupPass_error"></p>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row justify-content-center mt-4 rules">
								<div>
									<input type="radio" id="agree" name="agree" value="yes"
										onclick="enableButton()" /> <label for="agree">Tôi đã
										đọc và đồng ý với các quy định của trang web</label>
								</div>
							</div>
							<div class="row justify-content-center mt-4 signupBtn">
								<div class="col-lg-6 text-center">
									<button class="btn btn-primary fa-lg gradient-custom-2 mb-3"
										type="submit" id="submit-button"
										onclick="return validateSignup()" disabled>Đăng ký</button>
								</div>
							</div>
							<div class="col text-center">
								<div class="signupBottom">
									<span class="text-center">Bạn đã có tài khoản? </span> <a
										href="${pageContext.request.contextPath}/UsersController?action=login">Xin Đăng Nhập!</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>