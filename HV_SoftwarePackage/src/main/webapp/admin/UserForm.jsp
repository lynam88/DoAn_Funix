<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${Users == null}">
<c:import url="header.jsp">	
	<c:param name="title" value="Thêm Người Dùng Mới"></c:param>	
</c:import>
</c:if>

<c:if test="${Users != null}">
<c:import url="header.jsp">	
	<c:param name="title" value="Cập Nhật Người Dùng"></c:param>	
</c:import>
</c:if>

<%
	String notifySave = (String) request.getAttribute("notifySave");
	String statusSave = (String) request.getAttribute("statusSave");
	
	if(notifySave != null) {
	%>
	<div class="modal" id="insertModal" role="dialog">
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
						style="font-size: large; color: red;"><%=notifySave%></p>
				</div>
			</div>
	
		</div>
	</div>
	
	<script>

		$("#insertModal").modal("show");
		setTimeout(function() {
			$('#insertModal').modal().hide();
			var st = "<%=statusSave%>";
			if (st == "OK") {
				window.location.href = '/HV_SoftwarePackage/UsersController?action=UserList';
			} else {
				// remove class modal-backdrop in
				$(".modal-backdrop").removeClass( "modal-backdrop in");
				window.history.back();
			} 
		}, 3000);
		
	</script>
	
	<%}%>
<div class="container-fluid py-4">
	<div class="row" style="padding-top: 8%;">

			<div class="col-md-8 col-md-offset-2">

				<h1 class="text-center" style="padding-top: 11%;">
					<c:if test="${Users != null}">
                        Cập Nhật Người Dùng
                    </c:if>
					<c:if test="${Users == null}">
                        Thêm Người Dùng Mới
                    </c:if>
				</h1>

				<c:if test="${Users != null}">
					<form action="UsersController?action=update&page=${page}" method="post" onsubmit="return validateUser()">
				</c:if>
				<c:if test="${Users == null}">
					<form action="UsersController?action=insert" method="post" onsubmit="return validateUser()">
				</c:if>

				<c:if test="${Users != null}">
					<input type="hidden" name="id"
						value="<c:out value='${Users.id}' />" />
				</c:if>
				
				<div>
				<c:if test="${Users == null}">
					<div style="float: left; padding-top: 5px;"><p><span class="require" style='color: red;'>(*) Bắt buộc</span></p></div>
					<div class="form-group" style="padding-left: 80%;">
						<label for="title">Trạng Thái <span class="require">*</span></label> <select
							class="form-select form-select-sm" id="status" name="status"
							aria-label=".form-select-sm example">
							<option selected>Xin Lựa Chọn</option>
							<option value="1">Admin</option>
							<option value="2">User</option>
						</select>
						<p id="status_error" style='color: red;' />
					</div>
				</c:if>

				<c:if test="${Users != null}">
					<div style="float: left; padding-top: 5px;"><p><span class="require" style='color: red;'>(*) Bắt buộc</span></p></div>
					<div class="form-group" style="padding-left: 80%;">
						<label for="title">Trạng Thái <span class="require">*</span> </label> <select
							class="form-select form-select-sm" id="status" name="status"
							aria-label=".form-select-sm example">
							<option value="0" selected>Xin Lựa Chọn </option>
							<option value="1"
								<c:if test="${Users.status == 1}">selected</c:if>>Hoàn
								Thành</option>
							<option value="2"
								<c:if test="${Users.status == 2}">selected</c:if>>Chưa
								Hoàn Thành</option>
						</select>
						<p id="status_error" style='color: red;' />
					</div>
				</c:if>
				</div>

				<div class="form-group">
					<label for="title">Tiêu Đề Bài Viết <span class="require">*</span></label>
					<input type="text" class="form-control" id="title" name="title"
						value="<c:out value='${Users.title}'/>" />
					<p id="title_error" style='color: red;' />
				</div>
				<div>
					<div>
						<label for="title">Ngày Bắt Đầu <span class="require">*</span></label>
						<label for="title" style="float: right;">Ngày Kết Thúc <span
							class="require">*</span></label>
					</div>
					<div>
						<input type="date" class="form-control" name="startDate"
							style="width: 45%; float: left; margin-top: 0;" id="startDate"
							value="<c:out value='${Users.startDate}'/>" /> <input
							type="date" class="form-control" name="endDate"
							style="width: 45%; float: right; margin-top: 0;" id="endDate"
							value="<c:out value='${Users.endDate}'/>" />
					</div>
					<p id="date1_error" style='color: red; padding-top: 6%;' />
					<p id="date2_error" style='color: red;' />
				</div>
				<div class="form-group">
					<label for="title" style="margin-top: 1%;">Tổng Số Tiền Cần
						Quyên Góp (VNĐ) <span class="require">*</span>
					</label>
					<fmt:formatNumber type="number" pattern="0"
						value="${Users.totalNeeded}" var="myNum" />
					<input type="text" id="totalNeeded" name="totalNeeded" onfocusin="removeFormat()" onfocusout="addFormat()" 
						style="width: 45%;" class="form-control"
						value="${myNum}" />
					<p id="totalNeeded_error" style='color: red;' />
				</div>

				<div class="form-group">
					<label for="thumbnail">Hình Đại Diện </label>
					<textarea class="form-control" id="thumbnail"
						name="thumbnail">${Users.src}</textarea>
				</div>

				<div class="form-group">
					<label for="content">Nội dung <span class="require">*</span></label>
					<textarea class="form-control" id="content" name="content">${Users.content}</textarea>
					<p id="content_error" style='color: red;' />
				</div>				

				<section id="sec-1">
					<div class="container">
						<a href="#sec-2">
							<div class="scroll-down" style="top: 50%;left: 88%;position: fixed;"></div>
						</a>
					</div>
				</section>

				<div class="form-group" id="sec-2">
					<c:if test="${Users != null}">
						<button type="submit" class="btn btn-primary">Sửa Bài Viết</button>
					</c:if>
					<c:if test="${Users == null}">
						<button type="submit" class="btn btn-primary"
							>Tạo Bài Viết</button>
					</c:if>
					<button type="button" class="btn btn-success" 
						onclick="return resetFunction()">Nhập Lại Dữ Liệu</button>
					<a type="button" class="btn btn-default"
						href="/HV_SoftwarePackage/UsersController?action=UserList">Hủy</a>
				</div>
				<div class="modal" id="addModal" role="dialog">
					<div class="modal-dialog">

						Modal content
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<p class="text-center" id="addMsg"
									style="font-size: large; color: red;"></p>
							</div>
						</div>
					</div>
				</div>
				</form>
				
			</div>
		</div>

	<c:import url="footer.jsp"></c:import>