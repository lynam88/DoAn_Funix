<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
      <title>
	    ${param.title}
	  </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Overpass:300,400,400i,600,700" rel="stylesheet">
    
    <link rel="shortcut icon" href="#">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/animate.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/magnific-popup.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/aos.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/ionicons.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/icomoon.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/template/user/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/css/user.css">
    
	<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
    
  </head>
  <body>
    
  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">   	
      <a class="navbar-brand" href="${pageContext.request.contextPath}/UsersController?action=user">
        <img id="logo" src="${pageContext.request.contextPath}/user/media/logo.jpg" alt="logo">
      Quỹ Từ Thiện Liên Hoa</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>

	     <div class="collapse navbar-collapse" id="ftco-nav">
		  <ul class="navbar-nav ml-auto">		    
		    <c:choose>
			  <c:when test="${sessionScope.user.role == 0 || sessionScope.user.role == 1}">
			  	<li class="nav-item active"><a href="${pageContext.request.contextPath}/UsersController?action=admin" class="nav-link">Trang quản lý</a></li>
			  </c:when>
			  <c:otherwise>
			  	<li class="nav-item active"><a href="${pageContext.request.contextPath}/UsersController?action=user" class="nav-link">Trang Chủ</a></li>
			  </c:otherwise>
			 </c:choose>
			<li class="dropdown nav-dropdown">
	          <a class="dropdown-toggle nav-item nav-link" href="${pageContext.request.contextPath}/UsersDonationController?action=donations">
		        Hoàn Cảnh Quyên Góp
 		      </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=1">Vì Trẻ Em</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=2">Người Già, Người Khuyết Tật</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=3">Bệnh Hiểm Nghèo</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=4">Đầu Tư Cơ Sở Vật Chất</a></li>
	            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=5">Bảo Vệ Môi Trường</a></li>
	          </ul>
	        </li>
		    <li class="nav-item"><a href="${pageContext.request.contextPath}/UsersController?action=contact" class="nav-link">Liên Hệ</a></li>
		    <li class="nav-item"><a href="${pageContext.request.contextPath}/UsersDonationController?action=donationGuide" class="nav-link">Hướng Dẫn Đóng Góp</a></li>		  
		    <c:choose>
			  <c:when test="${user != null}">
			    <!-- User is logged in -->
			    <li class="dropdown nav-dropdown user">
			    			<c:if test="${user.avatarPath != null }"><img src="${user.avatarPath}" alt="Avatar" class="avatar"></c:if>		    	
						    <a class="dropdown-toggle nav-item nav-link" >
						        ${user.name}
				 		     </a>
					    	<ul class="dropdown-menu">		   			
							    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersController?action=userInfo">Thông tin cá nhân</a></li>
							    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersController?action=showUpdatePassInfo">Đổi mật khẩu</a></li>
							    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersController?action=donationHistory">Lịch sử quyên góp</a></li>
							    <li><div class="dropdown-divider"></div></li>
							    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UsersController?action=logout">Đăng xuất</a></li>				
							</ul>
						</li>	
			  </c:when>
			  <c:otherwise>
			    <!-- User is not logged in -->
			    <li class="nav-item"><a href="${pageContext.request.contextPath}/UsersController?action=rules" class="nav-link">Đăng Ký</a></li>
			    <li class="nav-item"><a href="${pageContext.request.contextPath}/UsersController?action=showLoginPage" class="nav-link">Đăng Nhập</a></li>
			  </c:otherwise>
			</c:choose>	    
		  </ul>		
		</div>
	</div>
  </nav>
    <!-- END nav -->
								