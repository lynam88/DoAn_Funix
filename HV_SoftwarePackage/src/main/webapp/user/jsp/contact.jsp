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
             <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"><a href="index.jsp">Trang Chủ</a></span> <span>Liên Hệ</span></p>
            <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Liên Hệ Với Chúng Tôi</h1>
          </div>
        </div>
      </div>
    </div>

    
    <section class="ftco-section contact-section ftco-degree-bg">
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

          <div class="col-md-6" id="map"></div>
        </div>
      </div>
    </section>   

<c:import url="footer.jsp"></c:import>