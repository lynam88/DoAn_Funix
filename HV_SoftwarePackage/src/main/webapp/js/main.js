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
				x = rows[i].getElementsByTagName("TD")[0];
				y = rows[i + 1].getElementsByTagName("TD")[0];
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
	
	//Validate new donation
	function validateFunction() {
		var status = document.getElementById("status").value;
		var title = document.getElementById("title").value;
		var totalNeeded = document.getElementById("totalNeeded").value;
		var content = CKEDITOR.instances.content.getData();
		var startDate = document.getElementById("startDate").value;
		var endDate = document.getElementById("endDate").value;
		var d1 = new Date(startDate);
		var d2 = new Date(endDate);
		
		if (status=="Xin Lựa Chọn") {
			document.getElementById("status_error").innerHTML = "Xin chọn Trạng Thái";
			document.getElementById("status_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("status_error").innerHTML =  "";
		}	
		if (title =="") {
			document.getElementById("title_error").innerHTML = "Xin điền vào Tiêu Đề";
			document.getElementById("title_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("title_error").innerHTML =  "";
		}		
		if (startDate == "" || endDate == "") {
			document.getElementById("date1_error").innerHTML = "Xin chọn Ngày";
			document.getElementById("date1_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("date1_error").innerHTML =  "";
		}
		if (d1 > d2) {
			document.getElementById("date2_error").innerHTML = "Ngày Bắt Đầu phải trước Ngày Kết Thúc";
			document.getElementById("date2_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("date2_error").innerHTML = "";
		}		
		if (totalNeeded =="") {
			document.getElementById("totalNeeded_error").innerHTML =  "Xin điền vào Tổng Tiền";
			document.getElementById("totalNeeded_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("totalNeeded_error").innerHTML =  "";
		}
	    if (content =="")
	    {
	    	document.getElementById("content_error").innerHTML =  "Xin điền vào Nội Dung";
	    	document.getElementById("content_error").scrollIntoView();
	    	return false;
	    }else {
			document.getElementById("content_error").innerHTML =  "";
		}	   
	}
	
	//Export button
	$('#export').click(function(){
		try {
			$.ajax({
				type : 'GET',
				url : '/HV_SoftwarePackage/ControllerServlet?action=export',
				success : function(result) {
					$("#exportMsg").text("Bạn đã xuất file thành công");
				},
				error: function(){
					$("#exportMsg").text("Xuất file thất bại");
					},
			});
		} catch (e) {
			$("#exportMsg").text("Xuất file thất bại");
		}
		setTimeout(function() {
			location.reload();
		}, 3000);		
	})
		
	//Read more
	$(".show-more a").on("click", function() {
	    var $this = $(this); 
	    var $content = $this.parent().prev("div.content");
	    var linkText = $this.text().toUpperCase();    
	    
	    if(linkText == "HIỂN THỊ THÊM"){
	        linkText = "Rút Gọn";
	        $content.switchClass("hideContent", "showContent", 400);
	    } else {
	        linkText = "Hiển thị thêm";
	        $content.switchClass("showContent", "hideContent", 400);
	    };

	    $this.text(linkText);
	});
		
	//Delete button
	$('#ok_del').click(function(){
		var donationIds = document.querySelectorAll(".donation_id:checked");
		var checked = [...donationIds].map(donationId => donationId.value).join(",");
		
		try {
			$.ajax({
				type : 'GET',
				data: 'id='+checked,
				url : '/HV_SoftwarePackage/ControllerServlet?action=delete',
				success : function(result) {
					$("#showMsg").modal();
					$("#cntMsg").text("Bạn đã xoá thành công");
					setTimeout(function() {
						location.reload();
					}, 3000);
				},
				error: function(){
					$("#cntMsg").text("Xoá file thất bại");
					},
			});
		} catch (e) {
			$("#cntMsg").text("Xoá file thất bại");
		}
	})
	
	//Reset button
	function resetFunction() {
		window.location.reload();
	}
	
	//Select - Deselect all
    function selects(){  
        var ele=document.getElementsByName('chk');  
        for(var i=0; i<ele.length; i++){  
            if(ele[i].type=='checkbox')  
                ele[i].checked=true;  
        }  
    }  
    function deSelect(){  
        var ele=document.getElementsByName('chk');  
        for(var i=0; i<ele.length; i++){  
            if(ele[i].type=='checkbox')  
                ele[i].checked=false;  
              
        }  
    }    