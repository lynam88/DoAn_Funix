<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${donations == null}">
<c:import url="header.jsp">	
	<c:param name="title" value="Tạo Đợt Quyên Góp"></c:param>	
</c:import>
</c:if>

<c:if test="${donations != null}">
<c:import url="header.jsp">	
	<c:param name="title" value="Cập Nhật Đợt Quyên Góp"></c:param>	
</c:import>
</c:if>

<%
	String notify = (String) request.getAttribute("notifySave");
	String status = (String) request.getAttribute("statusSave");
	
	if(notify != null) {
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
						style="font-size: large; color: red;"><%=notify%></p>
				</div>
			</div>
	
		</div>
	</div>
	
	<script>
		
		$("#insertModal").modal();
		setTimeout(function() {
			$('#insertModal').modal().hide();
			var st = "<%=status%>";
			if (st == "OK") {
				window.location.href = '/HV_SoftwarePackage/DonationsController?action=list';
			}
		}, 3000);
		
	</script>
	
	<%}%>
<div class="container-fluid py-4">
	<div class="row" style="padding-top: 8%;">

			<div class="col-md-8 col-md-offset-2">

				<h1 class="text-center" style="padding-top: 11%;">
					<c:if test="${donations != null}">
                        Cập nhật Đợt Quyên Góp
                    </c:if>
					<c:if test="${donations == null}">
                        Tạo Đợt Quyên Góp
                    </c:if>
				</h1>

				<c:if test="${donations != null}">
					<form action="DonationsController?action=update&page=${page}" method="post">
				</c:if>
				<c:if test="${donations == null}">
					<form action="DonationsController?action=insert" method="post">
				</c:if>

				<c:if test="${donations != null}">
					<input type="hidden" name="id"
						value="<c:out value='${donations.id}' />" />
				</c:if>
				
				<div>
				<c:if test="${donations == null}">
					<div style="float: left; padding-top: 5px;"><p><span class="require" style='color: red;'>(*) Bắt buộc</span></p></div>
					<div class="form-group" style="padding-left: 80%;">
						<label for="title">Trạng Thái <span class="require">*</span></label> <select
							class="form-select form-select-sm" id="status" name="status"
							aria-label=".form-select-sm example">
							<option selected>Xin Lựa Chọn</option>
							<option value="1">Hoàn Thành</option>
							<option value="2">Chưa Hoàn Thành</option>
						</select>
						<p id="status_error" style='color: red;' />
					</div>
				</c:if>

				<c:if test="${donations != null}">
					<div style="float: left; padding-top: 5px;"><p><span class="require" style='color: red;'>(*) Bắt buộc</span></p></div>
					<div class="form-group" style="padding-left: 80%;">
						<label for="title">Trạng Thái <span class="require">*</span> </label> <select
							class="form-select form-select-sm" id="status" name="status"
							aria-label=".form-select-sm example">
							<option value="0" selected>Xin Lựa Chọn </option>
							<option value="1"
								<c:if test="${donations.status == 1}">selected</c:if>>Hoàn
								Thành</option>
							<option value="2"
								<c:if test="${donations.status == 2}">selected</c:if>>Chưa
								Hoàn Thành</option>
						</select>
						<p id="status_error" style='color: red;' />
					</div>
				</c:if>
				</div>

				<div class="form-group">
					<label for="title">Tiêu Đề Bài Viết <span class="require">*</span></label>
					<input type="text" class="form-control" id="title" name="title"
						value="<c:out value='${donations.title}'/>" />
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
							value="<c:out value='${donations.startDate}'/>" /> <input
							type="date" class="form-control" name="endDate"
							style="width: 45%; float: right; margin-top: 0;" id="endDate"
							value="<c:out value='${donations.endDate}'/>" />
					</div>
					<p id="date1_error" style='color: red; padding-top: 6%;' />
					<p id="date2_error" style='color: red;' />
				</div>
				<div class="form-group">
					<label for="title" style="margin-top: 1%;">Tổng Số Tiền Cần
						Quyên Góp (VNĐ) <span class="require">*</span>
					</label>
					<fmt:formatNumber type="number" pattern="0"
						value="${donations.totalNeeded}" var="myNum" />
					<input type="text" id="totalNeeded" name="totalNeeded" onfocusin="removeFormat()" onfocusout="addFormat()" 
						style="width: 45%;" class="form-control"
						value="${myNum}" />
					<p id="totalNeeded_error" style='color: red;' />
				</div>

				<div class="form-group">
					<label for="thumbnail">Hình Đại Diện </label>
					<textarea class="form-control" id="thumbnail"
						name="thumbnail">${donations.src}</textarea>
				</div>

				<div class="form-group">
					<label for="content">Nội dung <span class="require">*</span></label>
					<textarea class="form-control" id="content" name="content">${donations.content}</textarea>
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
					<c:if test="${donations != null}">
						<button type="submit" class="btn btn-primary" onclick="return validateFunction()">Sửa Bài Viết</button>
					</c:if>
					<c:if test="${donations == null}">
						<button type="submit" class="btn btn-primary"
							onclick="validateFunction()">Tạo Bài Viết</button>
					</c:if>
					<button type="button" class="btn btn-success" 
						onclick="return resetFunction()">Nhập Lại Dữ Liệu</button>
					<a type="button" class="btn btn-default"
						href="/HV_SoftwarePackage/DonationsController?action=list">Hủy</a>
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