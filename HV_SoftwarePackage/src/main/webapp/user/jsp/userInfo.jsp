<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:import url="header.jsp">
	<c:param name="title"
		value="Thông tin người dùng | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

<%
String notifyUpdate = (String) request.getAttribute("notifyUpdate");
String statusUpdate = (String) request.getAttribute("statusUpdate");

if (notifyUpdate != null) {
%>
<div class="modal" id="updateModal" role="dialog">
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
					style="font-size: large; color: red;"><%=notifyUpdate%></p>
			</div>
		</div>

	</div>
</div>

<script>
		setTimeout(function() {
			$("#updateModal").modal("show");
		}, 500);
		setTimeout(function() {
			$('#updateModal').modal().hide();
			var st = "<%=statusUpdate%>";
				if (st == "OK") {
					window.location.href = '/HV_SoftwarePackage/UsersController?action=userInfo';
				} else {
					// remove class modal-backdrop in
					$(".modal-backdrop").removeClass("modal-backdrop in");
					window.history.back();
				}
			}, 3000);
</script>
<%
}
%>

<div class="hero-wrap"
	style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');"
	data-stellar-background-ratio="0.5">
	<div class="overlay"></div>
	<div class="container">
		<div
			class="row no-gutters slider-text align-items-center justify-content-center"
			data-scrollax-parent="true">
			<div class="col-md-7 ftco-animate text-center"
				data-scrollax=" properties: { translateY: '70%' }">
				<p class="breadcrumbs"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">
					<span class="mr-2"><a
						href="${pageContext.request.contextPath}/UsersController?action=user">Trang
							Chủ</a></span> <span>Thông tin người dùng</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Thông tin người dùng</h1>
			</div>
		</div>
	</div>
</div>

<section class="ftco-section ftco-degree-bg">
	<div class="container">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-12">
				<div class="card rounded-3 text-black">
					<div class="row g-0">
						<div class="signUpTitle">
							<h3 class="text-center text-primary">THÔNG TIN NGƯỜI DÙNG</h3>
						</div>
						<form class="updateForm"
							action="${pageContext.request.contextPath}/UsersController?action=updateUserInfo"
							method="post" enctype="multipart/form-data"
							onsubmit="return validateUpdate()">
							<div class="row">
								<div class="col-md-6">
									<div class="card-body p-md-5">
										<span class="require">(*) Bắt buộc</span>
										<div class="form-outline my-3">
											<label for="name">Họ và tên: <span class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-user"></i></span>
												<input type="text" id="name" name="name"
													class="form-control" placeholder="Xin nhập họ và tên"
													value="<c:out value='${user.name}'/>">
											</div>
											<p id="name_error"></p>
										</div>

										<div class="form-outline my-3">
											<label for="phone">Số điện thoại: <span class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-phone"></i></span>
												<input type="text" id="phone" name="phone"
													class="form-control" placeholder="Xin nhập số điện thoại"
													value="<c:out value='${user.phone}'/>">
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
													value="<c:out value='${user.email}'/>">
													<input type="hidden" id="email"
													name="originEmail" class="form-control"													
													value="<c:out value='${user.email}'/>">
											</div>
											<p id="email_error">${email_error}</p>
										</div>										
									</div>

								</div>
								<div class="col-md-6">
									<div class="card-body p-md-5 rightForm">
										<div class="form-outline my-3">											
											<label for="avatar">Ảnh đại diện: </label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-image"></i></span>
												<input type="file" id="avatar" name="avatar"
													class="form-control">
											</div>
										</div>
										
										<c:if test="${user.avatarPath != null }"><img src="${user.avatarPath}" alt="Avatar" class="avatarInfo"></c:if>
																			
										<div class="form-outline my-3">
											<label for="address">Địa chỉ:</label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-map"></i></span>
												<input type="text" id="address" name="address"
													class="form-control" placeholder="Xin nhập địa chỉ"
													value="${user.address}" />
											</div>
											<p id="address_error"></p>
										</div>
										
									</div>
								</div>
							</div>

							<div class="row justify-content-center signupBtm">
								<div class="col-lg-6 text-center">
									<button
										class="btn btn-primary fa-lg gradient-custom-2 mb-3"
										type="submit" id="submit-button">Cập nhật tài khoản</button>
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