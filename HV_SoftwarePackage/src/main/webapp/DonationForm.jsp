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
</head>

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

				<c:if test="${donations == null}">
					<div class="form-group text-right">
						<label for="title">Trạng Thái: </label> <select
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
					<div class="form-group text-right">
						<label for="title">Trạng Thái: </label> <select
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

				<div class="form-group">
					<label for="title">Tiêu Đề Bài Viết <span class="require">*</span></label>
					<input type="text" class="form-control" id="title" name="title"
						value="<c:out value='${donations.title}'/>" />
					<p id="title_error" style='color: red;' />
				</div>

				<div class="form-group">
					<label for="title">Ngày Bắt Đầu <span class="require">*</span></label>
					<input type="date" class="form-control" name="startDate"
						id="startDate" value="<c:out value='${donations.startDate}'/>" />
					<p id="date1_error" style='color: red;' />
				</div>

				<div class="form-group">
					<label for="title">Ngày Kết Thúc <span class="require">*</span></label>
					<input type="date" class="form-control" name="endDate" id="endDate"
						value="<c:out value='${donations.endDate}'/>" />
					<p id="date2_error" style='color: red;' />
				</div>

				<div class="form-group">
					<label for="title">Tổng Số Tiền Cần Quyên Góp <span
						class="require">*</span></label>
					<fmt:formatNumber type="number" pattern="0.00"
						value="${donations.totalNeeded}" var="myNum" />
					<input type="number" min="0" id="totalNeeded" name="totalNeeded"
						pattern="0.00" step=".01" required value="${myNum}" />
					<p id="totalNeeded_error" style='color: red;' />
				</div>

				<div class="form-group">
					<label for="thumbnail">Hình Đại Diện </label>
					<textarea type="text" class="form-control" id="thumbnail"
						name="thumbnail"><img src="media/${donations.id}-1.jpg"></textarea>

				</div>

				<div class="form-group">
					<label for="content">Nội dung <span class="require">*</span></label>
					<textarea rows="30" class="form-control" id="content"
						name="content">${donations.content}</textarea>
					<p id="content_error" style='color: red;' />
				</div>

				<div class="form-group">
					<p>
						<span class="require">*</span> Bắt buộc
					</p>
				</div>

				<div class="form-group">
					<button type="submit" class="btn btn-primary"
						onclick="return validateFunction()">Lưu Bài Viết</button>
					<button class="btn btn-default">Hủy</button>
				</div>

				</form>
			</div>

		</div>
	</div>
	<%@ include file="footer.jsp"%>

</body>
</html>