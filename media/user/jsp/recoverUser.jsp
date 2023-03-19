<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title" value="Phục Hồi Tài Khoản | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

<%
String notifyRecover = (String) request.getAttribute("notifyRecover");
String statusRecover = (String) request.getAttribute("statusRecover");

if (notifyRecover != null) {
%>
<div class="modal" id="recoverModal" role="dialog">
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
					style="font-size: large; color: red;"><%=notifyRecover%></p>
			</div>
		</div>

	</div>
</div>

<script>
	setTimeout(function() {
		$("#recoverModal").modal("show");
	}, 500);
	setTimeout(function() {
		$('#recoverModal').modal().hide();
		var st = "<%=statusRecover%>";
		if (st == "Ok") {
			window.location.href = '/HV_SoftwarePackage/UsersController?action=recoverUser';
		}
	}, 7000);
</script>

<%
}
%>
<div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="${pageContext.request.contextPath}/UsersController?action=user">Trang Chủ</a></span> <span>Phục hồi tài khoản</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Phục hồi tài khoản</h1>
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
								<form action="${pageContext.request.contextPath}/UsersController?action=recoverUser" method="post">
									<h4 class="text-primary">PHỤC HỒI TÀI KHOẢN</h4>
									<p id="recoverText">Chúng tôi rất tiếc vì tài khoản của bạn đã bị khóa, xin
										hãy điền vào nội dung phản hồi và thông tin email, chúng tôi
										sẽ tiến hành xử lý yêu cầu và thông báo lại cho bạn khi tài
										khoản của bạn được khôi phục thành công. Xin cảm ơn!</p>
									<div class="form-outline my-3">
										<label for="feedback">Nội dung phản hồi: <span
											class="require">*</span></label>
										<div class="input-group">
											<span class="input-group-text"><i
												class="bx bx-message"></i></span>
											<textarea type="text" id="feedback" name="feedback"
												class="form-control" placeholder="Nhập nội dung" rows="10">${feedback}</textarea>
										</div>
										<p id="feedback_error"></p>
										<br /> <label for="email">Email cần khôi phục: <span
											class="require">*</span></label>
										<div class="input-group">
											<span class="input-group-text"><i
												class="bx bx-envelope"></i></span> <input type="email" id="email"
												name="email" class="form-control" placeholder="Nhập email" value="${toEmail}">
										</div>
										<p id="email_recover_error">${notifyValid}</p>
										<p>
											<span class="require">(*) Bắt buộc</span>
										</p>
									</div>
									<br />
									<div class="text-center">
										<button
											class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3 recoverBtn"
											type="submit" onclick="return validateRecoverUser()">Gửi
											Yêu Cầu Phục Hồi</button>
									</div>
								</form>				
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