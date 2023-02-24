<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title" value="Phục Hồi Tài Khoản | Website Từ Thiện"></c:param>
</c:import>

<%
String notifyPassSent = (String) request.getAttribute("notifyPassSent");
String statusPassSent = (String) request.getAttribute("statusPassSent");

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
			var st = "<%=statusPassSent%>
	";
		if (st == "Ok") {
			window.history.back();
		}
	}, 15000);
</script>

<%
}
%>
	<div class="container py-5 h-100">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-10">
				<div class="card rounded-3 text-black">
					<div class="row g-0">
						<div class="col-lg-6">
							<div class="card-body p-md-5 mx-md-4">
								<div class="text-center">
									<img src="media/logo.jpg" style="width: 185px;" alt="logo">
									<h4 class="mt-1 mb-5 pb-1" style="color: orangered;">Quỹ
										Từ Thiện Liên Hoa</h4>
								</div>
								<form action="UsersController?action=recoverUser" method="post">
									<h6 style="color: blue;">PHỤC HÒI TÀI KHOẢN</h6>
									<p>Chúng tôi rất tiếc vì tài khoản của bạn đã bị khóa, xin hãy điền vào nội dung phản hồi và thông tin email, chúng tôi sẽ tiến hành xử lý yêu cầu và thông báo lại cho bạn khi tài khoản của bạn được khôi phục thành công. Xin cảm ơn! </p>
									<div class="form-outline my-3">
										<label for="feedback">Nội dung phản hồi: <span class="require"
											style="color: red;">*</span></label>
										<div class="input-group">
											<span class="input-group-text"><i class="bx bx-message"></i></span>
											<textarea type="text" id="feedback" name="feedback" class="form-control" placeholder="Nhập nội dung" rows="10"></textarea>
										</div>
										<p id="feedback_error" style="color: red; position: inherit;">
										<br/>								
										<label for="email">Email cần khôi phục: <span class="require"
											style="color: red;">*</span></label>
										<div class="input-group">
											<span class="input-group-text"><i
												class="bx bx-envelope"></i></span> <input type="email" id="email"
												name="email" class="form-control" placeholder="Nhập email">
										</div>
										<p id="email_recover_error" style="color: red; position: inherit;">
										<div class="email_recover_error" style="color: red; position: inherit;">
											<%
												String email_recover_error = (String) session.getAttribute("email_recover_error");
												if (email_recover_error != null){
													out.println(email_recover_error);
												}
											%>
											</div>
										</p>
										<p>
											<span class="require" style='color: red;'>(*) Bắt buộc</span>
										</p>
									</div>
									<br />
									<div class="text-center">
										<button
											class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
											type="submit" onclick="return validateRecoverUser()">Gửi Yêu Cầu Phục Hồi</button>
									</div>
								</form>
							</div>
						</div>
						<div class="col-lg-6 align-items-center gradient-custom-2 rightText">
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

<c:import url="footer.jsp"></c:import>