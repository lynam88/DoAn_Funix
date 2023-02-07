/**
 * Js functions for main pages
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

		//show - hide mật khẩu			
				$(".click-eye").click(function() {
					  $(this).toggleClass("bx-show bx-hide");
					  var input = $("#password");
					  if (input.attr("type") === "password") {
					    input.attr("type", "text");
					  } else {
					    input.attr("type", "password");
					  }
					});