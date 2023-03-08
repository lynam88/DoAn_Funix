<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

      <footer class="footer pt-3  ">
        <div class="container-fluid">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-lg-6 mb-lg-0 mb-4">
              <div class="copyright text-center text-sm text-muted text-lg-start">
                © <script>
                  document.write(new Date().getFullYear())
                </script>,
                made with <i class="fa fa-heart"></i> by
                <a href="https://www.creative-tim.com" class="font-weight-bold" target="_blank">Nam Tran</a>
                for a better web.
              </div>
            </div>
            <div class="col-lg-6">
              <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                <li class="nav-item">
                  <a href="https://www.creative-tim.com" class="nav-link text-muted" target="_blank">Nam Tran</a>
                </li>
                <li class="nav-item">
                  <a href="https://www.creative-tim.com/presentation" class="nav-link text-muted" target="_blank">About Us</a>
                </li>
                <li class="nav-item">
                  <a href="https://www.creative-tim.com/blog" class="nav-link text-muted" target="_blank">Blog</a>
                </li>
                <li class="nav-item">
                  <a href="https://www.creative-tim.com/license" class="nav-link pe-0 text-muted" target="_blank">License</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </main>
  <div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
      <i class="fa fa-cog py-2"> </i>
    </a>
    <div class="card shadow-lg">
      <div class="card-header pb-0 pt-3 ">
        <div class="float-start">
          <h5 class="mt-3 mb-0">Argon Configurator</h5>
          <p>See our dashboard options.</p>
        </div>
        <div class="float-end mt-4">
          <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
            <i class="fa fa-close"></i>
          </button>
        </div>
        <!-- End Toggle Button -->
      </div>
      <hr class="horizontal dark my-1">
      <div class="card-body pt-sm-3 pt-0 overflow-auto">
        <!-- Sidebar Backgrounds -->
        <div>
          <h6 class="mb-0">Sidebar Colors</h6>
        </div>
        <a href="javascript:void(0)" class="switch-trigger background-color">
          <div class="badge-colors my-2 text-start">
            <span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-warning" data-color="warning" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
          </div>
        </a>
        <!-- Sidenav Type -->
        <div class="mt-3">
          <h6 class="mb-0">Sidenav Type</h6>
          <p class="text-sm">Choose between 2 different sidenav types.</p>
        </div>
        <div class="d-flex">
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 active me-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
          <button class="btn bg-gradient-primary w-100 px-3 mb-2" data-class="bg-default" onclick="sidebarType(this)">Dark</button>
        </div>
        <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
        <!-- Navbar Fixed -->
        <div class="d-flex my-3">
          <h6 class="mb-0">Navbar Fixed</h6>
          <div class="form-check form-switch ps-0 ms-auto my-auto">
            <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)">
          </div>
        </div>
        <hr class="horizontal dark my-sm-4">
        <div class="mt-2 mb-5 d-flex">
          <h6 class="mb-0">Light / Dark</h6>
          <div class="form-check form-switch ps-0 ms-auto my-auto">
            <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version" onclick="darkMode(this)">
          </div>
        </div>
        <a class="btn bg-gradient-dark w-100" href="https://www.creative-tim.com/product/argon-dashboard">Free Download</a>
        <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/license/argon-dashboard">View documentation</a>
        <div class="w-100 text-center">
          <a class="github-button" href="https://github.com/creativetimofficial/argon-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/argon-dashboard on GitHub">Star</a>
          <h6 class="mt-3">Thank you for sharing!</h6>
          <a href="https://twitter.com/intent/tweet?text=Check%20Argon%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fargon-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
          </a>
          <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/argon-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
          </a>
        </div>
      </div>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="${pageContext.request.contextPath}/admin/js/admin.js"></script>
  <script src="${pageContext.request.contextPath}/template/admin/assets/js/core/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/admin/assets/js/core/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/admin/assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/admin/assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script src="${pageContext.request.contextPath}/template/admin/assets/js/plugins/chartjs.min.js"></script>
  <script>
 	    if ( location.search.split('action=')[1] == "index"){
	    	 var ctx1 = document.getElementById("chart-line").getContext("2d");

	    	 var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

	    	    gradientStroke1.addColorStop(1, 'rgba(94, 114, 228, 0.2)');
	    	    gradientStroke1.addColorStop(0.2, 'rgba(94, 114, 228, 0.0)');
	    	    gradientStroke1.addColorStop(0, 'rgba(94, 114, 228, 0)');
	    	    new Chart(ctx1, {
	    	      type: "line",
	    	      data: {
	    	        labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
	    	        datasets: [{
	    	          label: "Mobile apps",
	    	          tension: 0.4,
	    	          borderWidth: 0,
	    	          pointRadius: 0,
	    	          borderColor: "#5e72e4",
	    	          backgroundColor: gradientStroke1,
	    	          borderWidth: 3,
	    	          fill: true,
	    	          data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
	    	          maxBarThickness: 6

	    	        }],
	    	      },
	    	      options: {
	    	        responsive: true,
	    	        maintainAspectRatio: false,
	    	        plugins: {
	    	          legend: {
	    	            display: false,
	    	          }
	    	        },
	    	        interaction: {
	    	          intersect: false,
	    	          mode: 'index',
	    	        },
	    	        scales: {
	    	          y: {
	    	            grid: {
	    	              drawBorder: false,
	    	              display: true,
	    	              drawOnChartArea: true,
	    	              drawTicks: false,
	    	              borderDash: [5, 5]
	    	            },
	    	            ticks: {
	    	              display: true,
	    	              padding: 10,
	    	              color: '#fbfbfb',
	    	              font: {
	    	                size: 11,
	    	                family: "Open Sans",
	    	                style: 'normal',
	    	                lineHeight: 2
	    	              },
	    	            }
	    	          },
	    	          x: {
	    	            grid: {
	    	              drawBorder: false,
	    	              display: false,
	    	              drawOnChartArea: false,
	    	              drawTicks: false,
	    	              borderDash: [5, 5]
	    	            },
	    	            ticks: {
	    	              display: true,
	    	              color: '#ccc',
	    	              padding: 20,
	    	              font: {
	    	                size: 11,
	    	                family: "Open Sans",
	    	                style: 'normal',
	    	                lineHeight: 2
	    	              },
	    	            }
	    	          },
	    	        },
	    	      },
	    	    });
	    }

   
  </script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="${pageContext.request.contextPath}/template/admin/assets/js/argon-dashboard.min.js?v=2.0.4"></script>
  
  <script>
	var classCr = location.search.split('action=')[1];
	if(classCr == "index" || classCr == "DonationList" || classCr == "UserList"){
	document.getElementsByClassName(classCr)[0].className += " active";}
	var str_page1 = document.getElementById("str-pages1");
	var str_page2 = document.getElementById("str-pages2");
	var str = "";
	if(classCr.startsWith("DonationList") || classCr.startsWith("DonationSearch") ) {
		str+="Đợt Quyên góp";
	}
	if(classCr.startsWith("new")) {
		str+="Đợt Quyên góp / Tạo Đợt Quyên góp";
	}
	if(classCr.startsWith("edit")) {
		str+="Đợt Quyên góp / Sửa Đợt Quyên góp";
	}
	if(classCr.startsWith("UserList") || classCr.startsWith("userSearch")) {
		str+="Người Dùng";
	}
	str_page1.innerHTML = str;
	if(classCr !== "index"){
		str_page2.innerHTML = str;
	}
	</script>
	
	<script>
	//Ckeditor
	 if ( location.search.split('action=')[1] == "new" || location.search.split('action=')[1].startsWith("edit")){	
		var content = '';
		var thumbnail = '';
		$(document).ready(function() {
			content = CKEDITOR.replace('content');
			thumbnail = CKEDITOR.replace('thumbnail');
			CKFinder.setupCKEditor(content, 'ckfinder/');
			CKFinder.setupCKEditor(thumbnail, 'ckfinder/');
		});
	 }
	</script> 
	
	<script>
	//Thời gian	
	if ( location.search.split('action=')[1].endsWith("t")) {
		var today = new Date();
		var weekday = new Array(7);
		weekday[0] = "Chủ Nhật";
		weekday[1] = "Thứ Hai";
		weekday[2] = "Thứ Ba";
		weekday[3] = "Thứ Tư";
		weekday[4] = "Thứ Năm";
		weekday[5] = "Thứ Sáu";
		weekday[6] = "Thứ Bảy";
		var day = weekday[today.getDay()];
		var dd = today.getDate();
		var mm = today.getMonth() + 1;
		var yyyy = today.getFullYear();
		var h = today.getHours();
		var m = today.getMinutes();
		var s = today.getSeconds();
		m = checkTime(m);
		s = checkTime(s);
		nowTime = h + ":" + m + ":" + s;
		if (dd < 10) {
			dd = '0' + dd
		}
		if (mm < 10) {
			mm = '0' + mm
		}
		today = day + ', ' + dd + '/' + mm + '/' + yyyy;
		tmp = '<i class="fa fa-clock-o" aria-hidden="true"></i> <span class="date">'
				+ today + ' | ' + nowTime + '</span>';
		document.getElementById("clock").innerHTML = tmp;

		function checkTime(i) {
			if (i < 10) {
				i = "0" + i;
			}
			return i;
		}
	}
	</script> 
	
	<script>
	if ( location.search.split('action=')[1].startsWith("edit")){
		var number = document.getElementById("totalNeeded").value;
		document.getElementById("totalNeeded").value = new Intl.NumberFormat().format(number);		
	}
	</script>
	
</body>

</html>  