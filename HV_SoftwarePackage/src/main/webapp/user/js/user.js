	/**
	 * Js functions for login page
	 */ 
		//Validate login
		function validateLogin() {
			const loginId = document.getElementById("loginId").value;
			const loginPass = document.getElementById("loginPass").value;
			
			const loginIdError = document.getElementById("loginId_error");
			const loginPassError = document.getElementById("loginPass_error");
			
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
			
			if (!loginPass) {
				loginPassError.innerHTML = "Xin Điền Vào Mật Khẩu";
				loginPassError.scrollIntoView();
				return false;
			} else if (loginPass.length < 8) {
				loginPassError.innerHTML = "Mật Khẩu Phải Tối Thiểu 8 Ký Tự";
				loginPassError.scrollIntoView();
				return false;
			} else {
				loginPassError.innerHTML =  "";
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
			  var input = $("#loginPass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});		
		
		/**
		 * Js functions for signup pages
		 */
		
		//show - hide password
		$(".click-eye").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#signupPass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		$(".click-eye").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#retype_signupPass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		//Register button 
		function enableButton() {
			document.getElementById("submit-button").disabled = false;
		}
		
		//Validate signup
		function validateSignup() {
		  const name = document.getElementById("name").value;
		  const phone = document.getElementById("phone").value;
		  const email = document.getElementById("email").value;
		  const address = document.getElementById("address").value;
		  const signupPass = document.getElementById("signupPass").value;
		  const retypeSignupPass = document.getElementById("retype_signupPass").value;

		  const nameError = document.getElementById("name_error");
		  const phoneError = document.getElementById("phone_error");
		  const emailError = document.getElementById("email_error");
		  const addressError = document.getElementById("address_error");
		  const signupPassError = document.getElementById("signupPass_error");
		  const retypeSignupPassError = document.getElementById("retype_signupPass_error");		 

		  if (!name) {
		    nameError.innerHTML = "Xin điền vào họ tên";
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
			phoneError.innerHTML = "Xin điền vào số điện thoại";
		    return false;
			    
		  } else if (!/^\d{10,11}$/.test(phone)) {
			phoneError.innerHTML = "Số điện thoại không hợp lệ. Vui lòng nhập lại số điện thoại theo định dạng 0xxx xxx xxx hoặc +84xxx xxx xxx.";		
			return false;
			
		  } else {
			phoneError.innerHTML = "";
		  }

		  if (!email) {
		    emailError.innerHTML = "Xin điền vào email.";		 
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

		  if (!signupPass) {
		    signupPassError.innerHTML = "Xin điền vào mật khẩu.";
		    return false;
		    
		  } else if (signupPass.length < 8) {
		    signupPassError.innerHTML = "Mật khẩu phải dài hơn 8 ký tự.";	
		    return false;
		    
		  } else {
		    signupPassError.innerHTML = "";
		  }

		  if (!retypeSignupPass) {
			retypeSignupPassError.innerHTML = "Xin nhập lại mật khẩu.";		
		    return false;
		    
		  } else if (signupPass !== retypeSignupPass) {
			retypeSignupPassError.innerHTML = "Mật khẩu không trùng khớp.";
			return false;
			
		  } else {
			retypeSignupPassError.innerHTML = "";
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
		//Validate email
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

		/**
		 * Js function(s) for recoverUser page
		 */
		//Validate inputs
		function validateRecoverUser() {
			  
			  const feedback = document.getElementById("feedback").value;
			  const feedbackError = document.getElementById("feedback_error");
			  const email = document.getElementById("email").value;
			  const emailRecoverError = document.getElementById("email_recover_error");

			  if (!feedback) {
				  feedbackError.innerHTML = "Xin Điền Vào Phản hồi";
				  feedbackError.scrollIntoView();
			    return false;
			  } else {
				  feedbackError.innerHTML = "";
			  }
				  
			  if (!email) {
				  emailRecoverError.innerHTML = "Xin Điền Vào Email";
				  emailRecoverError.scrollIntoView();
			    return false;
			  } else {
				  emailRecoverError.innerHTML = "";
			  }
			}		
		
		/**
		 * Js functions for rules page
		 */ 
		// Validate checkbox
		function validateRulesCheck() {
			  var checkBox = document.getElementById("agree");
			  var errorMessage = document.getElementById("chk-error");
			  if (checkBox.checked == false) {
			    errorMessage.innerHTML = "Bạn phải đồng ý với các điều khoản và nội quy của trang web để tiếp tục đăng ký";			 
			    return false;
			  } else {
			    errorMessage.innerHTML = "";
			    return true;
			  }
		}

		/**
		 * Js functions for info page
		 */
		
		//Validate update
				function validateUpdate() {
				  const name = document.getElementById("name").value;
				  const phone = document.getElementById("phone").value;
				  const email = document.getElementById("email").value;
				  const address = document.getElementById("address").value;

				  const nameError = document.getElementById("name_error");
				  const phoneError = document.getElementById("phone_error");
				  const emailError = document.getElementById("email_error");
				  const addressError = document.getElementById("address_error");

				  if (!name) {
				    nameError.innerHTML = "Xin điền vào họ tên";
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
					phoneError.innerHTML = "Xin điền vào số điện thoại";
				    return false;
					    
				  } else if (!/^\d{10,11}$/.test(phone)) {
					phoneError.innerHTML = "Số điện thoại không hợp lệ. Vui lòng nhập lại số điện thoại theo định dạng 0xxx xxx xxx hoặc +84xxx xxx xxx.";		
					return false;
					
				  } else {
					phoneError.innerHTML = "";
				  }

				  if (!email) {
				    emailError.innerHTML = "Xin điền vào email.";		 
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
				  
				  return true;
				}