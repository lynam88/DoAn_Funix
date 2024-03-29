<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="header.jsp">
	<c:param name="title" value="Trang Chủ Quỹ Từ Thiện Liên Hoa"></c:param>
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
				<h1 class="mb-4"
					data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Cho
					Đi Là Còn Mãi</h1>

				<p data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">
					<a href="https://vimeo.com/802970866"
						class="btn btn-white btn-outline-white px-4 py-3 popup-vimeo"><span
						class="icon-play mr-2"></span>Watch Video</a>
				</p>
			</div>
		</div>
	</div>
</div>

<section class="ftco-counter ftco-intro" id="section-counter">
	<div class="container">
		<div class="row no-gutters">
			<div
				class="col-md-5 d-flex justify-content-center counter-wrap ftco-animate">
				<div class="block-18 color-1 align-items-stretch">
					<div class="text">
						<span>Số tiền đã quyên góp</span> <span><strong
							class="number"
							data-number=<c:out value="${statistics.totalDonationAmount}"></c:out>>0</strong>
							<span>cho hơn <c:out value="${statistics.totalDonations}"></c:out>
								hoàn cảnh
						</span>
					</div>
				</div>
			</div>
			<div
				class="col-md d-flex justify-content-center counter-wrap ftco-animate">
				<div class="block-18 color-2 align-items-stretch">
					<div class="text">
						<h3 class="mb-4">Ủng hộ Quỹ</h3>
						<p>Hãy đóng góp để chung tay xây dựng cộng đồng.</p>
						<p>
							<a href="${pageContext.request.contextPath}/UsersDonationController?action=donations" class="btn btn-white px-3 py-2 mt-2">Quyên Góp</a>
						</p>
					</div>
				</div>
			</div>
			<div
				class="col-md d-flex justify-content-center counter-wrap ftco-animate">
				<div class="block-18 color-3 align-items-stretch">
					<div class="text">
						<h3 class="mb-4">Tình nguyện viên</h3>
						<p>Hãy đăng ký và cùng chúng tôi lan tỏa tình yêu thương!</p>
						<p>
							<a href="#" class="btn btn-white px-3 py-2 mt-2">Đăng ký</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="ftco-section">
	<div class="container">
		<div class="row">
			<div class="col-md-4 d-flex align-self-stretch ftco-animate">
				<div class="media block-6 d-flex services p-3 py-4 d-block">
					<div class="icon d-flex mb-3">
						<span class="flaticon-donation-1"></span>
					</div>
					<div class="media-body pl-4">
						<h3 class="heading">Chung tay quyên góp</h3>
						<p>Sự đóng góp của bạn có thể tạo ra sự khác biệt lớn trong
							cuộc sống của những người cần giúp đỡ. Với sự hỗ trợ của bạn,
							chúng tôi có thể cung cấp thực phẩm, chỗ ở, giáo dục và chăm sóc
							sức khỏe cho những người có nhu cầu.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-flex align-self-stretch ftco-animate">
				<div class="media block-6 d-flex services p-3 py-4 d-block">
					<div class="icon d-flex mb-3">
						<span class="flaticon-charity"></span>
					</div>
					<div class="media-body pl-4">
						<h3 class="heading">Trở thành tình nguyện viên</h3>
						<p>Tình nguyện là một cách tuyệt vời để cảm ơn cộng đồng và
							tạo ra tác động tích cực đến cuộc sống của mọi người. Dù bạn có
							vài giờ một tuần hay vài ngày một tháng, chúng tôi có các cơ hội
							cho bạn tham gia.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-flex align-self-stretch ftco-animate">
				<div class="media block-6 d-flex services p-3 py-4 d-block">
					<div class="icon d-flex mb-3">
						<span class="flaticon-donation"></span>
					</div>
					<div class="media-body pl-4">
						<h3 class="heading">Mạnh thường quân</h3>
						<p>Tài trợ là một cách hiệu quả để hỗ trợ công việc của chúng
							tôi và giúp chúng tôi đạt được mục tiêu. Bằng cách tài trợ cho
							một dự án, bạn có thể ảnh hưởng trực tiếp đến cuộc sống của những
							người cần giúp đỡ. .</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="ftco-section bg-light">
	<div class="container-fluid">
		<div class="row justify-content-center mb-5 pb-3">
			<div class="col-md-5 heading-section ftco-animate text-center">
				<h2 class="mb-4">Các Đợt Quyên Góp của Quỹ</h2>
				<p>Hãy cùng chúng tôi đóng góp để giúp đỡ những người đang đối
					mặt với hoàn cảnh khó khăn như bệnh tật, thiên tai, nghèo đói và
					thiếu hụt giáo dục.</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 ftco-animate">
				<div class="carousel-cause owl-carousel">
					<c:forEach var="donation" items="${DonationStats}">
						<div class="item">
							<div class="cause-entry">
							<input type="hidden" value='${donation.donationId}' name="donationId">
								<a
									href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&donationId=${donation.donationId}"
									class="img thumbnail"
									style="background-image: url(${donation.src});"></a>
								<div class="text p-3 p-md-4">
									<h4>
										<a
											href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&donationId=${donation.donationId}">
											${donation.title} </a>
									</h4>
									<span class="donation-time mb-3 d-block"> Quyên góp mới
										nhất cách đây <c:out value="${donation.dayDiff}"></c:out> ngày
									</span>
									<div class="progress custom-progress-success">
										<div class="progress-bar bg-primary" role="progressbar"
											style="width: ${((donation.donationAmount/donation.totalNeeded)*100)}%;"
											aria-valuemax="100"></div>
									</div>

									<div>
										<span class="fund-raised d-block float-left leftText">
											Đã quyên góp được <fmt:formatNumber type="number"
												pattern="#,##0" value="${donation.donationAmount}" /> VNĐ
											trên tổng số tiền <fmt:formatNumber type="number"
												pattern="#,##0" value="${donation.totalNeeded}" /> VNĐ
										</span>
										<c:if test="${donation.status == 1}">
											<a
												href="${pageContext.request.contextPath}/UsersDonationController?action=donations"
												class="btn btn-success float-right" role="button"
												aria-pressed="true">Đã hoàn thành</a>
										</c:if>
										<c:if test="${donation.status == 2}">
											<a type="button" class="btn btn-primary float-right"
												href="${pageContext.request.contextPath}/UsersDonationController?action=donationPost&donationId=${donation.donationId}">Quyên
												góp</a>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

	</div>
</section>

<section class="ftco-section">
	<div class="container">
		<div class="row justify-content-center mb-5 pb-3">
			<div class="col-md-7 heading-section ftco-animate text-center">
				<h2 class="mb-4">Quyên góp mới nhất</h2>
				<p>Chào đón người quyên góp mới nhất! Anh ấy/ cô ấy đã đóng góp
					tích cực vào sự phát triển và khôi phục của cộng đồng.</p>
			</div>
		</div>
		<div class="row">
			<c:forEach var="userDonation" items="${MostRecentDonationUsers}">
				<div class="col-lg-4 d-flex mb-sm-4 ftco-animate">
					<div class="staff">
						<div class="d-flex mb-4">
							<div class="img"
								style="background-image: url(${userDonation.avatarPath});"></div>
							<div class="info ml-4">
								<h3>
									<c:out value="${userDonation.name}"></c:out>									
								</h3>
								<span class="position">Quyên góp cách đây <c:out
										value="${userDonation.dayDiff}"></c:out> ngày
								</span>
								<div class="text">
									<p>
										Quyên góp <span><fmt:formatNumber type="number"
												pattern="0,000" value="${userDonation.donationAmount}" />
											VNĐ</span> cho <a
											href="${pageContext.request.contextPath}/UsersDonationController?action=donations&category=${userDonation.category}">
											<c:if test="${userDonation.category == 1}">Vì trẻ em </c:if>
											<c:if test="${userDonation.category == 2}">Người Già, Người Khuyết Tật</c:if>
											<c:if test="${userDonation.category == 3}">Bệnh Hiểm Nghèo</c:if>
											<c:if test="${userDonation.category == 4}">Đầu Tư Cơ Sở Vật Chất</c:if>
											<c:if test="${userDonation.category == 5}">Bảo Vệ Môi Trường</c:if>
										</a>
									</p>
								</div>
							</div>
						</div>

					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>

<section class="ftco-gallery">
	<c:forEach var="donation" items="${DonationStats}" varStatus="row">
		<c:if test="${row.index % 4 == 0}">
			<div class="d-md-flex">
		</c:if>
		<a href="${donation.src}"
			class="gallery image-popup d-flex justify-content-center align-items-center img ftco-animate"
			style="background-image: url(${donation.src});">
			<div class="icon d-flex justify-content-center align-items-center">
				<span class="icon-search"></span>
			</div>
		</a>
		<c:if test="${(row.index + 1) % 4 == 0}">
			</div>
		</c:if>
	</c:forEach>
</section>

<%-- <section class="ftco-section">
	<div class="container">
		<div class="row justify-content-center mb-5 pb-3">
			<div class="col-md-7 heading-section ftco-animate text-center">
				<h2 class="mb-4">Recent from blog</h2>
				<p>Far far away, behind the word mountains, far from the
					countries Vokalia and Consonantia, there live the blind texts.</p>
			</div>
		</div>
		<div class="row d-flex">
			<div class="col-md-4 d-flex ftco-animate">
				<div class="blog-entry align-self-stretch">
					<a href="blog-single.html" class="block-20"
						style="background-image: url('${pageContext.request.contextPath}/template/user/images/image_1.jpg');">
					</a>
					<div class="text p-4 d-block">
						<div class="meta mb-3">
							<div>
								<a href="#">Sept 10, 2018</a>
							</div>
							<div>
								<a href="#">Admin</a>
							</div>
							<div>
								<a href="#" class="meta-chat"><span class="icon-chat"></span>
									3</a>
							</div>
						</div>
						<h3 class="heading mt-3">
							<a href="#">Hurricane Irma has devastated Florida</a>
						</h3>
						<p>A small river named Duden flows by their place and supplies
							it with the necessary regelialia.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-flex ftco-animate">
				<div class="blog-entry align-self-stretch">
					<a href="blog-single.html" class="block-20"
						style="background-image: url('${pageContext.request.contextPath}/template/user/images/image_2.jpg');">
					</a>
					<div class="text p-4 d-block">
						<div class="meta mb-3">
							<div>
								<a href="#">Sept 10, 2018</a>
							</div>
							<div>
								<a href="#">Admin</a>
							</div>
							<div>
								<a href="#" class="meta-chat"><span class="icon-chat"></span>
									3</a>
							</div>
						</div>
						<h3 class="heading mt-3">
							<a href="#">Hurricane Irma has devastated Florida</a>
						</h3>
						<p>A small river named Duden flows by their place and supplies
							it with the necessary regelialia.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-flex ftco-animate">
				<div class="blog-entry align-self-stretch">
					<a href="blog-single.html" class="block-20"
						style="background-image: url('${pageContext.request.contextPath}/template/user/images/image_3.jpg');">
					</a>
					<div class="text p-4 d-block">
						<div class="meta mb-3">
							<div>
								<a href="#">Sept 10, 2018</a>
							</div>
							<div>
								<a href="#">Admin</a>
							</div>
							<div>
								<a href="#" class="meta-chat"><span class="icon-chat"></span>
									3</a>
							</div>
						</div>
						<h3 class="heading mt-3">
							<a href="#">Hurricane Irma has devastated Florida</a>
						</h3>
						<p>A small river named Duden flows by their place and supplies
							it with the necessary regelialia.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="ftco-section bg-light">
	<div class="container">
		<div class="row justify-content-center mb-5 pb-3">
			<div class="col-md-7 heading-section ftco-animate text-center">
				<h2 class="mb-4">Our Latest Events</h2>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 d-flex ftco-animate">
				<div class="blog-entry align-self-stretch">
					<a href="blog-single.html" class="block-20"
						style="background-image: url('${pageContext.request.contextPath}/template/user/images/event-1.jpg');">
					</a>
					<div class="text p-4 d-block">
						<div class="meta mb-3">
							<div>
								<a href="#">Sep. 10, 2018</a>
							</div>
							<div>
								<a href="#">Admin</a>
							</div>
							<div>
								<a href="#" class="meta-chat"><span class="icon-chat"></span>
									3</a>
							</div>
						</div>
						<h3 class="heading mb-4">
							<a href="#">World Wide Donation</a>
						</h3>
						<p class="time-loc">
							<span class="mr-2"><i class="icon-clock-o"></i>
								10:30AM-03:30PM</span> <span><i class="icon-map-o"></i> Venue
								Main Campus</span>
						</p>
						<p>A small river named Duden flows by their place and supplies
							it with the necessary regelialia.</p>
						<p>
							<a href="event.html">Join Event <i
								class="ion-ios-arrow-forward"></i></a>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-flex ftco-animate">
				<div class="blog-entry align-self-stretch">
					<a href="blog-single.html" class="block-20"
						style="background-image: url('${pageContext.request.contextPath}/template/user/images/event-2.jpg');">
					</a>
					<div class="text p-4 d-block">
						<div class="meta mb-3">
							<div>
								<a href="#">Sep. 10, 2018</a>
							</div>
							<div>
								<a href="#">Admin</a>
							</div>
							<div>
								<a href="#" class="meta-chat"><span class="icon-chat"></span>
									3</a>
							</div>
						</div>
						<h3 class="heading mb-4">
							<a href="#">World Wide Donation</a>
						</h3>
						<p class="time-loc">
							<span class="mr-2"><i class="icon-clock-o"></i>
								10:30AM-03:30PM</span> <span><i class="icon-map-o"></i> Venue
								Main Campus</span>
						</p>
						<p>A small river named Duden flows by their place and supplies
							it with the necessary regelialia.</p>
						<p>
							<a href="event.html">Join Event <i
								class="ion-ios-arrow-forward"></i></a>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-flex ftco-animate">
				<div class="blog-entry align-self-stretch">
					<a href="blog-single.html" class="block-20"
						style="background-image: url('${pageContext.request.contextPath}/template/user/images/event-3.jpg');">
					</a>
					<div class="text p-4 d-block">
						<div class="meta mb-3">
							<div>
								<a href="#">Sep. 10, 2018</a>
							</div>
							<div>
								<a href="#">Admin</a>
							</div>
							<div>
								<a href="#" class="meta-chat"><span class="icon-chat"></span>
									3</a>
							</div>
						</div>
						<h3 class="heading mb-4">
							<a href="#">World Wide Donation</a>
						</h3>
						<p class="time-loc">
							<span class="mr-2"><i class="icon-clock-o"></i>
								10:30AM-03:30PM</span> <span><i class="icon-map-o"></i> Venue
								Main Campus</span>
						</p>
						<p>A small river named Duden flows by their place and supplies
							it with the necessary regelialia.</p>
						<p>
							<a href="event.html">Join Event <i
								class="ion-ios-arrow-forward"></i></a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="ftco-section-3 img"
	style="background-image: url(${pageContext.request.contextPath}/template/user/images/bg_3.jpg);">
	<div class="overlay"></div>
	<div class="container">
		<div class="row d-md-flex">
			<div class="col-md-6 d-flex ftco-animate">
				<div class="img img-2 align-self-stretch"
					style="background-image: url(${pageContext.request.contextPath}/template/user/images/bg_4.jpg);"></div>
			</div>
			<div class="col-md-6 volunteer pl-md-5 ftco-animate">
				<h3 class="mb-3">Be a volunteer</h3>
				<form action="#" class="volunter-form">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Your Name">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Your Email">
					</div>
					<div class="form-group">
						<textarea name="" id="" cols="30" rows="3" class="form-control"
							placeholder="Message"></textarea>
					</div>
					<div class="form-group">
						<input type="submit" value="Send Message"
							class="btn btn-white py-3 px-5">
					</div>
				</form>
			</div>
		</div>
	</div>
</section> --%>

<c:import url="footer.jsp"></c:import>

