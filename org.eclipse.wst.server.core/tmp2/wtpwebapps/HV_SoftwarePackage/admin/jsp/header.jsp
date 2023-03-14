<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE html>
<html lang="en" style=" font-size: 17px;">

<head>

  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">  
  <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/template/admin/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/template/admin/assets/img/favicon.png">
  <title>
    ${param.title}
  </title>
  
  <!-- Fonts and icons -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="${pageContext.request.contextPath}/template/admin/assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/template/admin/assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="${pageContext.request.contextPath}/template/admin/assets/css/nucleo-svg.css" rel="stylesheet" />
  
 <!-- CSS Files -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/admin.css">
  <link id="pagestyle" href="${pageContext.request.contextPath}/template/admin/assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
  <link	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous"/>	
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
		crossorigin="anonymous">
  <link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
		crossorigin="anonymous">
		
  <!-- jQuery library -->
  <script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	
  <!-- Latest compiled JavaScript -->
  <script src="//code.jquery.com/jquery.js"></script>
  <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">	
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://cdn.ckeditor.com/4.20.1/full/ckeditor.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script> 
 	
</head>

<body class="g-sidenav-show bg-gray-100">

<div class="min-height-300 bg-primary position-absolute w-100"></div>
  <aside class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 " id="sidenav-main" style="z-index: 1040;">
    <div class="sidenav-header">
      <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
      <a class="navbar-brand m-0 logo" href="#">
        <img src="${pageContext.request.contextPath}/user/media/logo.jpg" class="navbar-brand-img" alt="main_logo" style="float: left;">
        <span class="ms-1 font-weight-bold">Quỹ Từ Thiện Liên Hoa</span>
      </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
      <ul class="navbar-nav">
      
        <li class="nav-item mt-3" style="margin-left: -7%;">
	        <a class="nav-link index" href="${pageContext.request.contextPath}/UsersController?action=dashboard">
	          <h6 class="text-uppercase text-xs font-weight-bolder opacity-6" style="font-size: 110% !important;"><i class="fa fa-home" style="font-size:20px;color:#00FFFF"></i>Trang chủ</h6>
	        </a>
        </li>
        <li class="nav-item">
          <a class="nav-link DonationList" href="${pageContext.request.contextPath}/DonationsController?action=DonationList">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-calendar-grid-58 text-warning text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Đợt Quyên Góp</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link UserList" href="${pageContext.request.contextPath}/ManageUsersController?action=UserList">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-single-02 text-dark text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Người Dùng</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-credit-card text-success text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Người Dùng Quyên Góp</span>
          </a>
        </li>        
      </ul>
    </div>
  </aside>
  <main class="main-content position-relative border-radius-lg ">
    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
      <div class="container-fluid py-1 px-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-white" href="javascript:;"><i class="fa fa-home"></i> Trang chủ</a></li>
            <li class="breadcrumb-item text-sm text-white active" aria-current="page" id="str-pages1"></li>
          </ol>
          <h6 class="font-weight-bolder text-white mb-0" id="str-pages2">Trang Chủ</h6>
        </nav>
        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">          
          <ul class="navbar-nav justify-content-end" style="padding-left: 80%;">
          	<li class="nav-item d-flex align-items-center">
          		<div class="btn-group">
				  <a type="button" class="text-white font-weight-bold dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    Xin chào, Admin!
				  </a>
				  <div class="dropdown-menu">				  
				    <a class="dropdown-item" href="${pageContext.request.contextPath}/UsersController?action=logout">Đăng xuất</a>
				  </div>
				</div>          	
              <a href="javascript:;" class="nav-link text-white font-weight-bold px-0">              
                <i class="fa fa-user me-sm-1" style="padding-left: 50%;"></i>                
              </a>   
            </li>          
            <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
              <a href="javascript:;" class="nav-link text-white p-0" id="iconNavbarSidenav">
                <div class="sidenav-toggler-inner">
                  <i class="sidenav-toggler-line bg-white"></i>
                  <i class="sidenav-toggler-line bg-white"></i>
                  <i class="sidenav-toggler-line bg-white"></i>
                </div>
              </a>
            </li>
            <li class="nav-item px-3 d-flex align-items-center">
              <a href="javascript:;" class="nav-link text-white p-0">
                <i class="fa fa-cog fixed-plugin-button-nav cursor-pointer"></i>
              </a>
            </li>            
          </ul>
        </div>
      </div>
    </nav>
    
    <!-- End Navbar -->