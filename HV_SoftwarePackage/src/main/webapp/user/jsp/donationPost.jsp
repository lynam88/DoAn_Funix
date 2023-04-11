<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Chi tiết đợt quyên góp | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

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
							Chủ</a></span> <span>Chi tiết đợt quyên góp</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Chi
					tiết đợt quyên góp</h1>
			</div>
		</div>
	</div>
</div>
<!--Modal -->
<div class="modal fade" id="makeDonationNotify" role="dialog">
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
				<p class="text-center" id="makeDonationMsg"
					style="font-size: large; color: red;"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>


<section class="ftco-section ftco-degree-bg">
	<div class="container-fluid" id="donationPost">
		<div class="row">
			<div class="col-md-12">
				<p class="text-left insertDate">
					<c:out value="${donation.insertDate}"></c:out>
				</p>
			</div>
		</div>
		<div class="row donationPost container-fluid">
			<div class="col-xl-6 ftco-animate">
				<h2 class="mb-3 text-primary">${donation.title}</h2>
				${donation.content}
			</div>

			<div class="col-xl-6 sidebar ftco-animate">
				<div class="sidebar-box donationInfo">
					<div class="item">
						<div class="cause-entry">
						<input type="hidden" value='${donation.donationId}' name="donationId">
							<div class="row text p-3 p-md-4">
								<div>
									<h2 class="text-primary">Thông tin quyên góp</h2>
									<c:if test="${donation.status == 1}">
										<p class="text-success font-weight-bold">Hoàn Thành</p>
									</c:if>
									<c:if test="${donation.status == 2}">
										<p class="text-success font-weight-bold">Chưa Hoàn Thành</p>
									</c:if>
								</div>
								<span class="donation-time mb-3 d-block recentDonation"> Quyên góp mới
										nhất cách đây <c:out value="${donation.dayDiff}"></c:out> ngày </span>
								<div class="progress custom-progress-success donationBar">
									<div class="progress-bar bg-primary" role="progressbar"
											style="width: ${((donation.donationAmount/donation.totalNeeded)*100)}%;"
											aria-valuemax="100"></div>
								</div>
								<fmt:formatNumber type="number" pattern="#,##0"
									value="${donation.totalNeeded}" var="myNum" />
								<div>
									<span class="fund-raised d-block float-left leftText">
											Đã quyên góp được <fmt:formatNumber type="number" pattern="#,##0"
										value="${donation.donationAmount}"/> VNĐ trên tổng số tiền <fmt:formatNumber type="number" pattern="#,##0"
										value="${donation.totalNeeded}" />
											VNĐ
										</span>
									<c:if test="${donation.status == 1}">
										<a
											href="${pageContext.request.contextPath}/UsersDonationController?action=donations"
											class="btn btn-info float-right" role="button"
											aria-pressed="true">Hoàn cảnh mới nhất</a>
									</c:if>
									<c:if test="${donation.status == 2}">
										<button class="btn btn-primary float-right"
											id="FirstDonationBtn" aria-pressed="true">Quyên góp</button>
									</c:if>
								</div>
							</div>
							<form class="row makeDonationForm" id="makeDonationForm">
								<input type="hidden" value='${donation.donationId}' id="donationId" name="donationId">					
								<div class="row">
									<div class="col-md-6">
										<div class="card-body p-md-5 leftDonation">
											<span class="require">(*) Bắt buộc</span>
											<div class="form-outline my-3">
												<label for="name">Họ và tên: <span class="require">*</span></label>
												<div class="input-group">
													<span class="input-group-text"><i class="bx bx-user"></i></span>
													<input type="text" id="name" name="name"
														class="form-control"														
														<c:if test="${user != null}">value="<c:out value='${user.name}'/>"</c:if>>
												</div>
												<p id="name_error"></p>
											</div>

											<div class="form-outline my-3">
												<label for="phone">Số điện thoại: <span
													class="require">*</span></label>
												<div class="input-group">
													<span class="input-group-text"><i
														class="bx bx-phone"></i></span> <input type="text" id="phone"
														name="phone" class="form-control"
														<c:if test="${user != null}">value="<c:out value='${user.phone}'/>"</c:if>>
												</div>
												<p id="phone_error">${phone_error}</p>

											</div>
											<div class="form-outline my-3">
												<label for="email">Email: <span class="require">*</span></label>
												<div class="input-group">
													<span class="input-group-text"><i
														class="bx bx-envelope"></i></span> <input type="email" id="email"
														name="email" class="form-control"
														<c:if test="${user != null}">value="<c:out value='${user.email}'/>"</c:if>>
												</div>
												<p id="email_error">${email_error}</p>
											</div>

										</div>

									</div>
									<div class="col-md-6">
										<div class="card-body p-md-5 rightDonation">
											<div class="form-outline my-3">
												<label for="donationAmount">Xin nhập số tiền: <span
													class="require">*</span>
												</label>
												<div class="input-group">
													<span class="input-group-text"><i
														class='bx bx-donate-heart'></i></span> <input type="text"
														id="donationAmount" name="donationAmount"
														class="form-control" onfocus="removeFormat()" onblur="addFormat()"
														value="<c:out value='${inputUser.donationAmount}'/>"><span
														class="input-group-text"><i>VNĐ</i></span>
												</div>
												<p id="donationAmount_error">${donationAmount_error}</p>
											</div>

											<div class="form-outline my-3">
												<label for="bank">Tên ngân hàng: <span
													class="require">*</span></label>
												<div class="input-group">
													<span class="input-group-text"><i
														class='bx bxs-bank'></i></span> <input type="text" id="bank"
														name="bank" class="form-control">
												</div>
												<p id="bank_error">${bank_error}</p>
											</div>

											<div class="form-outline my-3">
												<label for="transactionId">Xin nhập mã giao dịch: <span
													class="require">*</span></label>
												<div class="input-group">
													<span class="input-group-text"><i
														class='bx bx-transfer'></i></span> <input type="text"
														id="transactionId" name="transactionId"
														class="form-control"
														value="<c:out value='${inputUser.transactionId}'/>">
												</div>
												<p id="transactionId_error">${transactionId_error}</p>
											</div>

										</div>
									</div>
								</div>

								<div class="text-center donationBtm">
									<button class="btn btn-primary fa-lg gradient-custom-2 mb-3"
										type="button" id="secondDonationBtn" onclick="makeDonation()">Xác nhận</button>
								</div>
							</form>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
<!-- .section -->

<c:import url="footer.jsp"></c:import>