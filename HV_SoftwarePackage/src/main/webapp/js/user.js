	/**
	 * Js functions for login pages
	 */ 
		//Validate login
		function validateLogin() {
			const loginId = document.getElementById("loginId").value;
			const password = document.getElementById("password").value;
			
			const loginIdError = document.getElementById("loginId_error");
			const passwordError = document.getElementById("password_error");
			
			if (!loginId) {
				loginIdError.innerHTML = "Xin Điền Vào Số Điện Thoại Hoặc Email";
				loginIdError.scrollIntoView();
				return false;
			} else if (!validateEmail(loginId) && !validatePhone(loginId)) {
				loginIdError.innerHTML = "Số Điện Thoại Hoặc Email Không Hợp Lệ";
				loginIdError.scrollIntoView();
				return false;
			} else {
				loginIdError.innerHTML =  "";
			}
			
			if (!password) {
				passwordError.innerHTML = "Xin Điền Vào Mật Khẩu";
				passwordError.scrollIntoView();
				return false;
			} else if (password.length < 8) {
				passwordError.innerHTML = "Mật Khẩu Phải Tối Thiểu 8 Ký Tự";
				passwordError.scrollIntoView();
				return false;
			} else {
				passwordError.innerHTML =  "";
			}
			
			return true;
		}
		
		function validateEmail(email) {
			const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			return re.test(String(email).toLowerCase());
		}
		
		function validatePhone(phone) {
			const re = /^\d{10,11}$/;
			return re.test(phone);
		}

		//show - hide password			
		$(".click-eye").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#password");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		$(".click-eye").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#retype_password");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		/**
		 * Js functions for signup pages
		 */
		
		//Register button 
		function enableButton() {
			document.getElementById("submit-button").disabled = false;
		}
		
		/**
		 * Js functions for admin pages
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
		
		$('#ok_user_del').click(function(){
			var chks = document.querySelectorAll(".chk:checked");
			var checked = [...chks].map(email => email.value).join(",");
			
			try {
				$.ajax({
					type : 'GET',
					data: 'email='+checked,
					url : '/HV_SoftwarePackage/UsersController?action=delete',
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
							$("#showMsg").text("Không được phép xoá ADMIN.");
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
		
		$('#cancel_user_del').click(function(){		
						$("#myModal").modal("hide");					
					})
		$('#close_user_del').click(function(){		
			$("#myModal").modal("hide");					
		})	
		
		/**
		 * Js functions for forgetPass page
		 */

		function validateForgotEmail(event) {
		  
		  const email = document.getElementById("email").value;
		  const emailError = document.getElementById("email_error");

		  if (!email) {
		    emailError.innerHTML = "Xin Điền Vào Email";
		    emailError.scrollIntoView();
		    return false;
		  } else if (!validateEmail(email)) {
		    emailError.innerHTML = "Email Không Hợp Lệ";
		    emailError.scrollIntoView();
		    return false;
		  } else {
		    emailError.innerHTML = "";
		  }
		}

			