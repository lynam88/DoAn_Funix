<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Đăng Nhập Hệ Thống | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

<div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="${pageContext.request.contextPath}/UsersController?action=user">Trang Chủ</a></span> <span>Đăng Nhập</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Đăng Nhập</h1>
          </div>
        </div>
      </div>
    </div>

<section class="ftco-section ftco-degree-bg">
	<div class="container">
			<div class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-xl-12">
					<div class="card rounded-3 text-black">
						<div class="row g-0">
							<div class="col-lg-6">
								<div class="card-body p-md-5 mx-md-4">
								
									<form class="loginForm"
										action="${pageContext.request.contextPath}/UsersController?action=login"
										method="post" onsubmit="return validateLogin()">
										<h4 class="text-primary">MỜI BẠN ĐĂNG NHẬP VÀO TÀI KHOẢN</h4>
										<%
										Cookie[] cookies = request.getCookies();
										String id = "";
										String pword = "";
										if (cookies != null) {
											for (Cookie retrievedCookies : cookies) {
												if (retrievedCookies.getName().equals("loginId")) {
											id = retrievedCookies.getValue();
												}
												if (retrievedCookies.getName().equals("loginPass")) {
											pword = retrievedCookies.getValue();
												}
											}
										}
										if (id != "" && pword != "") {
										%>
										<div class="form-outline mb-4 login-form">
											<input type="text" id="loginId" name="loginId"
												class="form-control"
												placeholder="Số Điện Thoại/Địa Chỉ Email" value="<%=id%>">
											<span class="symbol-input100 login-icon"> <i
												class="bx bx-user"></i>
											</span>
											<p id="loginId_error">${notifyLogin}</p>
										</div>
										<div class="form-outline mb-4">
											<input type="password" id="loginPass" name="loginPass"
												placeholder="Mật khẩu" class="form-control"
												value="<%=pword%>"> <span
												class="bx fa-fw field-icon click-eye bx-hide loginPass-eye-icon"></span>
											<span class="symbol-input100 loginPass-icon"> <i
												class="bx bx-key"></i>
											</span>
											<p id="loginPass_error" />
										</div>
										
										<%
										} else {
										%>
										
										<div class="form-outline mb-4 login-form">
											<input type="text" id="loginId" name="loginId"
												class="form-control"
												placeholder="Số Điện Thoại/Địa Chỉ Email"> <span
												class="symbol-input100 login-icon"> <i
												class="bx bx-user"></i>
											</span>
											<p id="loginId_error">${notifyLogin}</p>
										</div>

										<div class="form-outline mb-4">
											<input type="password" id="loginPass" name="loginPass"
												placeholder="Mật khẩu" class="form-control"> <span
												class="bx fa-fw field-icon click-eye bx-hide loginPass-eye-icon"></span>
											<span class="symbol-input100 loginPass-icon"> <i
												class="bx bx-key"></i>
											</span>
											<p id="loginPass_error" />

										</div>
										<%
										}
										%>
										<div class="remember">
											<input type="checkbox" id="remember" name="remember">
											<label for="remember">Remember me</label> <a
												href="${pageContext.request.contextPath}/UsersController?action=resetPassword"
												id="resetPass" style="padding-left: 30%;">Bạn quên mật
												khẩu?</a>
										</div>

										<div class="text-center pt-1 mb-5 pb-1">
											<button
												class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
												type="submit">Đăng nhập</button>
											<div>
												<span>Bạn chưa có tài khoản? </span> <a
													href="${pageContext.request.contextPath}/user/jsp/rules.jsp"
													id="signup">Xin Đăng Ký!</a>
											</div>
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
