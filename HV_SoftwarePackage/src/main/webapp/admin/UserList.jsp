<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Danh Sách Người Dùng"></c:param>
</c:import>

<div class="container-fluid py-4">
	<div class="row">
        <div class="col-12">
          <div class="card mb-4">
          
          	<div id="clock"></div>
          	                   
			<p class="pageTitle">
				<b>DANH SÁCH ĐỢT QUYÊN GÓP:</b>
			</p>

			<form class="searchbar" name="searchform"
				action="${pageContext.request.contextPath}/UsersController?action=search" method="post">
				
					<input type="text" id="myInput" name="myInput" var="myInput"
						placeholder="Nhập từ khoá..." value="${searchText}">
					<select id="searchStatus" name="searchStatus">
						<option value="0" selected>Tất cả</option>
						<option value="1"
						<c:if test="${searchStatus == 0}">selected</c:if>>Admin</option>
						<option value="2"
						<c:if test="${searchStatus == 1}">selected</c:if>>User</option>
					</select>				
					<button class="btn nv btn-primary" id="searchButton">
						<i class="fa fa-search"></i> Tìm kiếm
					</button>
		
			</form>
			<p class="pageTitle"><b>CHỨC NĂNG CHÍNH:</b></p>
			<div class="pageTitle">
				
				<a	class="btn nv btn-primary pageBtn" type="button" href="${pageContext.request.contextPath}/UsersController?action=new"
					data-toggle="tooltip" data-placement="top"> <i
					class="fa fa-plus-square"></i> Tạo mới 
				</a> 		
						
				<a class="btn nv btn-primary pageBtn" type="button" onclick="sortTable()"
					data-toggle="tooltip" data-placement="top"> <i
					class="fa fa-filter" aria-hidden="true"></i> Sắp Xếp
				</a> 
				
				<a class="btn nv btn-primary pageBtn" id="export" type="button" data-target="#exportModal" data-toggle="modal"
					> <i
					class="fas fa-file-export"></i> Xuất File
				</a>
				
				<div class="modal" id="exportModal" role="dialog">
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
								<p class="text-center" id="exportMsg"
									style="font-size: large; color: red;"></p>
							</div>
						</div>
		
					</div>			
						
				</div>			
				
			</div>	
			
            <div class="card-body px-0 pt-0 pb-2">
              <div class="p-0">
                <table class="table table-bordered" id="myTable">
					<thead>
						<tr>
							<th style="width: 2%;">Chọn</th>
							<th style="width: 6%;">Loại</th>
							<th style="width: 6%;">Họ và tên</th>
							<th style="width: 20%;">Email</th>
							<th style="width: 4%;">Phone</th>
							<th style="width: 4%;">Địa Chỉ</th>
							<th style="width: 2%;">Sửa</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${donationList}">
							<tr>
								<td><input type="checkbox" name="chk" />"></td>
								<c:if test="${user.status == 1}">
									<td>Hoàn Thành</td>
								</c:if>
								<c:if test="${user.status == 2}">
									<td>Chưa Hoàn Thành</td>
								</c:if>
								<c:if test="${user.status == null}">
									<td></td>
								</c:if>
								<td><c:out value="" />
									<div>
										<div class="content hideContent">${user.title}</div>
										<div class="show-more">
											<a type="button" style="color: blue;">Hiển thị thêm</a>
										</div>
									</div>								
								</td>
								<td>
									<div>
										<div class="content hideContent" style="zoom: 77%;">${user.content}</div>
										<div class="show-more">
											<a type="button" style="color: blue;">Hiển thị thêm</a>
										</div>
									</div>
								</td>
								<td><c:out value="${donUsersControllerartDate}"/></td>
								<td><c:out value="${user.endDate}" /></td>
								<td><a class="edit"
									href="UsersController?action=edit&id=${donation.id}&page=${currentPage}"
									title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
										aria-hidden="true"></i></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<% String searchText = (String) request.getAttribute("myInput");
				   String searchStatus = (String) request.getAttribute("searchStatus");					
				%>
				
				<nav aria-label="..." class="page">
				  <ul class="pagination">
				  
				    <li class="page-item">
				      <a type="button" class="btn page-link" href="${pageContext.request.contextPath}/UsersController?action=list&myInput=${searchText}&searchStatus=${searchStatus}&page=1" tabindex="-1">First</a>
				    </li> 				 
				   
				   <c:forEach var="i" begin="1" end="${noOfPage}">		
						<c:choose>
							<c:when test="${currentPage eq i}">								
								<li class="page-item active">
							      <a class="page-link"> ${i} <span class="sr-only">(current)</span></a>
							    </li>
							</c:when>
							<c:otherwise>								
								<li class="page-item" ><a type="button" class="btn page-link" href="${pageContext.request.contextPath}/UsersController?action=list&myInput=${searchText}&searchStatus=${searchStatus}&page=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>						
				   </c:forEach>			   
				   
				    <li class="page-item">
				      <a type="button" class="btn page-link" href="${pageContext.request.contextPath}/UsersController?action=list&myInput=${searchText}&searchStatus=${searchStatus}&page=${noOfPage}">Last</a>
				    </li>
				    
				  </ul>
				</nav>
				<div class="pageTitle">
					<input type="button" class="btn btn-success" onclick='selects()' value="Chọn Tất Cả"/>  
			        <input type="button" class="btn btn-success" onclick='deSelect()' value="Bỏ Chọn Tất Cả""/>
					<div>
					<a type="button" class="btn btn-danger deleteBtn" id="btn_del"
						 title="Xóa" data-toggle="tooltip"><i
						class="fa fa-trash-o" aria-hidden="true"></i> Xoá các mục đã chọn</a> </div>
					<input type="hidden" id="donation_id" value="<c:out value='${donation.id}' />" />
				</div>
				<!--Modal -->
				<div class="modal" id="myModal" role="dialog">
					<div class="modal-dialog modal-dialog-centered" tabindex="-1 role="document">
						<!--Modal content -->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" id="close_del">&times;</button>
							</div>
							<div class="modal-body">
								<p style="font-size: large;">Bạn thật sự muốn xóa?</p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-ok btn-danger" id="ok_del"
									data-dismiss="modal">Chấp nhận</button>
								<button type="button" class="btn btn-default btn-success" id="cancel_del"
									data-dismiss="modal">Hủy</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal" id="showDelete" role="dialog">
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
								<p class="text-center" id="showMsg"
									style="font-size: large; color: red;"></p>
							</div>
						</div>
		
					</div>
				</div>
				
				<div class="modal" id="checkMsg" role="dialog">
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
								<p class="text-center" id="checkMsg"
									style="font-size: large; color: red;">Vui lòng chọn mục để xoá.</p>
							</div>
						</div>
		
					</div>
				</div>								
              </div>
            </div>
          </div>
        </div>
      </div>

	<c:import url="footer.jsp"></c:import>