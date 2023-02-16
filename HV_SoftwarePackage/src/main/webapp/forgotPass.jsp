<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title" value="Cấp Lại Mật Khẩu | Website Từ Thiện"></c:param>
</c:import>

<section class="h-100 gradient-form"
	style="background-image: url('${pageContext.request.contextPath}/assets/img/carousel-4.jpg');">
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
									<h4 class="mt-1 mb-5 pb-1" style="color: orangered;">Quỹ
										Từ Thiện Liên Hoa</h4>
								</div>

								<form action="UsersController?action=login" method="post"
									onsubmit="return validateLogin()">
									<h6 style="color: blue;">CẤP LẠI MẬT KHẨU</h6>
									<p>Nếu bạn quên mật khẩu, xin hãy điền vào email để chúng tôi gửi lại mật khẩu mới cho bạn</p>
									<div class="form-outline my-3">
										<label for="email">Email: <span class="require"
											style="color: red;">*</span></label>
										<div class="input-group">
											<span class="input-group-text"><i
												class="bx bx-envelope"></i></span> <input type="email" id="email"
												name="email" class="form-control" placeholder="Nhập email">
										</div>
										<p id="email_error" style="color: red; position: inherit;"></p>
									</div>																		
									<br />
									<div class="text-center pt-1 mb-5 pb-1">
										<button
											class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
											type="submit">Đặt lại mật khẩu</button>
											<div class="row">
												<div class="col">
													<i class="bx bx-envelope"></i>
													<a type="button" href="signup.jsp" class="btn"
														style="padding: 1%;">Đăng Ký</a>
												</div>
												<div class="col">
													<a type="button" href="login.jsp" class="btn"
														style="padding: 1%;">Đăng Nhập</a>
												</div>	
											</div>
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