<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggler" data-toggle="collapse"
				data-target="#myNavbar" style="position:relative; top:11px; padding-top:5px;">
				<i class="fas fa-bars"></i>
			</button>
			<a class="navbar-brand" href="/list"><i class="fa fa-home"
				aria-hidden="true"></i> QUẢN LÝ ĐỢT QUYÊN GÓP</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="ControllerServlet?action=list" data-toggle="tooltip"
					data-placement="bottom" title="ĐỢT QUYÊN GÓP">ĐỢT QUYÊN GÓP</a></li>
				<li><a href="ControllerServlet?action=user" data-toggle="tooltip" data-placement="bottom"
					title="NGƯỜI DÙNG">NGƯỜI DÙNG</a></li>
				<li><a href="/ControllerServlet?action=donationDetail" data-toggle="tooltip" data-placement="bottom"
					title="CHI TIẾT ĐỢT QUYÊN GÓP">CHI TIẾT ĐỢT QUYÊN GÓP</a></li>
				<li><a href="#" data-toggle="tooltip" data-placement="bottom"
					title="TÀI KHOẢN"><b>Tài Khoản</b> <span class="caret"></span>
				</a>
					<ul class="dropdown">
						<li><a href="/index.html" data-toggle="tooltip"
							data-placement="bottom" title="ĐĂNG XUẤT"><b>Đăng xuất <i
									class="fas fa-sign-out-alt"></i></b></a></li>
					</ul></li>

			</ul>
		</div>
	</div>
</nav>