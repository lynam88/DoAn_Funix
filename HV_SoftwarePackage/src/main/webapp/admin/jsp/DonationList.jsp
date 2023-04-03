<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="header.jsp">
	<c:param name="title" value="Danh Sách Đợt Quyên Góp"></c:param>
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
				action="${pageContext.request.contextPath}/DonationsController?action=DonationSearch" method="post">
				
					<input type="text" id="myInput" name="myInput" var="myInput"
						placeholder="Nhập từ khoá..." value="${searchText}">
					<select id="searchStatus" name="searchStatus">
						<option value="0" selected>Trạng Thái Quyên Góp</option>
						<option value="1"
						<c:if test="${searchStatus == 1}">selected</c:if>>Hoàn
						Thành</option>
						<option value="2"
						<c:if test="${searchStatus == 2}">selected</c:if>>Chưa
						Hoàn Thành</option>
					</select>
					<select id="category" name="category">
						<option value="0" selected>Phân Loại Quyên Góp</</option>
						<option value="1"
						<c:if test="${category == 1}">selected</c:if>>Vì Trẻ Em</option>
						<option value="2"
						<c:if test="${category == 2}">selected</c:if>>Người Già, Người Khuyết Tật</option>
						<option value="3"
						<c:if test="${category == 3}">selected</c:if>>Bệnh Hiểm Nghèo</option>
						<option value="4"
						<c:if test="${category == 4}">selected</c:if>>Đầu Tư Cơ Sở Vật Chất</option>
						<option value="5"
						<c:if test="${category == 5}">selected</c:if>>Bảo Vệ Môi Trường</option>
					</select>								
					<button class="btn nv btn-primary" id="searchButton">
						<i class="fa fa-search"></i> Tìm kiếm
					</button>
		
			</form>
			<p class="pageTitle"><b>CHỨC NĂNG CHÍNH:</b></p>
			<div class="pageTitle">
				
				<a	class="btn nv btn-primary functionBtnBtn" type="button" href="${pageContext.request.contextPath}/DonationsController?action=new"
					data-toggle="tooltip" data-placement="top"> <i
					class="fa fa-plus-square"></i> Tạo mới 
				</a> 		
						
				<a class="btn nv btn-primary functionBtn" type="button" onclick="sortTable()"
					data-toggle="tooltip" data-placement="top"> <i
					class="fa fa-filter" aria-hidden="true"></i> Sắp Xếp
				</a> 
				
				 <a class="btn nv btn-primary functionBtn" href="${pageContext.request.contextPath}/DonationsController?action=export"><i
					class="fas fa-file-export"></i> Xuất File</a>
				
			</div>	
			
            <div class="card-body px-0 pt-0 pb-2">
              <div class="p-0">
                <table class="table table-bordered" id="myTable">
					<thead class="text-center">
					    <tr>
					        <th style="width: 2%;">Chọn</th>
					        <th style="width: 4%;">Hoàn Thành</th>
					        <th style="width: 6%;">Đợt Quyên Góp</th>
					        <th style="width: 18%;">Nội Dung</th>
					        <th style="width: 4%;">Thời Gian</th>
					        <th style="width: 7%;">Phân Loại</th>
					        <th style="width: 3%;">Action</th>
					    </tr>
					</thead>
					<tbody>
					    <c:forEach var="donation" items="${DonationList}">
					        <tr>
					            <td><input type="checkbox" class="chk" name="chk"
					                value="<c:out value='${donation.id}' />"></td>
					            <td> <div class="form-check form-switch"><input class="form-check-input" type="checkbox" role="switch" id="complete" name="complete" disabled value="<c:out value='${donation.id}' />"
					                <c:if test="${donation.status == 1}">checked</c:if>/> </div>
					 			</td>
					            <td>
					                <div>
					                    <div class="content hideContent">${donation.title}</div>
					                    <div class="show-more">
					                        <a type="button" style="color: blue;">Hiển thị thêm</a>
					                    </div>
					                </div>                                
					            </td>
					            <td>
					                <div>
					                    <div class="content hideContent">${donation.content}</div>
					                    <div class="show-more">
					                        <a type="button" style="color: blue;">Hiển thị thêm</a>
					                    </div>
					                </div>
					            </td>
					            <td>
					                <c:out value="${donation.startDate}"/> - <c:out value="${donation.endDate}" />
					            </td>
					            <td>
					            	<c:if test="${donation.category == 1}">Vì trẻ em</c:if>					            
					            	<c:if test="${donation.category == 2}">Người Già, Người Khuyết Tật</c:if>
					            	<c:if test="${donation.category == 3}">Bệnh Hiểm Nghèo</c:if>
					            	<c:if test="${donation.category == 4}">Đầu Tư Cơ Sở Vật Chất</c:if>
					            	<c:if test="${donation.category == 5}">Bảo Vệ Môi Trường</c:if>
					            </td>
					            <td id="edit"><a class="edit"
					                href="DonationsController?action=edit&id=${donation.id}&page=${currentPage}"
					                title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
					                    aria-hidden="true"></i></a></td>
					        </tr>
					    </c:forEach>
					</tbody>
				</table>				
			
				<nav aria-label="..." class="page">
				  <ul class="pagination">
				  
				    <li class="page-item">
				      <a type="button" class="btn page-link" href="${pageContext.request.contextPath}/DonationsController?action=DonationList&myInput=${searchText}&searchStatus=${searchStatus}&category=${category}&page=1" tabindex="-1">First</a>
				    </li> 				 
				   
				   <c:forEach var="i" begin="1" end="${noOfPage}">		
						<c:choose>
							<c:when test="${currentPage eq i}">								
								<li class="page-item active">
							      <a class="page-link"> ${i} <span class="sr-only">(current)</span></a>
							    </li>
							</c:when>
							<c:otherwise>								
								<li class="page-item" ><a type="button" class="btn page-link" href="${pageContext.request.contextPath}/DonationsController?action=DonationList&myInput=${searchText}&searchStatus=${searchStatus}&category=${category}&page=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>						
				   </c:forEach>			   
				   
				    <li class="page-item">
				      <a type="button" class="btn page-link" href="${pageContext.request.contextPath}/DonationsController?action=DonationList&myInput=${searchText}&searchStatus=${searchStatus}&category=${category}&page=${noOfPage}">Last</a>
				    </li>
				    
				  </ul>
				</nav>
				<div class="pageTitle">
					<input type="button" class="btn btn-success" onclick='selects()' value="Chọn Tất Cả"/>  
			        <input type="button" class="btn btn-success" onclick='deSelect()' value="Bỏ Chọn Tất Cả""/>
					<div>
					<a type="button" class="btn btn-danger deleteBtn" id="donation_del"
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
								<button type="button" class="close" data-dismiss="modal" id="close_donation_del">&times;</button>
							</div>
							<div class="modal-body">
								<p style="font-size: large;">Bạn thật sự muốn xóa?</p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-ok btn-danger" id="ok_donation_del"
									data-dismiss="modal">Chấp nhận</button>
								<button type="button" class="btn btn-default btn-success" id="cancel_donation_del"
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