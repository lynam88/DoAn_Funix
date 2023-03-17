<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Nội Quy Trang Web | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

  <div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="${pageContext.request.contextPath}/UsersController?action=user">Trang Chủ</a></span> <span>Đăng Ký</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Nội quy trang web</h1>
          </div>
        </div>
      </div>
    </div>

<section class="ftco-section ftco-degree-bg">
	<div class="container">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-xl-12">
				<div class="card rounded-3 text-black">
					<div class="row g-0">
						<div class="rules">
							<h2 class="text-center text-primary">Nội quy trang web Quỹ Từ Thiện Liên Hoa</h2>
							<p>Vui lòng đọc kỹ nội quy trước khi tiến hành đăng ký tài
								khoản trên trang web.</p>
							<ul>
								<li><strong>Mục đích của trang web:</strong> Trang web quỹ
									từ thiện này được thiết kế nhằm mục đích hỗ trợ các hoạt động
									từ thiện và gây quỹ cho các dự án từ thiện.</li>
								<li><strong>Quy định về đăng ký tài khoản:</strong> Người
									dùng phải cung cấp đầy đủ thông tin cá nhân và đăng ký tài
									khoản theo quy định của trang web. Người dùng phải giữ bí mật
									thông tin tài khoản và không được chia sẻ tài khoản với bất kỳ
									ai khác.</li>
								<li><strong>Quy định về quyền sở hữu nội dung:</strong>
									Người dùng phải đảm bảo rằng nội dung gửi lên trang web là
									không vi phạm quyền sở hữu trí tuệ của bất kỳ ai khác. Người
									dùng giữ quyền sở hữu nội dung mình tạo ra trên trang web, tuy
									nhiên, trang web được cấp phép sử dụng nội dung đó để thực hiện
									các hoạt động từ thiện và gây quỹ cho các dự án từ thiện.</li>
								<li><strong>Quy định về quyền riêng tư:</strong> Trang web
									cam kết bảo vệ thông tin cá nhân của người dùng và không chia
									sẻ thông tin
								<li><strong>Quy định về phương thức thanh toán:</strong>
									Trang web sử dụng các phương thức thanh toán an toàn và được
									chấp nhận bởi các tổ chức tài chính uy tín để thu hồi các khoản
									quyên góp.</li>
								<li><strong>Quy định về sử dụng dịch vụ:</strong> Người
									dùng phải sử dụng trang web và các dịch vụ trên trang web một
									cách đúng đắn và không vi phạm bất kỳ quy định nào của trang
									web. Trang web có quyền từ chối hoặc hạn chế truy cập của người
									dùng nếu người dùng vi phạm nội quy hoặc các quy định khác của
									trang web.</li>
								<li><strong>Thay đổi nội quy:</strong> Trang web có quyền
									thay đổi nội quy bất cứ lúc nào và người dùng sẽ được thông báo
									về những thay đổi này.</li>
							</ul>
								<div id="rulesAgree">
									<input type="checkbox" name="agree" id="agree">								
									<label for="agree">Tôi đã đọc và đồng ý với các điều
										khoản và nội quy của trang web</label> 
									<p id="chk-error"></p>
								</div>								
								<a type="button" class="btn btn-primary fa-lg gradient-custom-2 mb-3 rulesBtn" onclick="return validateRulesCheck()">Đăng ký tài khoản</a>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<c:import url="footer.jsp"></c:import>