<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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

<title>Quản Lý Đợt Quyên Góp</title>
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
<script src="//code.jquery.com/jquery.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="js/main.js"></script>

</head>

<body onload="time()">
<!-- 	<script type="text/javascript">
	 swal("Xin Chào Admin", "Chúc Bạn 1 Ngày Tốt Lành Nhé", "");
	</script> -->
	<%@ include file="header.jsp"%>
	<div class="container-fluid al">
		<div id="clock"></div>
		<Br>
		<p>
			<b>TÌM KIẾM ĐỢT QUYÊN GÓP:</b>
		</p>
		<form class="searchbar" name="searchform"
			action="ControllerServlet?action=search" method="post">
			<div>
				<input type="text" id="myInput" name="myInput"
					placeholder="Nhập từ khoá..." style="width: 27%;"
					value="${searchText}"> <select id="searchStatus"
					name="searchStatus">
					<option value="0" selected>Tất cả</option>
					<option value="1">Hoàn Thành</option>
					<option value="2">Chưa Hoàn Thành</option>
				</select>
				<button class="btn nv" id="searchButton">
					<i class="fa fa-search" style="position: relative;"></i>Tìm kiếm
				</button>
			</div>
		</form>
		<b>CHỨC NĂNG CHÍNH:</b><Br> 
		<a	class="btn nv" type="button" href="/HV_SoftwarePackage/ControllerServlet?action=new"
			data-toggle="tooltip" data-placement="top"> <i
			class="fa fa-plus-square"></i> Tạo mới 
		</a> 		
				
		<a class="btn nv" type="button" onclick="sortTable()"
			data-toggle="tooltip" data-placement="top"> <i
			class="fa fa-filter" aria-hidden="true"></i> Sắp Xếp
		</a> 
		
		<a class="btn nv" id="export" type="button" data-target="#exportModal" data-toggle="modal"
			data-toggle="tooltip" data-placement="top"> <i
			class="fas fa-file-export"></i> Xuất File
		</a>
		<div class="modal fade" id="exportModal" role="dialog">
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
		<div class="table-title">
			<div class="row"></div>

		</div>
		<table class="table table-bordered" id="myTable">
			<thead>
				<tr class="ex">
					<th width="5%;">Chọn</th>
					<th width="10%;">Trạng Thái</th>
					<th width="15%;">Tên Đợt Quyên Góp</th>
					<th width="45%;">Nội Dung</th>
					<th width="10%;">Ngày Bắt Đầu</th>
					<th width="10%;">Ngày Kết Thúc</th>
					<th width="5%;">Sửa</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="donation" items="${donationList}">
					<tr>
						<td><input type="checkbox" class="donation_id" name="chk"
							value="<c:out value='${donation.id}' />"></td>
						<c:if test="${donation.status == 1}">
							<td>Hoàn Thành</td>
						</c:if>
						<c:if test="${donation.status == 2}">
							<td>Chưa Hoàn Thành</td>
						</c:if>
						<td><c:out value="${donation.title}" /></td>
						<td>
							<div>
								<div class="content hideContent">${donation.content}</div>
								<div class="show-more">
									<a href="#">Hiển thị thêm</a>
								</div>
							</div>
						</td>
						<td><c:out value="${donation.startDate}" /></td>
						<td><c:out value="${donation.endDate}" /></td>
						<td><a class="edit btn"
							href="ControllerServlet?action=edit&id=${donation.id}"
							title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
								aria-hidden="true"></i></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<input type="button" class="btn btn-success" onclick='selects()' value="Chọn Tất Cả"/>  
        <input type="button" class="btn btn-success" onclick='deSelect()' value="Bỏ Chọn Tất Cả""/>
		<div>
		<a type="button" class="btn btn-danger" data-toggle="modal" style="position: relative; margin-top: 1%; width: 15%;"
			data-target="#myModal" title="Xóa" data-toggle="tooltip"><i
			class="fa fa-trash-o" aria-hidden="true"></i> Xoá các mục đã chọn</a> </div>
		<input type="hidden" id="donation_id" value="<c:out value='${donation.id}' />" />
		<!--Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-dialog-centered" tabindex="-1 role="document">
				<!--Modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<p style="font-size: large;">Bạn thật sự muốn xóa?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-ok btn-danger" id="ok_del"
							data-dismiss="modal">Chấp nhận</button>
						<button type="button" class="btn btn-default btn-success"
							data-dismiss="modal">Hủy</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="showMsg" role="dialog">
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
						<p class="text-center" id="cntMsg"
							style="font-size: large; color: red;"></p>
					</div>
				</div>

			</div>
		</div>
		<div class="row text-right" id="pageNavPosition">

			<a class="page-link rounded-circle border-info"
				href="/HV_SoftwarePackage/ControllerServlet?action=list&myInput=${searchText}&page=1"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span> <span
				class="sr-only">First Page</span>
			</a>

			<c:forEach var="i" begin="1" end="${noOfPage}">

				<c:choose>
					<c:when test="${currentPage eq i}">
						<button class="btn btn-outline-info rounded-circle" disabled>${i}</button>
					</c:when>
					<c:otherwise>
						<a class="btn btn-outline-info rounded-circle"
							href="/HV_SoftwarePackage/ControllerServlet?action=list&myInput=${searchText}&page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>

			</c:forEach>

			<a class="page-link rounded-circle border-info"
				href="/HV_SoftwarePackage/ControllerServlet?action=list&myInput=${searchText}&page=${noOfPage}"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
				class="sr-only">Last Page</span>
			</a>

		</div>
	</div>
	<hr class="hr1">

	<%@ include file="footer.jsp"%>

</body>
</html>