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
				x = rows[i].getElementsByTagName("TD")[2];
				y = rows[i + 1].getElementsByTagName("TD")[2];
				if (x.innerHTML.localeCompare(y.innerHTML, 'vi') > 0) {
					  shouldSwitch = true;
					  break;
				}
			}
			if (shouldSwitch) {
				rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
				switching = true;
				swal("Thành Công!", "Bạn Đã Sắp Xếp Thành Công", "success");
			}
		}
	}
	
	/**
	 * Js functions for Donation pages
	 */
	
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
		var category = document.getElementById("category").value;
		
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
			document.getElementById("date2_error").innerHTML = "Ngày Kết Thúc phải sau Ngày Bắt Đầu";
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
		if (category=="Xin Lựa Chọn" || category == 0) {
			document.getElementById("category_error").innerHTML =  "Xin chọn phân loại";
			document.getElementById("category_error").scrollIntoView();
			return false;
		} else {
			document.getElementById("category_error").innerHTML =  "";
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
	$("#donation_del").click(function(){
		var chks = document.querySelectorAll(".chk:checked");
		var checked = [...chks].map(donationId => donationId.value).join(",");
		
		if(!checked) {
			$("#checkMsg").modal("show");
			setTimeout(function() {
				$("#checkMsg").modal("hide");
			}, 2000);
		} else {
			$("#myModal").modal("show");
		}
	})
	
	$('#ok_donation_del').click(function(){
		var chks = document.querySelectorAll(".chk:checked");
		var checked = [...chks].map(donationId => donationId.value).join(",");
		
		try {
			$.ajax({
				type : 'POST',
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
	
	$('#cancel_donation_del').click(function(){		
					$("#myModal").modal("hide");					
				})
	$('#close_donation_del').click(function(){		
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
		document.getElementById("totalNeeded").value = new Intl.NumberFormat('en').format(number);
    	}
    }
    
/**
 * Js functions for user pages
 */
	//Delete button
	$("#user_del").click(function(){
		var chks = document.querySelectorAll(".chk:checked");
		var checked = [...chks].map(email => email.value).join(",");
		
		if(!checked) {
			$("#checkMsg").modal("show");
			setTimeout(function() {
				$("#checkMsg").modal("hide");
			}, 2000);
		} else {
			$("#myModal").modal("show");				
		}
	})	

	//Delete button
	$('#ok_user_del').click(function(){
		var chks = document.querySelectorAll(".chk:checked");
		var checked = [...chks].map(email => email.value).join(",");
		document.getElementById("formDel").action = "ManageUsersController?action=delete&email="+checked;
		$("#myModal").modal("hide");
	})			
	
	$('#cancel_user_del').click(function(){		
					$("#myModal").modal("hide");					
				})
	$('#close_user_del').click(function(){		
		$("#myModal").modal("hide");					
	})
	
	//Switch button
    $('#role_chk').click(function() {
		$("#roleModal").modal("show");		
	})