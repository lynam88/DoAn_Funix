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
		
		//Validate login
		function validateSignup() {
		  const name = document.getElementById("name").value;
		  const phone = document.getElementById("phone").value;
		  const email = document.getElementById("email").value;
		  const address = document.getElementById("address").value;
		  const password = document.getElementById("password").value;
		  const retypePass = document.getElementById("retype_password").value;

		  const nameError = document.getElementById("name_error");
		  const phoneError = document.getElementById("phone_error");
		  const emailError = document.getElementById("email_error");
		  const addressError = document.getElementById("address_error");
		  const passwordError = document.getElementById("password_error");
		  const retypePassError = document.getElementById("retype_password_error");		 

		  if (!name) {
		    nameError.innerHTML = "Xin Điền Vào Họ Tên";

		    return false;
		  } else if (name.length < 2) {
		    nameError.innerHTML = "Họ tên phải dài hơn 2 chữ cái";

		    return false;
		  } else if (!/^[a-zA-Z ]+$/.test(name)) {
		    nameError.innerHTML = "Họ tên chỉ chứa chữ cái và khoảng trắng";
	
		    return false;
		  } else {
		    nameError.innerHTML =  "";
		  }

		  if (!phone) {
			phoneError.innerHTML = "Xin vui lòng nhập số điện thoại.";
			 
			return false;
		  } else if (!/^\d{10,11}$/.test(phone)) {
			phoneError.innerHTML = "Số điện thoại không hợp lệ. Vui lòng nhập lại số điện thoại theo định dạng 0xxx xxx xxx hoặc +84xxx xxx xxx.";
		
			return false;
		  } else {
			phoneError.innerHTML = "";
		  }

		  if (!email) {
		    emailError.innerHTML = "Xin Điền Vào Email là bắt buộc.";
		 
		    return false;
		  } else if (!/\S+@\S+\.\S+/.test(email)) {
		    emailError.innerHTML = "Email phải có định dạng user@example.com.";

		    return false;
		  } else {
		    emailError.innerHTML = "";
		  }

		  if (address && address.length < 5) {
		    addressError.innerHTML = "Địa chỉ phải dài hơn 5 ký tự.";

		    return false;
		  } else {
		    addressError.innerHTML = "";
		  }

		  if (!password) {
		    passwordError.innerHTML = "Xin Điền Vào Mật khẩu.";

		    return false;
		  } else if (password.length < 8) {
		    passwordError.innerHTML = "Mật khẩu phải dài hơn 8 ký tự.";
	
		    return false;
		  } else {
		    passwordError.innerHTML = "";
		  }

		  if (!retypePass) {
		    retypePassError.innerHTML = "Xin Điền Vào Nhập lại mật khẩu.";
		
		    return false;
		  } else if (password !== retypePass) {
			retypePassError.innerHTML = "Nhập lại mật khẩu không trùng khớp.";

			return false;
		  } else {
			retypePassError.innerHTML = "";
		  }
		  return true;
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
			document.getElementById("formDel").action = "UsersController?action=delete&email="+checked;
			$("#myModal").modal("hide");
		})			
		
		$('#cancel_user_del').click(function(){		
						$("#myModal").modal("hide");					
					})
		$('#close_user_del').click(function(){		
			$("#myModal").modal("hide");					
		})	
		
		/**
		 * Js function(s) for forgetPass page
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

				