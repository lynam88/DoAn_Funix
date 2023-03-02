<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">

<head>
<title>${param.title}</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/admin/css/admin.css">
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>

<body>

	<section class="h-100 gradient-form"
		style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-xl-10">
					<%-- <div class="row justify-content-between">
						<div class="col text-center">
							<div class="text-center">
								<img src="media/logo.jpg" style="width: 185px;" alt="logo">
								<h4 class="mt-1 mb-5 pb-1" style="color: orangered;">Quỹ Từ
									Thiện Liên Hoa</h4>
							</div>
							<a
								href="${pageContext.request.contextPath}/UsersController?action=signup"
								class="btn btn-outline-light btn-bg-left btn-signup"><i
								class='bx bxs-left-arrow-square'></i> Đăng Ký</a>
						</div>
						<div class="col text-center">
							<a
								href="${pageContext.request.contextPath}/UsersController?action=resetPassword"
								class="btn btn-outline-light btn-bg-center btn-reset-password"><i
								class='bx bxs-lock-open'></i> Cấp Lại Mật Khẩu</a>
						</div>
						<div class="col text-center">
							<a href="index.jsp" class="btn btn-outline-light btn-bg-center"><i
								class='bx bxs-home'></i> Trang chủ</a>
						</div>
						<div class="col text-center">
							<a
								href="${pageContext.request.contextPath}/UsersController?action=recoverUser"
								class="btn btn-outline-light btn-bg-center btn-recover-user"><i
								class='bx bxs-shield'></i> Phục Hồi Tài Khoản</a>
						</div>
						<div class="col text-center">
							<a
								href="${pageContext.request.contextPath}/UsersController?action=login"
								class="btn btn-outline-light btn-bg-right btn-login">Đăng
								Nhập <i class='bx bxs-right-arrow-square'></i>
							</a>
						</div>

					</div> --%>

					<nav class="navbar navbar-inverse">
						<div class="container-fluid">
							<div class="navbar-header">
								<button type="button" class="navbar-toggle"
									data-toggle="collapse" data-target="#myNavbar">
									<span class="icon-bar"></span> <span class="icon-bar"></span> <span
										class="icon-bar"></span>
								</button>
								<a class="navbar-brand" href="#">WebSiteName</a>
							</div>
							<div class="collapse navbar-collapse" id="myNavbar">
								<ul class="nav navbar-nav">
									<li class="active"><a href="#">Home</a></li>
									<li class="dropdown"><a class="dropdown-toggle"
										data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a href="#">Page 1-1</a></li>
											<li><a href="#">Page 1-2</a></li>
											<li><a href="#">Page 1-3</a></li>
										</ul></li>
									<li><a href="#">Page 2</a></li>
									<li><a href="#">Page 3</a></li>
								</ul>
								<ul class="nav navbar-nav navbar-right">
									<li><a href="#"><span class="glyphicon glyphicon-user"></span>
											Sign Up</a></li>
									<li><a href="#"><span
											class="glyphicon glyphicon-log-in"></span> Login</a></li>
								</ul>
							</div>
						</div>
					</nav>

					<div class="card rounded-3 text-black">
						<div class="row g-0">
							<div class="col-lg-12">
								<div class="card-body p-md-5 mx-md-4">