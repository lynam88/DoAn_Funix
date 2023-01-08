/**
 * 
 */
 
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
						'ckfinder/');
				CKFinder.setupCKEditor(thumbnail,
						'ckfinder/');
				CKEDITOR.instances['content'].setData(CKEDITOR.instances.content.getData());
			});
	
	//Validate new donation
	function validateFunction() {
		var title = document.getElementById("title").value;
		var totalNeeded = document.getElementById("totalNeeded").value;
		var content = CKEDITOR.instances.content.getData();
		var startDate = document.getElementById("startDate").value;
		var endDate = document.getElementById("endDate").value;
		var d1 = new Date(startDate);
		var d2 = new Date(endDate);
		
		if (title =="") {
			document.getElementById("title_error").innerHTML = "Xin điền vào Tiêu Đề";
			return false;
		} else {
			document.getElementById("title_error").innerHTML =  "";
		}
		if (totalNeeded =="") {
			document.getElementById("totalNeeded_error").innerHTML =  "Xin điền vào Tổng Tiền";
			return false;
		} else {
			document.getElementById("totalNeeded_error").innerHTML =  "";
		}
	    if (content =="")
	    {
	    	document.getElementById("content_error").innerHTML =  "Xin điền vào Nội Dung";
	    	return false;
	    }else {
			document.getElementById("content_error").innerHTML =  "";
		}		    
	    if (d1 > d2) {
			document.getElementById("date_error").innerHTML = "Ngày Bắt Đầu phải trước Ngày Kết Thúc";
			return false;
		} else {
			document.getElementById("date_error").innerHTML = "";
		}
	}