<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
        
</head>

<body onload="time()">

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
		<button class="nv btn add-new" type="button" data-toggle="tooltip"
			data-placement="top" title="Thêm đợt quyên góp">
			<i class="fa fa-plus-square"></i>
		</button>
		<button class="nv" type="button" onclick="sortTable()"
			data-toggle="tooltip" data-placement="top" title="Lọc Dữ Liệu">
			<i class="fa fa-filter" aria-hidden="true"></i>
		</button>
		<button class="nv" data-toggle="tooltip" data-placement="top"
			title="Xuất File">
			<i class="fas fa-file-export"></i>
		</button>
		<button class="nv cog" data-toggle="tooltip" data-placement="top"
			title="Cài đặt">
			<i class="fas fa-cogs"></i>
		</button>
		<div class="table-title">
			<div class="row"></div>

		</div>
		<table class="table table-bordered" id="myTable">
			<thead>
				<tr class="ex">
					<th width="auto">Tên đợt quyên góp</th>
					<th width="auto">Giới Tính</th>
					<th>Ngày Sinh</th>
					<th>Địa Chỉ</th>
					<th>Chức Vụ</th>
					<th width="5px; !important">Tính Năng</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Võ Trường</td>
					<td>Nam</td>
					<td>15/03/2000</td>
					<td>Thông Tin Bảo Mật</td>

					<td>Admin</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Trần Khả Ái</td>
					<td>Nữ</td>
					<td>12/02/1999</td>
					<td>155-157 Trần Quốc Thảo, Quận 3, Hồ Chí Minh</td>

					<td>Phục Vụ</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Nguyễn Tấn Trung</td>
					<td>Nam</td>
					<td>07/10/1997</td>
					<td>6 Nguyễn Lương Bằng, Tân Phú, Quận 7, Hồ Chí Minh</td>

					<td>Dịch Vụ</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Trần Trúc An</td>
					<td>Nữ</td>
					<td>22/12/1999</td>
					<td>Số 3 Hòa Bình, Phường 3, Quận 11, Hồ Chí Minh</td>

					<td>Phục Vụ</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Phạm Thu Cúc</td>
					<td>Nữ</td>
					<td>02/06/1998</td>
					<td>19 Đường Nguyễn Hữu Thọ, Tân Hưng, Quận 7, Hồ Chí Minh</td>

					<td>Thu Ngân</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Nguyễn Thị Kim Ngân</td>
					<td>Nữ</td>
					<td>06/04/1998</td>
					<td>Số 13, Tân Thuận Đông, Quận 7, Hồ Chí Minh</td>
					<td>Phục Vụ</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Nguyễn Anh Tuấn</td>
					<td>Nam</td>
					<td>23/07/1996</td>
					<td>59C Nguyễn Đình Chiểu, Quận 3, Hồ Chí Minh</td>
					<td>Dịch Vụ</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Huỳnh Cẩm Thu</td>
					<td>Nữ</td>
					<td>19/01/1997</td>
					<td>764 Võ Văn Kiệt, Phường 1, Quận 5, Hồ Chí Minh</td>
					<td>Tư Vấn</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Nguyễn Xuân Ly</td>
					<td>Nữ</td>
					<td>30/10/1999</td>
					<td>Đường Kênh T2 Ấp 6 Xã Hưng Long Huyện Bình Chánh, Hưng
						Long, Bình Chánh, Hồ Chí Minh</td>
					<td>Tư Vấn</td>
					<td><a class="add" title="Lưu Lại" data-toggle="tooltip"><i
							class="fa fa-floppy-o" aria-hidden="true"></i></a> <a class="edit"
						title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
							aria-hidden="true"></i></a> <a class="delete" title="Xóa"
						data-toggle="tooltip"><i class="fa fa-trash-o"
							aria-hidden="true"></i></a></td>
				</tr>
				<tr>
					<td>Hoàng Xuân Nam</td>
					<td>Nữ</td>
					<td>20/7/1989</td>
					<td>37 Vạn Tượng, Phường 13, Quận 5, Hồ Chí Minh</td>
					<td>QL Kho</td>
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