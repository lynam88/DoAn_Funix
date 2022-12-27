<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
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

<script src="<c:url value='/ckeditor/ckeditor.js' />"></script>

</head>

<body onload="time()">
	<script type="text/javascript">
		swal("Xin Chào Admin", "Chúc Bạn 1 Ngày Tốt Lành Nhé", "");
	</script>
	<%@ include file="header.jsp"%>
	<div class="container-fluid al">
		<div id="clock"></div>
		<Br>
		<p>
			<b>TÌM KIẾM ĐỢT QUYÊN GÓP:</b>
		</p>
		<input type="text" id="myInput" onkeyup="myFunction()"
			placeholder="Nhập từ khoá...">


		<form action=""></form>
		<b>CHỨC NĂNG CHÍNH:</b><Br>
		<button onclick="window.open('./newpost.jsp', '_self');" class="nv btn add-new"
			type="button" data-toggle="tooltip" data-placement="top"
			title="Thêm Đợt Quyên Góp">
			<i class="fa fa-plus-square"></i>
		</button>
		<button class="nv" type="button" onclick="sortTable()"
			data-toggle="tooltip" data-placement="top" title="Sắp Xếp Dữ Liệu">
			<i class="fa fa-filter" aria-hidden="true"></i>
		</button>
		<button class="nv" data-toggle="tooltip" data-placement="top"
			title="Xuất File">
			<i class="fas fa-file-export"></i>
		</button>
		<button class="nv cog" data-toggle="tooltip" data-placement="top"
			title="Cài Đặt">
			<i class="fas fa-cogs"></i>
		</button>
		<div class="table-title">
			<div class="row"></div>

		</div>
		<table class="table table-bordered" id="myTable">
			<thead>
				<tr class="ex">
					<th width="5%;">ID</th>
					<th width="30%;">Tên Đợt Quyên Góp</th>
					<th width="45%;">Nội Dung</th>
					<th width="10%;">Ngày Bắt Đầu</th>
					<th width="10%;">Ngày Kết Thúc</th>
					<th width="5px; !important">Tính Năng</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>Chung tay quyên góp hỗ trợ mái che và sân trường cho các
						em học sinh tại vùng xa thuộc tỉnh Bình Thuận</td>
					<td></td>
					<td>20/10/2022</td>

					<td>20/12/2022</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
			</tbody>
		</table>
		<div id="pageNavPosition" class="text-right"></div>
		<script type="text/javascript">
			var pager = new Pager('myTable', 5);
			pager.init();
			pager.showPageNav('pager', 'pageNavPosition');
			pager.showPage(1);
		</script>
	</div>
	<hr class="hr1">

	<%@ include file="footer.jsp"%>

</body>
</html>