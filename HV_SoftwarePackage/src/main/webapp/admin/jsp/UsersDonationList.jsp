<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Danh Sách Người Dùng Quyên Góp"></c:param>
</c:import>

<%
String notifyUsersDonationList = (String) request.getAttribute("notifyUsersDonationList");
String notifyStatusUsersDonationList = (String) request.getAttribute("notifyStatusUsersDonationList");

if (notifyUsersDonationList != null) {
%>
<div class="modal" id="userDonationDelModal" role="dialog">
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
				<p class="text-center" style="font-size: large; color: red;"><%=notifyUsersDonationList%></p>
			</div>
		</div>

	</div>
</div>

<script>
		setTimeout(function() {
			$("#userDonationDelModal").modal("show");							
		}, 500);
		setTimeout(function() {			
			var st = "<%=notifyStatusUsersDonationList%>";
				$("#userDonationDelModal").modal("hide");
				if (st == "ok") {
					window.location.href = '/HV_SoftwarePackage/UsersDonationController?action=UsersDonationList';
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

<div class="container-fluid py-4">
	<div class="row">
		<div class="col-12">
			<div class="card mb-4 UDLContent">

				<div id="clock"></div>

				<p class="pageTitle">
					<b>DANH SÁCH NGƯỜI DÙNG QUYÊN GÓP:</b>
				</p>

				<form class="searchbar" name="searchform"
					action="${pageContext.request.contextPath}/UsersDonationController?action=UsersDonationSearch"
					method="post">

					<input type="text" id="myInput" name="myInput" var="myInput"
						placeholder="Nhập từ khoá..." value="${searchText}"> <select
						id="searchStatus" name="searchStatus">
						<option value="0" selected>Trạng Thái</option>
						<option value="1"
							<c:if test="${searchStatus == 1}">selected</c:if>>Từ
							chối</option>
						<option value="2"
							<c:if test="${searchStatus == 2}">selected</c:if>>Đang
							chờ</option>
						<option value="3"
							<c:if test="${searchStatus == 3}">selected</c:if>>Đã xác
							thực</option>
					</select>
					<button class="btn nv btn-primary" id="searchButton">
						<i class="fa fa-search"></i> Tìm kiếm
					</button>

				</form>
				<p class="pageTitle">
					<b>CHỨC NĂNG CHÍNH:</b>
				</p>
				<div class="pageTitle">
					<div class="leftButtons">
						<a class="btn nv btn-primary pageBtn" type="button"
							onclick="sortTable()" data-toggle="tooltip" data-placement="top">
							<i class="fa fa-filter" aria-hidden="true"></i> Sắp Xếp
						</a> <a class="btn nv btn-primary"
							href="${pageContext.request.contextPath}/UsersDonationController?action=export"><i
							class="fas fa-file-export"></i> Xuất File</a>
					</div>
					<div classs="text-right">
						<p id="statusNote">Ghi chú: R: Từ chối, P: Đang chờ, A: Đã xác thực</p>
					</div>
				</div>

				<div class="card-body px-0 pt-0 pb-2">
					<div class="p-0">
						<form action="" method="post" id="formDel">
							<input type="hidden" name="email" id="email" value="${email}">

							<table class="table table-hover" id="myTable">
								<thead class="text-center">
									<tr>
										<th style="width: 5%;">Họ và tên</th>
										<th style="width: 7%;">Email</th>
										<th style="width: 5%;">Phone</th>
										<th style="width: 5%;">Ngân hàng</th>
										<th style="width: 6%;">Mã giao dịch</th>
										<th style="width: 4%;">Số tiền</th>
										<th style="width: 5%;">Trạng thái</th>
										<th style="width: 7%;">Đợt quyên góp</th>
										<th style="width: 4%;">Ngày</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="user" items="${UsersDonationList}">
										<tr>
											<td>
												<div>
													<c:out value="${user.name}" />
												</div>
											</td>
											<td>
												<div>
													<c:out value="${user.email}" />
												</div>
											</td>
											<td><c:out value="${user.phone}" /></td>
											<td><c:out value="${user.bank}" /></td>
											<td><c:out value="${user.transactionId}" /></td>
											<td><fmt:formatNumber type="number" pattern="0"
													value="${user.donationAmount}" /></td>
											<td id="statusSwitch">
												<div class="tri-state-toggle">
													<input type="hidden" class="userDonationId"
														value="${user.userDonationId}"> <input
														type="hidden" name="email" id="email"
														value="${user.email}">

													<button type="button"
														class="tri-state-toggle-button <c:if test="${user.userDonationStatus == 1}">active</c:if> "
														onclick="activateButton(this)" <c:if test="${sessionScope.user.email == user.email}">disabled</c:if>>R</button>

													<button type="button"
														class="tri-state-toggle-button <c:if test="${user.userDonationStatus == 2}">active</c:if> "
														onclick="activateButton(this)" <c:if test="${sessionScope.user.email == user.email}">disabled</c:if>>P</button>

													<button type="button"
														class="tri-state-toggle-button <c:if test="${user.userDonationStatus == 3}">active</c:if> "
														onclick="activateButton(this)" <c:if test="${sessionScope.user.email == user.email}">disabled</c:if>>A</button>
												</div>
											</td>
											<!--Modal -->
											<div class="modal" id="user_donation_status_confirm" role="dialog">
												<div class="modal-dialog modal-dialog-centered"
													tabindex="-1 role="document">
													<!--Modal content -->
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																id="close_user_donation_status_confirm">&times;</button>
														</div>
														<div class="modal-body">
															<p style="font-size: large;">Bạn muốn chuyển trạng
																thái quyên góp này?</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-ok btn-danger"
																id="ok_user_donation_status_confirm" data-dismiss="modal"
																style="margin-bottom: 0;">Chấp nhận</button>
															<button type="button" class="btn btn-default btn-success"
																id="cancel_user_donation_status_confirm" data-dismiss="modal">Hủy</button>
														</div>
													</div>
												</div>
											</div>
											<div class="modal" id="user_donation_status_notify" role="dialog">
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
															<p class="text-center" id="user_donation_status_msg"
																style="font-size: large; color: red;"><%=notifyUsersDonationList%></p>
														</div>
													</div>
												</div>
											</div>
											<td>
												<div>
													<input type="hidden" id="donationId"
														value="${user.donationId}">
													<input type="hidden" id="donationTitle"
														value="${user.donationTitle}">
													<div class="content hideContent">${user.donationTitle}</div>
													<div class="show-more">
														<a type="button" style="color: blue;">Hiển thị thêm</a>
													</div>
												</div>
											</td>
											<td><c:out value="${user.donationDate}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

							<nav aria-label="..." class="page">
								<ul class="pagination">

									<li class="page-item"><a type="button"
										class="btn page-link"
										href="${pageContext.request.contextPath}/UsersDonationController?action=UsersDonationList&myInput=${searchText}&searchStatus=${searchStatus}&page=1"
										tabindex="-1">First</a></li>

									<c:forEach var="i" begin="1" end="${noOfPage}">
										<c:choose>
											<c:when test="${currentPage eq i}">
												<li class="page-item active"><a class="page-link">
														${i} <span class="sr-only">(current)</span>
												</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a type="button"
													class="btn page-link"
													href="${pageContext.request.contextPath}/UsersDonationController?action=UsersDonationList&myInput=${searchText}&searchStatus=${searchStatus}&page=${i}">${i}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<li class="page-item"><a type="button"
										class="btn page-link"
										href="${pageContext.request.contextPath}/UsersDonationController?action=UsersDonationList&myInput=${searchText}&searchStatus=${searchStatus}&page=${noOfPage}">Last</a>
									</li>

								</ul>
							</nav>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:import url="footer.jsp"></c:import>