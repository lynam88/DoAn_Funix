<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:import url="header.jsp">
	<c:param name="title" value="Đăng Nhập Hệ Thống | Website Từ Thiện"></c:param>
</c:import>
<%
String notifyLogin = (String) request.getAttribute("notifyLogin");
String statusLogin = (String) request.getAttribute("statusLogin");

if (notifyLogin != null) {
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
			var st = "<%=statusLogin%>
	";
				if (st == "Admin") {
					window.location.href = '/HV_SoftwarePackage/UsersController?action=admin';
				} else {
					// remove class modal-backdrop in
					$(".modal-backdrop").removeClass("modal-backdrop in");
					window.history.back();
				}
			}, 2000);
</script>

<%
}
%>

<div class="hero-wrap"
	style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');"
	data-stellar-background-ratio="0.5">
	
	<div class="container">
		<div
			class="row no-gutters slider-text align-items-center justify-content-center"
			data-scrollax-parent="true">
			<div class="col-md-7 ftco-animate text-center"
				data-scrollax=" properties: { translateY: '70%' }">
				<form action="UsersController?action=login" method="post"
					onsubmit="return validateLogin()">
					<h6 style="color: blue;">MỜI BẠN ĐĂNG NHẬP VÀO TÀI KHOẢN</h6>
					<%
					Cookie[] cookies = request.getCookies();
					String id = "";
					String pword = "";
					if (cookies != null) {
						for (Cookie retrievedCookies : cookies) {
							if (retrievedCookies.getName().equals("loginId")) {
						id = retrievedCookies.getValue();
							}
							if (retrievedCookies.getName().equals("password")) {
						pword = retrievedCookies.getValue();
							}
						}
					}
					if (id == "" && pword == "") {
					%>
					<div class="form-outline mb-4"
						style="position: relative; bottom: -20px;">
						<input type="text" id="loginId" name="loginId"
							class="form-control"
							placeholder="Số Điện Thoại Hoặc Địa Chỉ Email"
							style="position: absolute; padding-left: 30px; top: -15px;"
							value="<%=id%>"> <span class="focus-input100"></span> <span
							class="symbol-input100"
							style="top: -7px; left: 9px; position: absolute;"> <i
							class="bx bx-user"></i>
						</span>
						<p id="loginId_error"
							style="color: red; position: inherit; bottom: -25px;" />
					</div>

					<div class="form-outline mb-4">
						<input type="password" id="password" name="password"
							placeholder="Mật khẩu" class="form-control"
							style="position: relative; top: 44px; padding-left: 30px;"
							value="<%=pword%>"> <span toggle="#form2Example22"
							class="bx fa-fw field-icon click-eye bx-hide"
							style="position: relative; left: 90%; top: 15px;"></span> <span
							class="focus-input100"></span> <span class="symbol-input100"
							style="position: relative; top: 14px; right: 15px;"> <i
							class="bx bx-key"></i>
						</span>
						<p id="password_error"
							style="color: red; position: relative; bottom: -20px; padding-bottom: 10px;" />

					</div>
					<%
					} else {
					%>
					<div class="form-outline mb-4"
						style="position: relative; bottom: -20px;">
						<input type="text" id="loginId" name="loginId"
							class="form-control"
							placeholder="Số Điện Thoại Hoặc Địa Chỉ Email"
							style="position: absolute; padding-left: 30px; top: -15px;">
						<span class="focus-input100"></span> <span class="symbol-input100"
							style="top: -7px; left: 9px; position: absolute;"> <i
							class="bx bx-user"></i>
						</span>
						<p id="loginId_error"
							style="color: red; position: inherit; bottom: -25px;" />
					</div>

					<div class="form-outline mb-4">
						<input type="password" id="password" name="password"
							placeholder="Mật khẩu" class="form-control"
							style="position: relative; top: 44px; padding-left: 30px;">
						<span toggle="#form2Example22"
							class="bx fa-fw field-icon click-eye bx-hide"
							style="position: relative; left: 90%; top: 15px;"></span> <span
							class="focus-input100"></span> <span class="symbol-input100"
							style="position: relative; top: 14px; right: 15px;"> <i
							class="bx bx-key"></i>
						</span>
						<p id="password_error"
							style="color: red; position: relative; bottom: -20px; padding-bottom: 10px;" />

					</div>
					<%
					}
					%>
					<div>
						<input type="checkbox" name="remember" value="remember" value="on">
						<label for="remember">Remember me</label> <a class="text-muted"
							href="#" id="resetPass" style="padding-left: 10%;">Bạn quên
							mật khẩu?</a>
					</div>
					<br />
					<div class="text-center pt-1 mb-5 pb-1">
						<button
							class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
							type="submit">Đăng nhập</button>
						<div>
							<span>Bạn chưa có tài khoản? </span> <a href="#" id="signup">Xin
								Đăng Ký!</a>
						</div>
					</div>

				</form>

			</div>
		</div>
		<div class="col-lg-6 d-flex align-items-center gradient-custom-2">
			<div class="text-white px-3 py-4 p-md-5 mx-md-4">
				<h4 class="text-center mb-4">Cho đi là còn mãi</h4>
				<p class="text-center small mb-0">Một khi bạn cho đi, chính là
					lúc bạn được nhận lại.</p>
			</div>
		</div>
	</div>
</div>
</div>
</div>
</div>

</div>
</div>
</div>
</div>


<c:import url="footer.jsp"></c:import>
