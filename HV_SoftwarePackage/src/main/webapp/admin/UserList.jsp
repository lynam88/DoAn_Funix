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
				<b>DANH SÁCH NGƯỜI DÙNG:</b>
			</p>

			<form class="searchbar" name="searchform"
				action="${pageContext.request.contextPath}/UsersController?action=userSearch" method="post">
				
					<input type="text" id="myInput" name="myInput" var="myInput"
						placeholder="Nhập từ khoá..." value="${searchText}">
					<select id="searchStatus" name="searchStatus">
						<option value="0" selected>Tất cả</option>
						<option value="1"
						<c:if test="${searchStatus == 1}">selected</c:if>>Admin</option>
						<option value="2"
						<c:if test="${searchStatus == 2}">selected</c:if>>User</option>
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
							<th style="width: 3%;">Loại</th>
							<th style="width: 7%;">Họ và tên</th>
							<th style="width: 14%;">Email</th>
							<th style="width: 5%;">Phone</th>
							<th style="width: 5%;">Địa Chỉ</th>
							<th style="width: 2%;">Sửa</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${UserList}">
							<tr>
								<c:choose>
									<c:when test="${user.role == 1}">
										<td><input type="checkbox" class="chk" name="chk" disabled value="<c:out value='${user.email}'/>"/></td>
									</c:when>
									<c:otherwise>
										<td><input type="checkbox" class="chk" name="chk" value="<c:out value='${user.email}'/>"/></td>
									</c:otherwise>
								</c:choose>
								<c:if test="${user.role == 1}">
									<td>Admin</td>
								</c:if>
								<c:if test="${user.role == 2}">
									<td>User</td>
								</c:if>
								<c:if test="${user.role == null}">
									<td></td>
								</c:if>
								<td>							
									<div class="content hideContent">${user.name}</div>													
								</td>
								<td>			
									<div class="content hideContent">${user.email}</div>								
								</td>
								<td><c:out value="${user.phone}"/></td>
								<td><c:out value="${user.address}" /></td>
								<td><a class="edit"
									href="UsersController?action=edit&email=${user.email}&page=${currentPage}"
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
				      <a type="button" class="btn page-link" href="${pageContext.request.contextPath}/UsersController?action=UserList&myInput=${searchText}&searchStatus=${searchStatus}&page=1" tabindex="-1">First</a>
				    </li> 				 
				   
				   <c:forEach var="i" begin="1" end="${noOfPage}">		
						<c:choose>
							<c:when test="${currentPage eq i}">								
								<li class="page-item active">
							      <a class="page-link"> ${i} <span class="sr-only">(current)</span></a>
							    </li>
							</c:when>
							<c:otherwise>								
								<li class="page-item" ><a type="button" class="btn page-link" href="${pageContext.request.contextPath}/UsersController?action=UserList&myInput=${searchText}&searchStatus=${searchStatus}&page=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>						
				   </c:forEach>			   
				   
				    <li class="page-item">
				      <a type="button" class="btn page-link" href="${pageContext.request.contextPath}/UsersController?action=UserList&myInput=${searchText}&searchStatus=${searchStatus}&page=${noOfPage}">Last</a>
				    </li>
				    
				  </ul>
				</nav>
				<div class="pageTitle">
					<input type="button" class="btn btn-success" onclick='selects()' value="Chọn Tất Cả"/>  
			        <input type="button" class="btn btn-success" onclick='deSelect()' value="Bỏ Chọn Tất Cả""/>
					<div>
					<a type="button" class="btn btn-danger deleteBtn" id="user_del"
						 title="Xóa" data-toggle="tooltip"><i
						class="fa fa-trash-o" aria-hidden="true"></i> Xoá các mục đã chọn</a> </div>					
				</div>
				<!--Modal -->
				<div class="modal" id="myModal" role="dialog">
					<div class="modal-dialog modal-dialog-centered" tabindex="-1 role="document">
						<!--Modal content -->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" id="close_user_del">&times;</button>
							</div>
							<div class="modal-body">
								<p style="font-size: large;">Bạn thật sự muốn xóa?</p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-ok btn-danger" id="ok_user_del"
									data-dismiss="modal">Chấp nhận</button>
								<button type="button" class="btn btn-default btn-success" id="cancel_user_del"
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