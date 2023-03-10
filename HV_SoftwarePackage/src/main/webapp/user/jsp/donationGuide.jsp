<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Hướng dẫn đóng góp | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

  <div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="${pageContext.request.contextPath}/UsersController?action=user">Trang Chủ</a></span> <span>Hướng dẫn đóng góp</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Hướng dẫn đóng góp</h1>
          </div>
        </div>
      </div>
    </div>

<section class="ftco-section ftco-degree-bg">
	<div class="container">
		<div class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-12">
				<div class="card rounded-3 text-black">
					<div class="row g-0">
						<div class="rules">
							<h2 class="text-center text-primary">Hướng dẫn đóng góp cho
								Quỹ Từ Thiện Liên Hoa</h2>
							<p>Chào mừng bạn đến với trang hướng dẫn đóng góp cho Quỹ Từ
								Thiện Liên Hoa. Quỹ Từ Thiện Liên Hoa là một tổ chức phi lợi
								nhuận được thành lập để giúp đỡ những người có hoàn cảnh khó
								khăn trong xã hội. Chúng tôi mong muốn nhận được sự đóng góp của
								cộng đồng để có thể thực hiện được các dự án từ thiện.</p>

							<h4>Cách thức đóng góp</h4>
							<p>Bạn có thể đóng góp cho Quỹ Từ Thiện Liên Hoa bằng nhiều
								cách:</p>
							<ul>
								<li>Chuyển khoản qua tài khoản ngân hàng:</li>
								<p>Số tài khoản: 1234567890</p>
								<p>Tên ngân hàng: ABC</p>
								<p>Chủ tài khoản: Quỹ Từ Thiện Liên Hoa</p>
								<li>Đóng góp trực tiếp tại văn phòng của Quỹ Từ Thiện Liên
									Hoa.</li>
								<p>Địa chỉ: 152 Nguyễn Hữu Dật, P. Tây Thạnh, Q. Tân Phú, TP. HCM</p>
								<li>Qua trang web của chúng tôi:</li>
								<p>Chọn mục "Đóng góp" trên trang chủ của Quỹ Từ Thiện Liên
									Hoa và làm theo hướng dẫn trên trang.</p>
							</ul>

							<h4>Chúng tôi cần sự đóng góp của bạn</h4>
							<p>Chúng tôi tin rằng với sự đóng góp của cộng đồng, chúng
								tôi có thể thực hiện được các dự án từ thiện và giúp đỡ được
								nhiều người khó khăn trong xã hội. Nếu bạn có bất kỳ câu hỏi hay
								ý kiến đóng góp nào, xin vui lòng liên hệ với chúng tôi qua số
								điện thoại hoặc địa chỉ email được liệt kê trên trang web của
								chúng tôi.</p>

							<p>Xin chân thành cảm ơn sự đóng góp của bạn đến với Quỹ Từ
								Thiện Liên Hoa.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>