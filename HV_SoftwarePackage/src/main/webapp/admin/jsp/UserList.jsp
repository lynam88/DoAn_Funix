<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Danh Sách Người Dùng"></c:param>
</c:import>

<%
	String notifyUsersDonationList = (String) request.getAttribute("notifyUsersDonationList");
	String notifyStatusUsersDonationList = (String) request.getAttribute("notifyStatusUsersDonationList");

	if (notifyUsersDonationList != null) {
%>
<div class="modal" id="userDelModal" role="dialog">
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
					style="font-size: large; color: red;"><%=notifyUsersDonationList%></p>
			</div>
		</div>

	</div>
</div>

<script>
		setTimeout(function() {
			$("#userDelModal").modal("show");							
		}, 500);
		setTimeout(function() {			
			var st = "<%=notifyStatusUsersDonationList%>";
				$("#userDelModal").modal("hide");
				if (st == "ok") {
					window.location.href = '/HV_SoftwarePackage/ManageUsersController?action=UserList';
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
			<div class="card mb-4">

				<div id="clock"></div>

				<p class="pageTitle">
					<b>DANH SÁCH NGƯỜI DÙNG:</b>
				</p>

				<form class="searchbar" name="searchform"
					action="${pageContext.request.contextPath}/ManageUsersController?action=UserSearch"
					method="post">

					<input type="text" id="myInput" name="myInput" var="myInput"
						placeholder="Nhập từ khoá..." value="${searchText}"> <select
						id="searchRole" name="searchRole">
						<option value="0" selected>Tất cả</option>
						<option value="1"
							<c:if test="${searchRole == 1}">selected</c:if>>Admin</option>
						<option value="2"
							<c:if test="${searchRole == 2}">selected</c:if>>User</option>
					</select>
					<select id="searchStatus" name="searchStatus">
						<option value="0" selected>Trạng Thái</option>
						<option value="1"
						<c:if test="${searchStatus == 1}">selected</c:if>>Bị khoá</option>
						<option value="2"
						<c:if test="${searchStatus == 2}">selected</c:if>>Hoạt động</option>
					</select>
					<button class="btn nv btn-primary" id="searchButton">
						<i class="fa fa-search"></i> Tìm kiếm
					</button>

				</form>
				<p class="pageTitle">
					<b>CHỨC NĂNG CHÍNH:</b>
				</p>
				<div class="pageTitle">

					<a class="btn nv btn-primary pageBtn" type="button"
						onclick="sortTable()" data-toggle="tooltip" data-placement="top">
						<i class="fa fa-filter" aria-hidden="true"></i> Sắp Xếp
					</a> <a class="btn nv btn-primary functionBtn"
						href="${pageContext.request.contextPath}/ManageUsersController?action=export"><i
						class="fas fa-file-export"></i> Xuất File</a>

					<div class="modal" id="exportModal" role="dialog">
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
									<p class="text-center" id="exportMsg"
										style="font-size: large; color: red;"></p>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="card-body px-0 pt-0 pb-2">
					<div class="p-0">
						<form action="" method="post" id="formDel">
							<input type="hidden" name="email" id="email" value="${email}">
							<table class="table table-bordered" id="myTable">
								<thead class="text-center">
									<tr>
										<th style="width: 2%;">Chọn</th>
										<th style="width: 3%;">Admin</th>
										<th style="width: 6%;">Họ và tên</th>
										<th style="width: 9%;">Email</th>
										<th style="width: 5%;">Phone</th>
										<th style="width: 9%;">Địa Chỉ</th>
										<th style="width: 3%;">Hoạt động</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="user" items="${UserList}">
										<tr>
											<c:choose>
												<c:when test="${user.role == 0 || user.role == 1}">
													<td><input type="checkbox" class="chk" name="chk"
														disabled value="<c:out value='${user.email}'/>"></td>
												</c:when>
												<c:otherwise>
													<td><input type="checkbox" class="chk" name="chk"
														value="<c:out value='${user.email}'/>"></td>
												</c:otherwise>
											</c:choose>
											<td>
												<div class="form-check form-switch">
													<input class="form-check-input role_chk" type="checkbox"
														role="switch" value="<c:out value='${user.email}'/>"
														<c:if test="${user.role == 0}">checked disabled</c:if> 
														<c:if test="${user.role == 1}">checked</c:if> 
														<c:if test="${sessionScope.user.role == 1 && user.role == 1}">disabled</c:if> />
												</div>
											</td>
											<!--Modal -->
											<div class="modal" id="role_confirm" role="dialog">
												<div class="modal-dialog modal-dialog-centered"
													tabindex="-1 role="document">
													<!--Modal content -->
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																id="close_role_confirm">&times;</button>
														</div>
														<div class="modal-body">
															<p style="font-size: large;">Bạn muốn chuyển vai trò người dùng?</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-ok btn-danger"
																id="ok_role_confirm" data-dismiss="modal" style="margin-bottom: 0;">Chấp nhận</button>
															<button type="button" class="btn btn-default btn-success"
																id="cancel_role_confirm" data-dismiss="modal">Hủy</button>
														</div>
													</div>
												</div>
											</div>
											
											<div class="modal" id="role_notify" role="dialog">
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
															<p class="text-center" id="role_msg"
																style="font-size: large; color: red;"></p>
														</div>
													</div>
												</div>
											</div>
											<td>
												<div>${user.name}</div>
											</td>
											<td>
												<div>${user.email}</div>
											</td>
											<td><c:out value="${user.phone}" /></td>
											<td><c:out value="${user.address}" /></td>
											<td>
												<div class="form-check form-switch">
													<input class="form-check-input status_chk" type="checkbox"
														role="switch" value="<c:out value='${user.email}'/>"
														<c:if test="${user.role == 0}">checked disabled</c:if>
														<c:if test="${user.status == 2}">checked</c:if>
														<c:if test="${sessionScope.user.role == 1 && user.role == 1}">disabled</c:if> />
												</div>
											</td>
											<!--Modal -->
											<div class="modal" id="status_confirm" role="dialog">
												<div class="modal-dialog modal-dialog-centered"
													tabindex="-1 role="document">
													<!--Modal content -->
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																id="close_status_confirm">&times;</button>
														</div>
														<div class="modal-body">
															<p style="font-size: large;">Bạn muốn khoá/mở khoá tài khoản này?</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-ok btn-danger"
																id="ok_status_confirm" data-dismiss="modal" style="margin-bottom: 0;">Chấp nhận</button>
															<button type="button" class="btn btn-default btn-success"
																id="cancel_status_confirm" data-dismiss="modal">Hủy</button>
														</div>
													</div>
												</div>
											</div>
											<div class="modal" id="status_notify" role="dialog">
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
															<p class="text-center" id="status_msg"
																style="font-size: large; color: red;"><%=notifyUsersDonationList%></p>
														</div>
													</div>
												</div>
											</div>											
										</tr>
									</c:forEach>
								</tbody>
							</table>
			
							<nav aria-label="..." class="page">
								<ul class="pagination">

									<li class="page-item"><a type="button"
										class="btn page-link"
										href="${pageContext.request.contextPath}/ManageUsersController?action=UserList&myInput=${searchText}&searchRole=${searchRole}&searchStatus=${searchStatus}&page=1"
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
													href="${pageContext.request.contextPath}/ManageUsersController?action=UserList&myInput=${searchText}&searchRole=${searchRole}&searchStatus=${searchStatus}&page=${i}">${i}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<li class="page-item"><a type="button"
										class="btn page-link"
										href="${pageContext.request.contextPath}/ManageUsersController?action=UserList&myInput=${searchText}&searchRole=${searchRole}&searchStatus=${searchStatus}&page=${noOfPage}">Last</a>
									</li>

								</ul>
							</nav>
							<div class="pageTitle">
								<input type="button" class="btn btn-success" onclick='selects()'
									value="Chọn Tất Cả" /> <input type="button"
									class="btn btn-success" onclick='deSelect()'
									value="Bỏ Chọn Tất Cả" "/>
								<div>
									<a type="button" class="btn btn-danger deleteBtn" id="user_del"
										title="Xóa" data-toggle="tooltip"><i class="fa fa-trash-o"
										aria-hidden="true"></i> Xoá các mục đã chọn</a>
								</div>
							</div>

							<!--Modal -->
							<div class="modal" id="myModal" role="dialog">
								<div class="modal-dialog modal-dialog-centered"
									tabindex="-1 role="document">
									<!--Modal content -->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												id="close_user_del">&times;</button>
										</div>
										<div class="modal-body">
											<p style="font-size: large;">Bạn thật sự muốn xóa?</p>
										</div>
										<div class="modal-footer">
											<button type="submit" class="btn btn-ok btn-danger"
												id="ok_user_del" data-dismiss="modal">Chấp nhận</button>
											<button type="button" class="btn btn-default btn-success"
												id="cancel_user_del" data-dismiss="modal">Hủy</button>
										</div>
									</div>
								</div>
							</div>
							<div class="modal" id="showDelete" role="dialog">
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
											<p class="text-center" id="showMsg"
												style="font-size: large; color: red;"></p>
										</div>
									</div>

								</div>
							</div>

							<div class="modal" id="checkMsg" role="dialog">
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
											<p class="text-center" id="checkMsg"
												style="font-size: large; color: red;">Vui lòng chọn mục
												để xoá.</p>
										</div>
									</div>

								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:import url="footer.jsp"></c:import>