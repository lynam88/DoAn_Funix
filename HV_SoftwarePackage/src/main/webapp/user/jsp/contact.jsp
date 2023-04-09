<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="header.jsp">
	<c:param name="title"
		value="Liên Hệ Với Chúng Tôi | Quỹ Từ Thiện Liên Hoa"></c:param>
</c:import>

  <div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/template/admin/assets/img/carousel-4.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="${pageContext.request.contextPath}/UsersController?action=user">Trang Chủ</a></span> <span>Liên Hệ</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Liên Hệ Với Chúng Tôi</h1>
          </div>
        </div>
      </div>
    </div>
    
    <section class="ftco-section contact-section ftco-degree-bg contactContent">
      <div class="container">
        <div class="row d-flex mb-5 contact-info">
          <div class="col-md-12 mb-4">
            <h2 class="text-primary">Thông tin liên hệ</h2>
          </div>
          <div class="w-100"></div>
          <div class="col-md-3">
            <p><span>Địa chỉ:</span> 152 Nguyễn Hữu Dật, P. Tây Thạnh, Q. Tân Phú,
										TP. HCM</p>
          </div>
          <div class="col-md-3">
            <p><span>Điện thoại:</span> <a href="tel://+84931967923">(+84) 931967923</a></p>
          </div>
          <div class="col-md-3">
            <p><span id="contactMail">Email:</span> <a href="mailto:quytuthienlienhoa@gmail.com">quytuthienlienhoa@gmail.com</a></p>
          </div>
          <div class="col-md-3">
            <p><span>Website:</span> <a href="#">quytuthienlienhoa.com</a></p>
          </div>
        </div>
        <div class="row block-9">
          <div class="col-md-6 pr-md-5">
          	<h4 class="mb-4">Bạn có câu hỏi?</h4>
            <form action="#">
              <div class="form-group">
                <input type="text" class="form-control" placeholder="Họ và tên">
              </div>
              <div class="form-group">
                <input type="text" class="form-control" placeholder="Địa chỉ email">
              </div>
              <div class="form-group">
                <input type="text" class="form-control" placeholder="Chủ đề">
              </div>
              <div class="form-group">
                <textarea name="" id="" cols="30" rows="7" class="form-control" placeholder="Nội dung tin nhắn"></textarea>
              </div>
              <div class="form-group">
                <input type="submit" value="Gửi" class="btn btn-primary py-3 px-5">
              </div>
            </form>
          
          </div>

          <div class="col-md-6" id="map">
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.0129307189413!2d106.62853185003742!3d10.810321161486149!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175295f38e6af1f%3A0x10c7cf29481fb273!2zMTUyIMSQLiBOZ3V54buFbiBI4buvdSBE4bqtdCwgUGjGsOG7nW5nIDE1LCBUw6JuIFBow7osIFRow6BuaCBwaOG7kSBI4buTIENow60gTWluaCwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1678457124754!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
          </div>
        </div>
      </div>
    </section>   

<c:import url="footer.jsp"></c:import>