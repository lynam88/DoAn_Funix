<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title" value="Cấp Lại Mật Khẩu | Website Từ Thiện"></c:param>
</c:import>

<%
String notifyPassSent = (String) request.getAttribute("notifyPassSent");
String statusPassSent = (String) request.getAttribute("statusPassSent");
String notifyValid = (String) request.getAttribute("notifyValid");

if (notifyPassSent != null) {
%>
<div class="modal" id="sendPassModal" role="dialog">
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
				<p class="text-center" id="sendPassMsg"
					style="font-size: large; color: red;"><%=notifyPassSent%></p>
			</div>
		</div>

	</div>
</div>

<script>
		setTimeout(function() {
			$("#sendPassModal").modal("show");
		}, 500);
		setTimeout(function() {
			$('#sendPassModal').modal().hide();			
			var st = "<%=statusPassSent%>";
		if (st == "Ok") {
			window.history.back();
		}
	}, 15000);
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
						<div class="col-lg-6">
							<div class="card-body p-md-5 mx-md-4">
								<form class="resetPassForm" action="UsersController?action=resetPassword"
									method="post">
									<h4>CẤP LẠI MẬT KHẨU</h4>
									<br/>
									<p>Nếu bạn quên mật khẩu, xin hãy điền vào email để chúng
										tôi gửi lại mật khẩu mới cho bạn</p>
									<div class="form-outline my-3">
										<label for="email">Email: <span class="require"
											style="color: red;">*</span></label>
										<div class="input-group">
											<span class="input-group-text"><i
												class="bx bx-envelope"></i></span> <input type="email" id="email"
												name="email" class="form-control" placeholder="Nhập email">
										</div>
										<p id="email_error" style="color: red; position: inherit;">
											<%
											if (notifyValid != null) {
											%>
											<%=notifyValid%>
											<%
											}
											%>

										</p>
										<p>
											<span class="require" style='color: red;'>(*) Bắt buộc</span>
										</p>
										<div>
											<span>Tài khoản của bạn bị khoá? </span> <a href="#"
												id="recoverUser">Xin Liên Hệ!</a>
										</div>
									</div>
									<br />
									<div class="text-center submitBtn">
										<button
											class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
											type="submit" onclick="return validateForgotEmail()">Đặt
											lại mật khẩu</button>
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