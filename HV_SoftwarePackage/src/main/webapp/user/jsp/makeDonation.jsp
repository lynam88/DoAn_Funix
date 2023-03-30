<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Tạo Quyên Góp | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

<%
String notifyDonation = (String) request.getAttribute("notifyDonation");
String statusDonation = (String) request.getAttribute("statusDonation");

if (notifyDonation != null) {
%>
<div class="modal" id="donateModal" role="dialog">
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
				<p class="text-center" id="donateMsg"
					style="font-size: large; color: red;"><%=notifyDonation%></p>
			</div>
		</div>

	</div>
</div>

<script>
		setTimeout(function() {
			$("#donateModal").modal("show");
		}, 500);
		setTimeout(function() {
			$('#donateModal').modal().hide();
			var st = "<%=statusDonation%>";
				if (st == "OK") {
					window.location.href = '/HV_SoftwarePackage/UsersController?action=user';
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
							Chủ</a></span> <span>Quyên góp</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Quyên
					góp</h1>
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
							<h3 class="text-center text-primary">THỰC HIỆN QUYÊN GÓP</h3>
						</div>
						<form class="makeDonationForm"
							action="${pageContext.request.contextPath}/UsersDonationController?action=makeDonation"
							method="post" onsubmit="return validateDonation()">
							<div class="row donationTitle">
								<span class="input-group-text"><i class='bx bx-captions'></i></span>
								<p id="donationTitle">Tên đợt quyên góp: ${donationTitle}</p>
								<input type="hidden" name="donationTitle" value="${donationTitle}">
							</div>
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
													value="<c:out value='${inputUser.name}'/>">
											</div>
											<p id="name_error"></p>
										</div>

										<div class="form-outline my-3">
											<label for="phone">Số điện thoại: <span
												class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class="bx bx-phone"></i></span>
												<input type="text" id="phone" name="phone"
													class="form-control" placeholder="Xin nhập số điện thoại"
													value="<c:out value='${inputUser.phone}'/>">
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

									</div>

								</div>
								<div class="col-md-6">
									<div class="card-body p-md-5 rightDonation">
										<div class="form-outline my-3">
											<label for="donationAmount">Số tiền bạn muốn quyên góp: <span
												class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class='bx bx-donate-heart'></i></span> <input type="text"
													id="donationAmount" name="donationAmount" class="form-control"
													placeholder="Xin nhập số tiền"
													value="<c:out value='${inputUser.donationAmount}'/>"><span class="input-group-text"><i
													>VNĐ</i></span>
											</div>
											<p id="donationAmount_error">${donationAmount_error}</p>
										</div>

										<div class="form-outline my-3">
											<label for="bank">Tên ngân hàng: <span
												class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i class='bx bxs-bank'></i></span>
												<input type="text" id="bank" name="bank"
													class="form-control" placeholder="Xin nhập tên ngân hàng"
													value="<c:out value='${inputUser.bank}'/>">
											</div>
											<p id="bank_error">${bank_error}</p>
										</div>

										<div class="form-outline my-3">
											<label for="transactionId">Xin nhập mã giao dịch: <span
												class="require">*</span></label>
											<div class="input-group">
												<span class="input-group-text"><i
													class='bx bx-transfer'></i></span> <input type="text"
													id="transactionId" name="transactionId" class="form-control"
													placeholder="Xin nhập mã giao dịch"
													value="<c:out value='${inputUser.transactionId}'/>">
											</div>
											<p id="transactionId_error">${transactionId_error}</p>
										</div>

									</div>
								</div>
							</div>

							<div class="row justify-content-center donationBtm">
								<div class="col-lg-6 text-center">
									<button
										class="btn btn-primary fa-lg gradient-custom-2 mb-3 donationBtn"
										type="submit" id="submit-button">Quyên góp</button>
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