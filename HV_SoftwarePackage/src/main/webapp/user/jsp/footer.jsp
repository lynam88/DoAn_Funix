<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<footer class="ftco-footer ftco-section img">
    	<div class="overlay"></div>
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-5">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Về Chúng Tôi</h2>
              <p>Quỹ từ thiện Liên Hoa là một tổ chức phi lợi nhuận hoạt động với mục đích hỗ trợ những người có hoàn cảnh khó khăn và giúp đỡ những địa phương chưa được phát triển. Sứ mệnh của chúng tôi là tạo ra một thế giới nơi mà mọi người có thể sống một cuộc sống an vui, hạnh phúc và đầy đủ hơn. Hãy tham gia và đóng góp cho Quỹ từ thiện Liên Hoa để cùng chung tay xây dựng một tương lai tốt đẹp hơn cho tất cả chúng ta.</p>
              <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-4">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Bài Viết Gần Đây</h2>
              <c:forEach var="donation" begin="1" end="2" items="${DonationList}">
              <div class="block-21 mb-4 d-flex">                
 				<a class="blog-img mr-4" href="${pageContext.request.contextPath}/UsersController?action=donationPost&id=${donation.id}" style="background-image: url(${donation.src});"></a>
                <div class="text">
                  <h3 class="heading"><a href="${pageContext.request.contextPath}/UsersController?action=donationPost&id=${donation.id}">${donation.title} </a></h3>
                  <div class="meta">
                    <div><a href="#"><span class="icon-calendar"></span>${donation.insertDate}</a></div>
                    <div><a href="#"><span class="icon-person"></span> Admin</a></div>
                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
                  </div>
                </div>
              </div>             
              </c:forEach>             
            </div>
          </div>
         
          <div class="col-md-3">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Bạn Có Thắc Mắc</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon icon-map-marker"></span><span class="text">152 Nguyễn Hữu Dật, P. Tây Thạnh, Q. Tân Phú, TP. HCM</span></li>
	                <li><a href="#"><span class="icon icon-phone"></span><span class="text">+84 931967923</span></a></li>
	                <li><a href="#"><span class="icon icon-envelope"></span><span class="text emailFooter">quytuthienlienhoa@gmail.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Nam Tran</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>

  <script src="${pageContext.request.contextPath}/template/user/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery.easing.1.3.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery.waypoints.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery.stellar.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/owl.carousel.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery.magnific-popup.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/aos.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery.animateNumber.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/bootstrap-datepicker.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/jquery.timepicker.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/scrollax.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/user/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/user/js/user.js"></script>
    
  </body>
</html>