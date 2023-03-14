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
String notifyDonation = (String) request.getAttribute("notifyDonation");
String statusDonation = (String) request.getAttribute("statusDonation");

if (notifyDonation != null) {
%>
<div class="modal" id="donationModal" role="dialog">
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
					style="font-size: large; color: red;"><%=notifyDonation%></p>
			</div>
		</div>

	</div>
</div>

<script>

		$("#donationModal").modal("show");
		setTimeout(function() {
			$('#donationModal').modal().hide();
			var st = "<%=statusDonation%>";
				if (st == "OK") {
					window.location.href = '/HV_SoftwarePackage/DonationsController?action=DonationList';
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
				<form action="DonationsController?action=update&page=${page}"
					method="post" onsubmit="return validateDonation()" enctype="multipart/form-data">
			</c:if>
			<c:if test="${donations == null}">
				<form action="DonationsController?action=insert" method="post"
					onsubmit="return validateDonation()" enctype="multipart/form-data">
			</c:if>

			<c:if test="${donations != null}">
				<input type="hidden" name="id"
					value="<c:out value='${donations.id}' />" />
			</c:if>
			
			<c:if test="${donations == null}">
				<input type="hidden" name="maxId"
					value="<c:out value='${maxId}' />" />
			</c:if>

			<div>
				<c:if test="${donations == null}">
					<div style="float: left; padding-top: 5px;">
						<p>
							<span class="require" style='color: red;'>(*) Bắt buộc</span>
						</p>
					</div>
					<div class="form-group" style="padding-left: 80%;">
						<label for="title">Trạng Thái <span class="require">*</span></label>
						<select class="form-select form-select-sm" id="status"
							name="status" aria-label=".form-select-sm example">
							<option selected>Xin Lựa Chọn</option>
							<option value="1">Hoàn Thành</option>
							<option value="2">Chưa Hoàn Thành</option>
						</select>
						<p id="status_error" />
					</div>
				</c:if>

				<c:if test="${donations != null}">
					<div style="float: left; padding-top: 5px;">
						<p>
							<span class="require" style='color: red;'>(*) Bắt buộc</span>
						</p>
					</div>
					<div class="form-group" style="padding-left: 80%;">
						<label for="title">Trạng Thái <span class="require">*</span>
						</label> <select class="form-select form-select-sm" id="status"
							name="status" aria-label=".form-select-sm example">
							<option value="0" selected>Xin Lựa Chọn</option>
							<option value="1"
								<c:if test="${donations.status == 1}">selected</c:if>>Hoàn
								Thành</option>
							<option value="2"
								<c:if test="${donations.status == 2}">selected</c:if>>Chưa
								Hoàn Thành</option>
						</select>
						<p id="status_error" />
					</div>
				</c:if>
			</div>

			<div class="form-group">
				<div>
					<label for="title">Tiêu Đề Bài Viết <span class="require">*</span></label>
				</div>
				<div>
					<input type="text" class="form-control" id="title" name="title"
					value="<c:out value='${donations.title}'/>" />
				</div>
				<p id="title_error" />
			</div>
			<div class="form-group" style="padding-top: 4%;">
				<div>
					<label for="title">Ngày Bắt Đầu <span class="require">*</span></label>
					<label for="title" style="float: right;">Ngày Kết Thúc <span
						class="require">*</span></label>
				</div>
				<div>
					<input type="date" class="form-control" name="startDate"
						style="width: 45%; float: left; margin-top: 0;" id="startDate"
						value="<c:out value='${donations.startDate}'/>" /> 
					<input type="date" class="form-control" name="endDate"
						style="width: 45%; float: right; margin-top: 0;" id="endDate"
						value="<c:out value='${donations.endDate}'/>" />
					<p id="date1_error" />
					<p id="date2_error" />			
				</div>				
			</div>
			<div class="form-group" style="padding-top: 10%;">
				<div>
					<label for="title">Tổng Số Tiền Cần Quyên Góp (VNĐ) <span
						class="require">*</span>
					</label><label for="title" style="float: right;">Hoàn Cảnh
						Quyên Góp <span class="require">*</span>
					</label>
				</div>
				<div>
					<fmt:formatNumber type="number" pattern="0"
						value="${donations.totalNeeded}" var="myNum" />
					<input type="text" id="totalNeeded" name="totalNeeded"
						onfocusin="removeFormat()" onfocusout="addFormat()"
						style="width: 45%; float: left; margin-top: 0;" class="form-control" value="${myNum}" /> 
					<select class="form-select form-select-sm" id="category" style="width: 45%; float: right; margin-top: 0; font-size: 0.875rem;"
						name="category" aria-label=".form-select-sm example">
						<option value="0" selected>Xin Lựa Chọn</option>					
						<option value="1" <c:if test="${donations.category == 1}">selected</c:if>>Vì Trẻ Em</option>
						<option value="2" <c:if test="${donations.category == 2}">selected</c:if>>Người Già, Người Khuyết Tật</option>
						<option value="3" <c:if test="${donations.category == 3}">selected</c:if>>Bệnh Hiểm Nghèo</option>
						<option value="4" <c:if test="${donations.category == 4}">selected</c:if>>Đầu Tư Cơ Sở Vật Chất</option>
						<option value="5" <c:if test="${donations.category == 5}">selected</c:if>>Bảo Vệ Môi Trường</option>
					</select>
				</div >
				<p id="totalNeeded_error" />
				<p id="category_error" />
			</div>

			<div class="form-group" style="padding-top: 10%;">
				<label for="thumbnail">Hình Đại Diện </label>
				<c:if test="${donations.src != null}"><img src="${donations.src}" alt="Thumbnail" class="thumbnail"></c:if>
				<input type="file" id="thumbnail" name="thumbnail" class="form-control">
				<p/>
			</div>

			<div class="form-group" >
				<label for="content">Nội dung <span class="require">*</span></label>
				<textarea class="form-control" id="content" name="content">${donations.content}</textarea>
				<p id="content_error" />
			</div>

			<section id="sec-1">
				<div class="container">
					<a href="#sec-2">
						<div class="scroll-down"
							style="top: 50%; left: 88%; position: fixed;"></div>
					</a>
				</div>
			</section>

			<div class="form-group" id="sec-2">
				<c:if test="${donations != null}">
					<button type="submit" class="btn btn-primary">Sửa Bài Viết</button>
				</c:if>
				<c:if test="${donations == null}">
					<button type="submit" class="btn btn-primary">Tạo
						Bài Viết</button>
				</c:if>
				<button type="button" class="btn btn-success"
					onclick="return resetFunction()">Nhập Lại Dữ Liệu</button>
				<a type="button" class="btn btn-default"
					href="/HV_SoftwarePackage/DonationsController?action=DonationList">Hủy</a>
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
</div>
	<c:import url="footer.jsp"></c:import>