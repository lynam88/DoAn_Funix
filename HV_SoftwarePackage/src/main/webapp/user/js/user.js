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
		$(".click-eye-1").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#signupPass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		$(".click-eye-2").click(function() {
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
		    
		  } else if (!/^[a-zA-Z\sàáạãảâầấậẫẩăằắặẵẳèéẹẽẻêềếệễểđìíịĩỉòóọõỏôồốộỗổơờớợỡởùúụũủưừứựữửỳýỵỹỷÀÁẠÃẢÂẦẤẬẪẨĂẰẮẶẴẲÈÉẸẼẺÊỀẾỆỄỂĐÌÍỊĨỈÒÓỌÕỎÔỒỐỘỖỔƠỜỚỢỠỞÙÚỤŨỦƯỪỨỰỮỬỲÝỴỸỶđê]+$/.test(name)) {
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
		    
		  } else if (!/^[a-zA-Z\sàáạãảâầấậẫẩăằắặẵẳèéẹẽẻêềếệễểđìíịĩỉòóọõỏôồốộỗổơờớợỡởùúụũủưừứựữửỳýỵỹỷÀÁẠÃẢÂẦẤẬẪẨĂẰẮẶẴẲÈÉẸẼẺÊỀẾỆỄỂĐÌÍỊĨỈÒÓỌÕỎÔỒỐỘỖỔƠỜỚỢỠỞÙÚỤŨỦƯỪỨỰỮỬỲÝỴỸỶđê]+$/.test(name)) {
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
				
		//show - hide password	
		$(".click-eye-3").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#old-pass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		$(".click-eye-4").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#new-pass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		$(".click-eye-5").click(function() {
			  $(this).toggleClass("bx-show bx-hide");
			  var input = $("#retype-new-pass");
			  if (input.attr("type") === "password") {
			    input.attr("type", "text");
			  } else {
			    input.attr("type", "password");
			  }
			});
		
		//Validate Update Pass 
		function validateUpdatePass() {		
		  const oldPass = document.getElementById("old-pass").value;
		  const newPass = document.getElementById("new-pass").value;
		  const retypeNewPass = document.getElementById("retype-new-pass").value;

		  const oldPassError = document.getElementById("old-pass-error");
		  const newPassError = document.getElementById("new-pass-error");
		  const retypeNewPassError = document.getElementById("retype-new-pass-error");
		 
		  if (!oldPass) {
			  oldPassError.innerHTML = "Xin điền vào mật khẩu.";
			  return false;
		    
		  } else {
			  oldPassError.innerHTML = "";
		  }
		  
		  if (!newPass) {
			  newPassError.innerHTML = "Xin điền vào mật khẩu mới.";
			  return false;
		    
		  } else if (newPass.length < 8) {
			  newPassError.innerHTML = "Mật khẩu phải dài hơn 8 ký tự.";	
			  return false;
		    
		  } else {
			  newPassError.innerHTML = "";
		  }

		  if (!retypeNewPass) {
			  retypeNewPassError.innerHTML = "Xin nhập lại mật khẩu.";		
			  return false;
		    
		  } else if (newPass !== retypeNewPass) {
			  retypeNewPassError.innerHTML = "Xác nhận mật khẩu mới không trùng khớp.";
			  return false;
			
		  } else {
			  retypeNewPassError.innerHTML = "";
		  }
		  
		  return true;
		}
		
		/**
		 * Js functions for Donation post page
		 */
		
		//Show form
		$('#FirstDonationBtn').click(function() {
			  var x = document.getElementById("makeDonationForm");
			  var style = window.getComputedStyle(x);
			  if (style.display === "none") {
			    x.style.display = "block";
			  } else {
			    x.style.display = "none";
			  }
			});

		
		//Validate form
		function validateDonation() {
			  const name = document.getElementById("name").value;
			  const phone = document.getElementById("phone").value;
			  const email = document.getElementById("email").value;
			  const donationAmount = document.getElementById("donationAmount").value;
			  const bank = document.getElementById("bank").value;
			  const transactionId = document.getElementById("transactionId").value;

			  const nameError = document.getElementById("name_error");
			  const phoneError = document.getElementById("phone_error");
			  const emailError = document.getElementById("email_error");
			  const donationAmountError = document.getElementById("donationAmount_error");
			  const bankError = document.getElementById("bank_error");
			  const transactionIdError = document.getElementById("transactionId_error");

			  if (!name) {
			    nameError.innerHTML = "Xin điền vào họ tên";
			    return false;
			    
			  } else if (name.length < 2) {
			    nameError.innerHTML = "Họ tên phải dài hơn 2 chữ cái";
			    return false;
			    
			  } else if (!/^[a-zA-Z\sàáạãảâầấậẫẩăằắặẵẳèéẹẽẻêềếệễểđìíịĩỉòóọõỏôồốộỗổơờớợỡởùúụũủưừứựữửỳýỵỹỷÀÁẠÃẢÂẦẤẬẪẨĂẰẮẶẴẲÈÉẸẼẺÊỀẾỆỄỂĐÌÍỊĨỈÒÓỌÕỎÔỒỐỘỖỔƠỜỚỢỠỞÙÚỤŨỦƯỪỨỰỮỬỲÝỴỸỶđê]+$/.test(name)) {
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

			  if (!donationAmount) {
				donationAmountError.innerHTML = "Xin điền vào số tiền muốn quyên góp.";		 
			    return false;
				    
			  } else {
				donationAmountError.innerHTML = "";
			  } 
			  
			  if (isNaN(donationAmount)) {
				donationAmountError.innerHTML =  "Xin điền vào số";		
				return false;
				
			  } else {
				 donationAmountError.innerHTML =  "";
			  }
			  
			  if (!bank) {
				  bankError.innerHTML = "Xin điền vào tên ngân hàng.";
				  return false;
			    
			  } else {
				  bankError.innerHTML = "";
			  }
			  
			  if (!transactionId) {
				  transactionIdError.innerHTML = "Xin điền vào mã giao dịch.";
				  return false;
			    
			  } else {
				  transactionIdError.innerHTML = "";
			  }
			  
			  return true;
			}
		
		function getMySession() {
			  // Get session value from server request using fetch()
			  return fetch('/api/getSession')
			    .then(response => response.text())
			    .then(data => {
			      return data;
			    })
			    .catch(error => {
			      console.error('Error:', error);
			    });
			}

		
		//Make donation
		
		function makeDonation() {
			// Check if session is null
			var session = getMySession(); // Replace getSession() with your method to get the session
			if (session == null) {
		    // Call validate inputs
			var check = validateDonation();
			}
			if(check) {
			// Call ajax
				 const phoneError = document.getElementById("phone_error");
				 const emailError = document.getElementById("email_error");
			 try {
		            $.ajax({
		                type : 'POST',
		                data: {
		                	name : $('#name').val(),
		                	phone : $('#phone').val(),
		                	email : $('#email').val(),
		                	donationAmount : $('#donationAmount').val(),
		                	bank : $('#bank').val(),
		                	transactionId : $('#transactionId').val(),		                  
		                },
		                url : '/HV_SoftwarePackage/UserDonationController?action=makeDonation',
		                success : function(responseText) {	                	
		                   if (responseText == "0") phoneError.innerHTML = "Số điện thoại này đã được đăng ký";
		                   if (responseText == "1") emailError.innerHTML = "Email này đã được đăng ký";
		                   if (responseText == "2") {
		                	   setTimeout(function() {                  
			                        $("#makeDonationNotify").modal("show");
			                        $("#makeDonationMsg").text("Cảm ơn bạn đã quyên góp");	                        
			                    }, 1000);                    
			                    setTimeout(function() {	                    	
			                        location.reload();
			                    }, 3000);
		                   }
		                },
		                error: function(responseText){	                
		                    setTimeout(function() {                  
		                    	  $("#makeDonationNotify").modal("show");
			                        $("#makeDonationMsg").text("Quyên góp chưa thành công");	                        
		                    }, 1000);                    
		                    setTimeout(function() {	                    	
		                        location.reload();
		                    }, 3000);
		                },
		            });
		        } catch (e) {	   
		            setTimeout(function() {                  
		                $("#make_donation_notify").modal("show");
		                $("#make_donation_msg").text("Có lỗi xảy ra, xin vui lòng thử lại sau.");
		            }, 1000);                    
		            setTimeout(function() {
		                location.reload();
		            }, 3000);
		        }	       
		    }
		}