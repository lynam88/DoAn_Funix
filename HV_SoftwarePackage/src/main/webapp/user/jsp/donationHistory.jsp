<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Lịch sử quyên góp | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

<div class="hero-wrap"
	style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');"
	data-stellar-background-ratio="0.5">
	<div class="overlay"></div>
	<div class="container">
		<div
			class="row no-gutters slider-text align-items-center justify-content-center"
			data-scrollax-parent="true">
			<div class="col-md-7 ftco-animate text-center"
				data-scrollax=" properties: { translateY: '70%' }">
				<p class="breadcrumbs"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">
					<span class="mr-2"><a
						href="${pageContext.request.contextPath}/UsersController?action=user">Trang
							Chủ</a></span> <span>Lịch sử quyên góp</span>
				</p>
				<h1 class="mb-3 bread"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Lịch
					sử quyên góp</h1>
			</div>
		</div>
	</div>
</div>
<!--Modal -->
<div class="modal fade" id="makeDonationNotify" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p class="text-center" id="makeDonationMsg"
					style="font-size: large; color: red;"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>


<section class="ftco-section ftco-degree-bg">
	<div class="container-fluid" id="donationPost">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Số thứ tự</th>
					<th>Tên đợt quyên góp</th>
					<th>Số tiền</th>
					<th>Trạng thái</th>
					<th>Ngày quyên góp</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td><a href="detail.html">Đợt 1</a></td>
					<td>10,000,000</td>
					<td>Đã quyên góp</td>
					<td>01/01/2023</td>
				</tr>
				<tr>
					<td>2</td>
					<td><a href="detail.html">Đợt 2</a></td>
					<td>5,000,000</td>
					<td>Chưa quyên góp</td>
					<td>05/01/2023</td>
				</tr>
				<!-- Thêm các hàng tương tự cho các đợt quyên góp khác -->
			</tbody>
		</table>

	</div>
</section>
<!-- .section -->

<c:import url="footer.jsp"></c:import>