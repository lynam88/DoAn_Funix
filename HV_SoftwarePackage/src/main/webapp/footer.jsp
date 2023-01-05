<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container-fluid end">
	<div class="row text-center">
		<div class="col-lg-12 link">
			<i class="fab fa-facebook-f"></i> <i class="fab fa-instagram"></i> <i
				class="fab fa-youtube"></i> <i class="fab fa-google"></i>
		</div>
		<div class="col-lg-12">
			2022 CopyRight Phần Mềm Quản Lý | Designed by <a href="#">Nam
				Tran</a>
		</div>
	</div>
</div>

<script type="text/javascript">
	//Tìm kiếm
	function myFunction() {
		var input, filter, table, tr, td, i, txtValue;
		input = document.getElementById("myInput");
		filter = input.value.toUpperCase();
		table = document.getElementById("myTable");
		tr = table.getElementsByTagName("tr");
		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[1];
			if (td) {
				txtValue = td.textContent || td.innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}
	}
	//Lọc bảng
	function sortTable() {
		var table, rows, switching, i, x, y, shouldSwitch;
		table = document.getElementById("myTable");
		switching = true;
		while (switching) {
			switching = false;
			rows = table.rows;
			for (i = 1; i < (rows.length - 1); i++) {
				shouldSwitch = false;
				x = rows[i].getElementsByTagName("TD")[1];
				y = rows[i + 1].getElementsByTagName("TD")[1];
				if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
					shouldSwitch = true;
					break;
				}
			}
			if (shouldSwitch) {
				rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
				switching = true;
				swal("Thành Công!", "Bạn Đã Lọc Thành Công", "success");
			}
		}
	}
	//Thời Gian
	function time() {
		var today = new Date();
		var weekday = new Array(7);
		weekday[0] = "Chủ Nhật";
		weekday[1] = "Thứ Hai";
		weekday[2] = "Thứ Ba";
		weekday[3] = "Thứ Tư";
		weekday[4] = "Thứ Năm";
		weekday[5] = "Thứ Sáu";
		weekday[6] = "Thứ Bảy";
		var day = weekday[today.getDay()];
		var dd = today.getDate();
		var mm = today.getMonth() + 1;
		var yyyy = today.getFullYear();
		var h = today.getHours();
		var m = today.getMinutes();
		var s = today.getSeconds();
		m = checkTime(m);
		s = checkTime(s);
		nowTime = h + ":" + m + ":" + s;
		if (dd < 10) {
			dd = '0' + dd
		}
		if (mm < 10) {
			mm = '0' + mm
		}
		today = day + ', ' + dd + '/' + mm + '/' + yyyy;
		tmp = '<i class="fa fa-clock-o" aria-hidden="true"></i> <span class="date">'
				+ today + ' | ' + nowTime + '</span>';
		document.getElementById("clock").innerHTML = tmp;
		clocktime = setTimeout("time()", "1000", "Javascript");

		function checkTime(i) {
			if (i < 10) {
				i = "0" + i;
			}
			return i;
		}
	}
	//Ckeditor
	var content = '';
	var thumbnail = '';
	$(document).ready(
			function() {
				content = CKEDITOR.replace('content');
				thumbnail = CKEDITOR.replace('thumbnail');
				CKFinder.setupCKEditor(content,
						'${pageContext.request.contextPath}/ckfinder/');
				CKFinder.setupCKEditor(thumbnail,
						'${pageContext.request.contextPath}/ckfinder/');
				content.on('required', function(evt) {
					alert('Xin điền vào Nội Dung Bài Viết');
					evt.cancel();
				});
			});
</script>
<script type="text/javascript" src="js/main.js"></script>
</body>

</html>