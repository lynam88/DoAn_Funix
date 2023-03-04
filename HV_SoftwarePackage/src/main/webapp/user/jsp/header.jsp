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
    
	<link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    
  </head>
  <body>
    
  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">   	
      <a class="navbar-brand" href="index.jsp">
        <img id="logo" src="${pageContext.request.contextPath}/user/media/logo.jpg" alt="logo">
      Quỹ Từ Thiện Liên Hoa</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>

	     <div class="collapse navbar-collapse" id="ftco-nav">
		  <ul class="navbar-nav ml-auto">
		    <li class="nav-item active"><a href="index.html" class="nav-link">Trang Chủ</a></li>
			<li class="dropdown nav-dropdown">
	          <a class="dropdown-toggle nav-item nav-link" data-toggle="dropdown" href="#">
		        Hoàn Cảnh Quyên Góp
 		      </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="#">Vì Trẻ Em</a></li>
	            <li><a class="dropdown-item" href="#">Người Già, Người Khuyết Tật</a></li>
	            <li><a class="dropdown-item" href="#">Bệnh Hiểm Nghèo</a></li>
	            <li><a class="dropdown-item" href="#">Bảo Vệ Môi Trường</a></li>
	          </ul>
	        </li>
		    <li class="nav-item"><a href="causes.html" class="nav-link">Liên Hệ</a></li>
		    <li class="nav-item"><a href="donate.html" class="nav-link">Hướng Dẫn Đóng Góp</a></li>
		    <li class="nav-item"><a href="${pageContext.request.contextPath}/UsersController?action=signup" class="nav-link">Đăng Ký</a></li>
		    <li class="nav-item"><a href="${pageContext.request.contextPath}/UsersController?action=login" class="nav-link">Đăng Nhập</a></li>
		  </ul>
		</div>
	</div>
  </nav>
    <!-- END nav -->
								