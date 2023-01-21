<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="/HV_SoftwarePackage/css/project.css">
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet"
	integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
	crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>Đợt Quyên Góp</title>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	crossorigin="anonymous">
<!--===============================================================================================-->
<link rel="stylesheet" href="css/style.css">
<!-- Latest compiled and minified CSS -->
<!--===============================================================================================-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<!-- jQuery library -->
<!--===============================================================================================-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<!--===============================================================================================-->
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
<!--===============================================================================================-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
<!--===============================================================================================-->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<!--===============================================================================================-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>

<script src="https://cdn.ckeditor.com/4.20.1/full/ckeditor.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
<script src="//code.jquery.com/jquery.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>
<%
String notify = (String) request.getAttribute("notifySave");
String status = (String) request.getAttribute("statusSave");

if(notify != null) {
%>
<div class="modal fade" id="insertModal">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
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
			window.location.href = '/HV_SoftwarePackage/ControllerServlet';
		}
	}, 3000);
	$(".modal-backdrop").remove();
</script>

<%}%>

<body>

	<%@ include file="header.jsp"%>
	<div class="container">
		<div class="row">

			<div class="col-md-8 col-md-offset-2">

				<h1 class="text-center" style="padding-top: 10%;">
					<c:if test="${donations != null}">
                        Sửa Đợt Quyên Góp
                    </c:if>
					<c:if test="${donations == null}">
                        Tạo Đợt Quyên Góp
                    </c:if>
				</h1>

				<c:if test="${donations != null}">
					<form action="ControllerServlet?action=update" method="post">
				</c:if>
				<c:if test="${donations == null}">
					<form action="ControllerServlet?action=insert" method="post">
				</c:if>

				<c:if test="${donations != null}">
					<input type="hidden" name="id"
						value="<c:out value='${donations.id}' />" />
				</c:if>
				
				<div>
				<c:if test="${donations == null}">
					<div style="float: left; padding-top: 5px;"><p><span class="require" style='color: red;'>(*) Bắt buộc</span></p></div>
					<div class="form-group text-right">
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
					<div class="form-group text-right">
						<label for="title">Trạng Thái <span class="require">*</span> </label> <select
							class="form-select form-select-sm" id="status" name="status"
							aria-label=".form-select-sm example">
							<option value="1"
								<c:if test="${donations.status == 1}">selected</c:if>>Hoàn
								Thành</option>
							<option value="2"
								<c:if test="${donations.status == 2}">selected</c:if>>Chưa
								Hoàn Thành</option>
						</select>
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
						Quyên Góp <span class="require">*</span>
					</label>
					<fmt:formatNumber type="number" pattern="0.00"
						value="${donations.totalNeeded}" var="myNum" />
					<input type="number" min="0" id="totalNeeded" name="totalNeeded"
						style="width: 45%;" class="form-control" pattern="0.00" step=".01"
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
							<div class="scroll-down" style="top: 50%;left: 97%;position: fixed;"></div>
						</a>
					</div>
				</section>

				<div class="form-group" id="sec-2">
					<c:if test="${donations != null}">
						<button type="submit" class="btn btn-primary" onclick="return validateFunction()">Sửa Bài Viết</button>
					</c:if>
					<c:if test="${donations == null}">
						<button type="submit" class="btn btn-primary"
							onclick="return validateFunction()">Tạo Bài Viết</button>
					</c:if>
					<button type="submit" class="btn btn-success"
						onclick="return resetFunction()">Nhập Lại Dữ Liệu</button>
					<a type="button" class="btn btn-default"
						href="/HV_SoftwarePackage/ControllerServlet?action=list">Hủy</a>
				</div>
				<div class="modal fade" id="addModal" role="dialog">
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

	<%@ include file="footer.jsp"%>

	<script type="text/javascript">
		//Ckeditor
		var content = '';
		var thumbnail = '';
		$(document).ready(function() {
			content = CKEDITOR.replace('content');
			thumbnail = CKEDITOR.replace('thumbnail');
			CKFinder.setupCKEditor(content, 'ckfinder/');
			CKFinder.setupCKEditor(thumbnail, 'ckfinder/');
		});
	</script>
</body>
</html>