/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.68
 * Generated at: 2023-03-13 09:51:52 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.admin.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class footer_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("file:/C:/Program%20Files/Apache%20Software%20Foundation/Tomcat%209.0/lib/jstl-1.2.jar", Long.valueOf(1364130896000L));
    _jspx_dependants.put("jar:file:/C:/Program%20Files/Apache%20Software%20Foundation/Tomcat%209.0/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153359882000L));
    _jspx_dependants.put("jar:file:/C:/Program%20Files/Apache%20Software%20Foundation/Tomcat%209.0/lib/jstl-1.2.jar!/META-INF/fmt.tld", Long.valueOf(1153359882000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      <footer class=\"footer pt-3  \">\r\n");
      out.write("        <div class=\"container-fluid\">\r\n");
      out.write("          <div class=\"row align-items-center justify-content-lg-between\">\r\n");
      out.write("            <div class=\"col-lg-6 mb-lg-0 mb-4\">\r\n");
      out.write("              <div class=\"copyright text-center text-sm text-muted text-lg-start\">\r\n");
      out.write("                © <script>\r\n");
      out.write("                  document.write(new Date().getFullYear())\r\n");
      out.write("                </script>,\r\n");
      out.write("                made with <i class=\"fa fa-heart\"></i> by\r\n");
      out.write("                <a href=\"https://www.creative-tim.com\" class=\"font-weight-bold\" target=\"_blank\">Nam Tran</a>\r\n");
      out.write("                for a better web.\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-lg-6\">\r\n");
      out.write("              <ul class=\"nav nav-footer justify-content-center justify-content-lg-end\">\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                  <a href=\"https://www.creative-tim.com\" class=\"nav-link text-muted\" target=\"_blank\">Nam Tran</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                  <a href=\"https://www.creative-tim.com/presentation\" class=\"nav-link text-muted\" target=\"_blank\">About Us</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                  <a href=\"https://www.creative-tim.com/blog\" class=\"nav-link text-muted\" target=\"_blank\">Blog</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                  <a href=\"https://www.creative-tim.com/license\" class=\"nav-link pe-0 text-muted\" target=\"_blank\">License</a>\r\n");
      out.write("                </li>\r\n");
      out.write("              </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("      </footer>\r\n");
      out.write("    </div>\r\n");
      out.write("  </main>\r\n");
      out.write("  <div class=\"fixed-plugin\">\r\n");
      out.write("    <a class=\"fixed-plugin-button text-dark position-fixed px-3 py-2\">\r\n");
      out.write("      <i class=\"fa fa-cog py-2\"> </i>\r\n");
      out.write("    </a>\r\n");
      out.write("    <div class=\"card shadow-lg\">\r\n");
      out.write("      <div class=\"card-header pb-0 pt-3 \">\r\n");
      out.write("        <div class=\"float-start\">\r\n");
      out.write("          <h5 class=\"mt-3 mb-0\">Argon Configurator</h5>\r\n");
      out.write("          <p>See our dashboard options.</p>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"float-end mt-4\">\r\n");
      out.write("          <button class=\"btn btn-link text-dark p-0 fixed-plugin-close-button\">\r\n");
      out.write("            <i class=\"fa fa-close\"></i>\r\n");
      out.write("          </button>\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- End Toggle Button -->\r\n");
      out.write("      </div>\r\n");
      out.write("      <hr class=\"horizontal dark my-1\">\r\n");
      out.write("      <div class=\"card-body pt-sm-3 pt-0 overflow-auto\">\r\n");
      out.write("        <!-- Sidebar Backgrounds -->\r\n");
      out.write("        <div>\r\n");
      out.write("          <h6 class=\"mb-0\">Sidebar Colors</h6>\r\n");
      out.write("        </div>\r\n");
      out.write("        <a href=\"javascript:void(0)\" class=\"switch-trigger background-color\">\r\n");
      out.write("          <div class=\"badge-colors my-2 text-start\">\r\n");
      out.write("            <span class=\"badge filter bg-gradient-primary active\" data-color=\"primary\" onclick=\"sidebarColor(this)\"></span>\r\n");
      out.write("            <span class=\"badge filter bg-gradient-dark\" data-color=\"dark\" onclick=\"sidebarColor(this)\"></span>\r\n");
      out.write("            <span class=\"badge filter bg-gradient-info\" data-color=\"info\" onclick=\"sidebarColor(this)\"></span>\r\n");
      out.write("            <span class=\"badge filter bg-gradient-success\" data-color=\"success\" onclick=\"sidebarColor(this)\"></span>\r\n");
      out.write("            <span class=\"badge filter bg-gradient-warning\" data-color=\"warning\" onclick=\"sidebarColor(this)\"></span>\r\n");
      out.write("            <span class=\"badge filter bg-gradient-danger\" data-color=\"danger\" onclick=\"sidebarColor(this)\"></span>\r\n");
      out.write("          </div>\r\n");
      out.write("        </a>\r\n");
      out.write("        <!-- Sidenav Type -->\r\n");
      out.write("        <div class=\"mt-3\">\r\n");
      out.write("          <h6 class=\"mb-0\">Sidenav Type</h6>\r\n");
      out.write("          <p class=\"text-sm\">Choose between 2 different sidenav types.</p>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"d-flex\">\r\n");
      out.write("          <button class=\"btn bg-gradient-primary w-100 px-3 mb-2 active me-2\" data-class=\"bg-white\" onclick=\"sidebarType(this)\">White</button>\r\n");
      out.write("          <button class=\"btn bg-gradient-primary w-100 px-3 mb-2\" data-class=\"bg-default\" onclick=\"sidebarType(this)\">Dark</button>\r\n");
      out.write("        </div>\r\n");
      out.write("        <p class=\"text-sm d-xl-none d-block mt-2\">You can change the sidenav type just on desktop view.</p>\r\n");
      out.write("        <!-- Navbar Fixed -->\r\n");
      out.write("        <div class=\"d-flex my-3\">\r\n");
      out.write("          <h6 class=\"mb-0\">Navbar Fixed</h6>\r\n");
      out.write("          <div class=\"form-check form-switch ps-0 ms-auto my-auto\">\r\n");
      out.write("            <input class=\"form-check-input mt-1 ms-auto\" type=\"checkbox\" id=\"navbarFixed\" onclick=\"navbarFixed(this)\">\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <hr class=\"horizontal dark my-sm-4\">\r\n");
      out.write("        <div class=\"mt-2 mb-5 d-flex\">\r\n");
      out.write("          <h6 class=\"mb-0\">Light / Dark</h6>\r\n");
      out.write("          <div class=\"form-check form-switch ps-0 ms-auto my-auto\">\r\n");
      out.write("            <input class=\"form-check-input mt-1 ms-auto\" type=\"checkbox\" id=\"dark-version\" onclick=\"darkMode(this)\">\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <a class=\"btn bg-gradient-dark w-100\" href=\"https://www.creative-tim.com/product/argon-dashboard\">Free Download</a>\r\n");
      out.write("        <a class=\"btn btn-outline-dark w-100\" href=\"https://www.creative-tim.com/learning-lab/bootstrap/license/argon-dashboard\">View documentation</a>\r\n");
      out.write("        <div class=\"w-100 text-center\">\r\n");
      out.write("          <a class=\"github-button\" href=\"https://github.com/creativetimofficial/argon-dashboard\" data-icon=\"octicon-star\" data-size=\"large\" data-show-count=\"true\" aria-label=\"Star creativetimofficial/argon-dashboard on GitHub\">Star</a>\r\n");
      out.write("          <h6 class=\"mt-3\">Thank you for sharing!</h6>\r\n");
      out.write("          <a href=\"https://twitter.com/intent/tweet?text=Check%20Argon%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fargon-dashboard\" class=\"btn btn-dark mb-0 me-2\" target=\"_blank\">\r\n");
      out.write("            <i class=\"fab fa-twitter me-1\" aria-hidden=\"true\"></i> Tweet\r\n");
      out.write("          </a>\r\n");
      out.write("          <a href=\"https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/argon-dashboard\" class=\"btn btn-dark mb-0 me-2\" target=\"_blank\">\r\n");
      out.write("            <i class=\"fab fa-facebook-square me-1\" aria-hidden=\"true\"></i> Share\r\n");
      out.write("          </a>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("  <!--   Core JS Files   -->\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/admin/js/admin.js\"></script>\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/template/admin/assets/js/core/popper.min.js\"></script>\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/template/admin/assets/js/core/bootstrap.min.js\"></script>\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/template/admin/assets/js/plugins/perfect-scrollbar.min.js\"></script>\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/template/admin/assets/js/plugins/smooth-scrollbar.min.js\"></script>\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/template/admin/assets/js/plugins/chartjs.min.js\"></script>\r\n");
      out.write("  <script>\r\n");
      out.write(" 	    if ( location.search.split('action=')[1] == \"index\"){\r\n");
      out.write("	    	 var ctx1 = document.getElementById(\"chart-line\").getContext(\"2d\");\r\n");
      out.write("\r\n");
      out.write("	    	 var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);\r\n");
      out.write("\r\n");
      out.write("	    	    gradientStroke1.addColorStop(1, 'rgba(94, 114, 228, 0.2)');\r\n");
      out.write("	    	    gradientStroke1.addColorStop(0.2, 'rgba(94, 114, 228, 0.0)');\r\n");
      out.write("	    	    gradientStroke1.addColorStop(0, 'rgba(94, 114, 228, 0)');\r\n");
      out.write("	    	    new Chart(ctx1, {\r\n");
      out.write("	    	      type: \"line\",\r\n");
      out.write("	    	      data: {\r\n");
      out.write("	    	        labels: [\"Apr\", \"May\", \"Jun\", \"Jul\", \"Aug\", \"Sep\", \"Oct\", \"Nov\", \"Dec\"],\r\n");
      out.write("	    	        datasets: [{\r\n");
      out.write("	    	          label: \"Mobile apps\",\r\n");
      out.write("	    	          tension: 0.4,\r\n");
      out.write("	    	          borderWidth: 0,\r\n");
      out.write("	    	          pointRadius: 0,\r\n");
      out.write("	    	          borderColor: \"#5e72e4\",\r\n");
      out.write("	    	          backgroundColor: gradientStroke1,\r\n");
      out.write("	    	          borderWidth: 3,\r\n");
      out.write("	    	          fill: true,\r\n");
      out.write("	    	          data: [50, 40, 300, 220, 500, 250, 400, 230, 500],\r\n");
      out.write("	    	          maxBarThickness: 6\r\n");
      out.write("\r\n");
      out.write("	    	        }],\r\n");
      out.write("	    	      },\r\n");
      out.write("	    	      options: {\r\n");
      out.write("	    	        responsive: true,\r\n");
      out.write("	    	        maintainAspectRatio: false,\r\n");
      out.write("	    	        plugins: {\r\n");
      out.write("	    	          legend: {\r\n");
      out.write("	    	            display: false,\r\n");
      out.write("	    	          }\r\n");
      out.write("	    	        },\r\n");
      out.write("	    	        interaction: {\r\n");
      out.write("	    	          intersect: false,\r\n");
      out.write("	    	          mode: 'index',\r\n");
      out.write("	    	        },\r\n");
      out.write("	    	        scales: {\r\n");
      out.write("	    	          y: {\r\n");
      out.write("	    	            grid: {\r\n");
      out.write("	    	              drawBorder: false,\r\n");
      out.write("	    	              display: true,\r\n");
      out.write("	    	              drawOnChartArea: true,\r\n");
      out.write("	    	              drawTicks: false,\r\n");
      out.write("	    	              borderDash: [5, 5]\r\n");
      out.write("	    	            },\r\n");
      out.write("	    	            ticks: {\r\n");
      out.write("	    	              display: true,\r\n");
      out.write("	    	              padding: 10,\r\n");
      out.write("	    	              color: '#fbfbfb',\r\n");
      out.write("	    	              font: {\r\n");
      out.write("	    	                size: 11,\r\n");
      out.write("	    	                family: \"Open Sans\",\r\n");
      out.write("	    	                style: 'normal',\r\n");
      out.write("	    	                lineHeight: 2\r\n");
      out.write("	    	              },\r\n");
      out.write("	    	            }\r\n");
      out.write("	    	          },\r\n");
      out.write("	    	          x: {\r\n");
      out.write("	    	            grid: {\r\n");
      out.write("	    	              drawBorder: false,\r\n");
      out.write("	    	              display: false,\r\n");
      out.write("	    	              drawOnChartArea: false,\r\n");
      out.write("	    	              drawTicks: false,\r\n");
      out.write("	    	              borderDash: [5, 5]\r\n");
      out.write("	    	            },\r\n");
      out.write("	    	            ticks: {\r\n");
      out.write("	    	              display: true,\r\n");
      out.write("	    	              color: '#ccc',\r\n");
      out.write("	    	              padding: 20,\r\n");
      out.write("	    	              font: {\r\n");
      out.write("	    	                size: 11,\r\n");
      out.write("	    	                family: \"Open Sans\",\r\n");
      out.write("	    	                style: 'normal',\r\n");
      out.write("	    	                lineHeight: 2\r\n");
      out.write("	    	              },\r\n");
      out.write("	    	            }\r\n");
      out.write("	    	          },\r\n");
      out.write("	    	        },\r\n");
      out.write("	    	      },\r\n");
      out.write("	    	    });\r\n");
      out.write("	    }\r\n");
      out.write("\r\n");
      out.write("   \r\n");
      out.write("  </script>\r\n");
      out.write("  <script>\r\n");
      out.write("    var win = navigator.platform.indexOf('Win') > -1;\r\n");
      out.write("    if (win && document.querySelector('#sidenav-scrollbar')) {\r\n");
      out.write("      var options = {\r\n");
      out.write("        damping: '0.5'\r\n");
      out.write("      }\r\n");
      out.write("      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);\r\n");
      out.write("    }\r\n");
      out.write("  </script>\r\n");
      out.write("  <!-- Github buttons -->\r\n");
      out.write("  <script async defer src=\"https://buttons.github.io/buttons.js\"></script>\r\n");
      out.write("  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->\r\n");
      out.write("  <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/template/admin/assets/js/argon-dashboard.min.js?v=2.0.4\"></script>\r\n");
      out.write("  \r\n");
      out.write("  <script>\r\n");
      out.write("	var classCr = location.search.split('action=')[1];\r\n");
      out.write("	if(classCr == \"index\" || classCr == \"DonationList\" || classCr == \"UserList\"){\r\n");
      out.write("	document.getElementsByClassName(classCr)[0].className += \" active\";}\r\n");
      out.write("	var str_page1 = document.getElementById(\"str-pages1\");\r\n");
      out.write("	var str_page2 = document.getElementById(\"str-pages2\");\r\n");
      out.write("	var str = \"\";\r\n");
      out.write("	if(classCr.startsWith(\"DonationList\") || classCr.startsWith(\"DonationSearch\") ) {\r\n");
      out.write("		str+=\"Đợt Quyên góp\";\r\n");
      out.write("	}\r\n");
      out.write("	if(classCr.startsWith(\"new\")) {\r\n");
      out.write("		str+=\"Đợt Quyên góp / Tạo Đợt Quyên góp\";\r\n");
      out.write("	}\r\n");
      out.write("	if(classCr.startsWith(\"edit\")) {\r\n");
      out.write("		str+=\"Đợt Quyên góp / Sửa Đợt Quyên góp\";\r\n");
      out.write("	}\r\n");
      out.write("	if(classCr.startsWith(\"UserList\") || classCr.startsWith(\"userSearch\")) {\r\n");
      out.write("		str+=\"Người Dùng\";\r\n");
      out.write("	}\r\n");
      out.write("	str_page1.innerHTML = str;\r\n");
      out.write("	if(classCr !== \"index\"){\r\n");
      out.write("		str_page2.innerHTML = str;\r\n");
      out.write("	}\r\n");
      out.write("	</script>\r\n");
      out.write("	\r\n");
      out.write("	<script>\r\n");
      out.write("	//Ckeditor\r\n");
      out.write("	 if ( location.search.split('action=')[1] == \"new\" || location.search.split('action=')[1].startsWith(\"edit\")){	\r\n");
      out.write("		var content = '';\r\n");
      out.write("		var thumbnail = '';\r\n");
      out.write("		$(document).ready(function() {\r\n");
      out.write("			content = CKEDITOR.replace('content');			\r\n");
      out.write("			CKFinder.setupCKEditor(content, 'ckfinder/');			\r\n");
      out.write("		});\r\n");
      out.write("	 }\r\n");
      out.write("	</script> \r\n");
      out.write("	\r\n");
      out.write("	<script>\r\n");
      out.write("	//Thời gian	\r\n");
      out.write("	if ( location.search.split('action=')[1].endsWith(\"t\")) {\r\n");
      out.write("		var today = new Date();\r\n");
      out.write("		var weekday = new Array(7);\r\n");
      out.write("		weekday[0] = \"Chủ Nhật\";\r\n");
      out.write("		weekday[1] = \"Thứ Hai\";\r\n");
      out.write("		weekday[2] = \"Thứ Ba\";\r\n");
      out.write("		weekday[3] = \"Thứ Tư\";\r\n");
      out.write("		weekday[4] = \"Thứ Năm\";\r\n");
      out.write("		weekday[5] = \"Thứ Sáu\";\r\n");
      out.write("		weekday[6] = \"Thứ Bảy\";\r\n");
      out.write("		var day = weekday[today.getDay()];\r\n");
      out.write("		var dd = today.getDate();\r\n");
      out.write("		var mm = today.getMonth() + 1;\r\n");
      out.write("		var yyyy = today.getFullYear();\r\n");
      out.write("		var h = today.getHours();\r\n");
      out.write("		var m = today.getMinutes();\r\n");
      out.write("		var s = today.getSeconds();\r\n");
      out.write("		m = checkTime(m);\r\n");
      out.write("		s = checkTime(s);\r\n");
      out.write("		nowTime = h + \":\" + m + \":\" + s;\r\n");
      out.write("		if (dd < 10) {\r\n");
      out.write("			dd = '0' + dd\r\n");
      out.write("		}\r\n");
      out.write("		if (mm < 10) {\r\n");
      out.write("			mm = '0' + mm\r\n");
      out.write("		}\r\n");
      out.write("		today = day + ', ' + dd + '/' + mm + '/' + yyyy;\r\n");
      out.write("		tmp = '<i class=\"fa fa-clock-o\" aria-hidden=\"true\"></i> <span class=\"date\">'\r\n");
      out.write("				+ today + ' | ' + nowTime + '</span>';\r\n");
      out.write("		document.getElementById(\"clock\").innerHTML = tmp;\r\n");
      out.write("\r\n");
      out.write("		function checkTime(i) {\r\n");
      out.write("			if (i < 10) {\r\n");
      out.write("				i = \"0\" + i;\r\n");
      out.write("			}\r\n");
      out.write("			return i;\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	</script> \r\n");
      out.write("	\r\n");
      out.write("	<script>\r\n");
      out.write("	if ( location.search.split('action=')[1].startsWith(\"edit\")){\r\n");
      out.write("		var number = document.getElementById(\"totalNeeded\").value;\r\n");
      out.write("		document.getElementById(\"totalNeeded\").value = new Intl.NumberFormat().format(number);		\r\n");
      out.write("	}\r\n");
      out.write("	</script>\r\n");
      out.write("	\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>  ");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}