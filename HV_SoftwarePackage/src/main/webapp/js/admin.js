/**
 * Js functions for admin pages
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
	
	//Validate new donation
	function validateDonation() {
		var status = document.getElementById("status").value;
		var title = document.getElementById("title").value;
		var totalNeeded = document.getElementById("totalNeeded").value;
		var a = totalNeeded.replaceAll(",","");
		var b = Number(a);
		var content = CKEDITOR.instances.content.getData();
		var startDate = document.getElementById("startDate").value;
		var endDate = document.getElementById("endDate").value;
		var d1 = new Date(startDate);
		var d2 = new Date(endDate);
		
		if (status=="Xin Lựa Chọn" || status == 0) {
			document.getElementById("status_error").innerHTML = "Xin chọn Trạng Thái";
			document.getElementById("status_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("status_error").innerHTML =  "";
		}	
		if (title =="" || title == null) {
			document.getElementById("title_error").innerHTML = "Xin điền vào Tiêu Đề";
			document.getElementById("title_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("title_error").innerHTML =  "";
		}		
		if (startDate == "" || endDate == "" || startDate == null || endDate == null) {
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
		if (totalNeeded =="" || totalNeeded == null) {
			document.getElementById("totalNeeded_error").innerHTML =  "Xin điền vào Tổng Tiền";
			document.getElementById("totalNeeded_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("totalNeeded_error").innerHTML =  "";
		}
		if (isNaN(b)) {
			document.getElementById("totalNeeded_error").innerHTML =  "Xin điền vào số";
			document.getElementById("totalNeeded_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("totalNeeded_error").innerHTML =  "";
		}
	    if (content =="" || content == null)
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
				url : '/HV_SoftwarePackage/DonationsController?action=export',
				success : function(result) {
					$("#exportMsg").text("Bạn đã xuất file thành công");
				},
				error: function(){
					$("#exportMsg").text("Lỗi khi xuất file");
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
	$("#btn_del").click(function(){
		var donationIds = document.querySelectorAll(".donation_id:checked");
		var checked = [...donationIds].map(donationId => donationId.value).join(",");
		
		if(!checked) {
			$("#checkMsg").modal("show");
			setTimeout(function() {
				$("#checkMsg").modal("hide");
			}, 2000);
		} else {
			$("#myModal").modal("show");
		}
	})
	
	$('#ok_del').click(function(){
		var donationIds = document.querySelectorAll(".donation_id:checked");
		var checked = [...donationIds].map(donationId => donationId.value).join(",");
		
		try {
			$.ajax({
				type : 'GET',
				data: 'id='+checked,
				url : '/HV_SoftwarePackage/DonationsController?action=delete',
				success : function(result) {
					$("#myModal").modal("hide");
					setTimeout(function() {					
						$("#showDelete").modal("show");
						$("#showMsg").text("Bạn đã xoá thành công");
					}, 1000);					
					setTimeout(function() {
						location.reload();
					}, 3000);
				},
				error: function(){
					$("#myModal").modal("hide");
					setTimeout(function() {					
						$("#showDelete").modal("show");
						$("#showMsg").text("Bạn đã xoá thất bại.");
					}, 1000);					
					setTimeout(function() {
						location.reload();
					}, 3000);
					},
			});
		} catch (e) {

			$("#myModal").modal("hide");
			setTimeout(function() {					
				$("#showDelete").modal("show");
				$("#showMsg").text("Bạn đã xoá thất bại.");
			}, 1000);					
			setTimeout(function() {
				location.reload();
			}, 3000);
		}
	})
	
	$('#cancel_del').click(function(){		
					$("#myModal").modal("hide");					
				})
	$('#close_del').click(function(){		
		$("#myModal").modal("hide");					
	})	
	
	//Reset button
	function resetFunction() {
		document.getElementById('status').selectedIndex = 0;
		document.getElementById('title').value = "";
		document.getElementById('startDate').value = "";
		document.getElementById('endDate').value = "";
		document.getElementById('totalNeeded').value = "";
		CKEDITOR.instances['thumbnail'].setData("");
		CKEDITOR.instances['content'].setData("");
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
   
    //Format money
    function removeFormat() {
    	var a = document.getElementById("totalNeeded").value.replaceAll(",","");
		document.getElementById("totalNeeded").value = a;
    }
    
    function addFormat() {
    	var number = document.getElementById("totalNeeded").value;
    	if(!isNaN(number)) {
		document.getElementById("totalNeeded").value = new Intl.NumberFormat().format(number);
    	}
    }
    