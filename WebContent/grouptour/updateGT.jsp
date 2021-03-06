<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.grouptour.model.*"%>

<%  // 抓取新增失敗時回傳的VO
	GroupTourVO groupTourVO = (GroupTourVO) request.getAttribute("groupTourVO");
%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../share/backend/Bmeta.file" %>
<title>Update Group Tour</title>
<style>
	.container{
		margin: 0 auto;  
 		width: 1200px; 
		display: flex;
	}
	img{
		width: 100%;
	}	
	tr td{
		padding: 5px;
		padding-right: 20px;
	}
	.input1{
		width: 420px;
	}
	#editor{
		width: 420px;
		height: 100px;
	}
	.submit_btn{
		padding-top: 20px;
		padding-left: 50%;
		margin-bottom: 20px;
	}
</style>
</head>
<body>
    <%@ include file="../share/backend/Bheader.file" %>
    <div class="container">

        <div class="col-lg-7">
        <h1 class="h3 mb-2 text-gray-800">更新套裝行程</h1>
        <p class="mb-4">更新既有套裝行程商品，更改狀態前請留意是否有會員已報名</p>
    
    <form method="post" action="grouptour.do" enctype="multipart/form-data">
    <table>
        <tr>
            <td>行程名稱</td>
            <td><input class="input1" type="TEXT" name="tourName" value="<%= (groupTourVO==null)?"":groupTourVO.getTourName()%>" /></td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td>套裝行程圖</td>
            <td>
                <input type="file" id="the_file" name="tourPic" accept="image/*">
<%--                 <div class="picture"><img class='preview' src="GetImage.do?id=${groupTourVO.groupTourSN}"></div> --%>
            </td>
        </tr>
	  	<tr>
			<td>行程時間</td>
			<td>
				<input type="TEXT" class="startDate" name="startTime" autocomplete="off" value="<%=(groupTourVO==null)?"":groupTourVO.getStartTime()%>" />
				<span>  -  </span>
				<input type="TEXT" class="endDate" name="endTime" autocomplete="off" value="<%= (groupTourVO==null)?"":groupTourVO.getEndTime()%>" />
			
			</td>
		</tr>
		<tr>
			<td>報名時間</td>
			<td>
				<input type="TEXT" class="startDate" name="regTime" autocomplete="off" value="<%= (groupTourVO==null)?"":groupTourVO.getRegTime()%>" />
				<span>  -  </span>
				<input type="TEXT" class="endDate" name="closeTime" autocomplete="off" value="<%= (groupTourVO==null)?"":groupTourVO.getCloseTime()%>" />
			</td>
		</tr>
        
        <jsp:useBean id="diveInfoSvc" scope="page" class="com.diveinfo.model.DiveInfoService"></jsp:useBean>
        <tr>
            <td>潛點</td>
            <td><select class="input1" name="pointSN" size="1" >
                <c:forEach var="diveInfoVO" items="${diveInfoSvc.all}">
                    <option value="${diveInfoVO.pointSN}" ${(groupTourVO.pointSN==diveInfoVO.pointSN)? 'selected':''}>${diveInfoVO.pointName}
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td>售價</td>
            <td><input class="input1" type="TEXT" name="price" value="<%= (groupTourVO==null)?"":groupTourVO.getPrice()%>" /></td>
        </tr>
        <tr>
            <td>人數限制</td>
            <td><span>${groupTourVO.attendNumber} / </span>
                <select name="limitNumder" size="1">
                    <option value="1" ${(groupTourVO.limitNumder==1)? 'selected':'' }>1
                    <option value="2" ${(groupTourVO.limitNumder==2)? 'selected':'' }>2
                    <option value="3" ${(groupTourVO.limitNumder==3)? 'selected':'' }>3
                    <option value="4" ${(groupTourVO.limitNumder==4)? 'selected':'' }>4
                    <option value="5" ${(groupTourVO.limitNumder==5)? 'selected':'' }>5
                    <option value="6" ${(groupTourVO.limitNumder==6)? 'selected':'' }>6
                    <option value="7" ${(groupTourVO.limitNumder==7)? 'selected':'' }>7
                    <option value="8" ${(groupTourVO.limitNumder==8)? 'selected':'' }>8
                    <option value="9" ${(groupTourVO.limitNumder==9)? 'selected':'' }>9
                    <option value="10" ${(groupTourVO.limitNumder==10)? 'selected':'' }>10
                </select>
            </td>
        </tr>
        <tr>
            <td>證照資格</td>
            <td>
                <select class="input1" name="certificationLimit" size="1">
                    <option value="0" ${(groupTourVO.certificationLimit==0)? 'selected':'' }>不須證照
                    <option value="1" ${(groupTourVO.certificationLimit==1)? 'selected':'' }>PADI OW / SSI OW
                    <option value="2" ${(groupTourVO.certificationLimit==2)? 'selected':'' }>PADI AOW / SSI AOW
                </select>
            </td>
        </tr>
        <tr>
            <td>status</td>
            <td>
<%--             <input type="TEXT" name="status" size="45" value="<%= (groupTourVO==null)?"":groupTourVO.getStatus()%>" /> --%>
            <select class="input1" name=status size="1">
				<option value="0" ${(groupTourVO.status==0)? 'selected':'' }>上架行程
				<option value="1" ${(groupTourVO.status==1)? 'selected':'' }>下架行程
				<option value="2" ${(groupTourVO.status==2)? 'selected':'' }>取消行程
			</select>
            </td>
        </tr>
        <tr>
			<td>行程內容</td>
			<td>
            <div><textarea id="editor" name="content"><%=(groupTourVO==null)?"":groupTourVO.getContent()%></textarea></div>
			</td>
		</tr>
    
    </table>
    
<div class="submit_btn">	   
    <input type="hidden" name="groupTourSN" value="<%=(groupTourVO==null)?"":groupTourVO.getGroupTourSN()%>">
    <input type="hidden" name="attendNumber" value="<%=(groupTourVO==null)?"":groupTourVO.getAttendNumber()%>">
    <input type="hidden" name="action" value="update">
    <input class="btn btn-primary btn-user" type="submit" value="修改">
    <input class="btn btn-primary btn-user" type ="button" onclick="window.location.href='<%=request.getContextPath()%>/grouptour/backendListGT.jsp'" value="上一頁">
</div>
    
    </form>
</div><%-- col-lg-7 end --%>

<div class="col-lg-4">

    <!-- 圖片預覽 -->
    <div class="card shadow mb-4">
       <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Picture</h6>
            </a>
       <!-- Card Content - Collapse -->
           <div class="collapse show" id="collapseCardExample" style="">
                   <div class="card-body">
                       <%-- 行程圖片 --%>
                       <div class="picture"><img class='preview' src="GetImage.do?id=${groupTourVO.groupTourSN}"></div>
                   </div>
           </div>
     </div>
     
     <!-- 團員預覽 -->
     <div class="card shadow mb-4">
       <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">已報名團員</h6>
            </a>
       <!-- Card Content - Collapse -->
		<jsp:useBean id="orderForGroupSvc" scope="page" class="com.orderforgroup.model.OrderForGroupService"></jsp:useBean>
		<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService"></jsp:useBean>

           <div class="collapse show" id="collapseCardExample" style="">
                   <div class="card-body">
                   	<p><c:forEach var="userID" items="${orderForGroupSvc.getMember(groupTourVO.groupTourSN)}">
                       ${memSvc.getone(userID).userName}<br>
                     </c:forEach></p>
                   </div>
           </div>
     </div>
     
    <!-- Err msg -->
    <c:if test="${not empty errMsg}">
     <div class="mb-4">
    <div class="card border-left-warning shadow h-100 py-2">
        <div class="card-body">
            <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                Error Messages</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                            
                            <div class="card-body" style="color:LightCoral">
                                <c:forEach var="message" items="${errMsg}">
                                    - ${message}<br>
                                </c:forEach>
                            </div>
                </div>
            <div class="col-auto">
            <i class="fas fa-comments fa-2x text-gray-300"></i>
        </div></div></div></div>
                
    </div></c:if></div><%-- col-lg-4 end --%>	




    <%-- 錯誤表列 --%>
    <c:if test="${not empty errMsg}">
        <script>
            alert("內容有誤，請再確認");
        </script>
    </c:if>
    
</div><%-- container end --%>
    
<%@ include file="../share/backend/Bfooter.file" %>
</body>
<%@ include file="../share/backend/Bjs.file" %>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<script>

	// dateTimePicker
	$.datetimepicker.setLocale('zh');
     var today = new Date();
     $('.startDate').datetimepicker({
	       timepicker:false,
	       format:'Y-m-d',
		   beforeShowDay: function(date) {
       	  if (  date.getYear() <  today.getYear() || 
		       (date.getYear() == today.getYear() && date.getMonth() <  today.getMonth()) || 
		       (date.getYear() == today.getYear() && date.getMonth() == today.getMonth() && date.getDate() < today.getDate())
	          ) {
	               return [false, ""]
	          }
	          return [true, ""];
    	}});
     
     $('.endDate').datetimepicker({
	       timepicker:false, 
	       format:'Y-m-d',
		   beforeShowDay: function(date) {
     	  if (  date.getYear() <  today.getYear() || 
		       (date.getYear() == today.getYear() && date.getMonth() <  today.getMonth()) || 
		       (date.getYear() == today.getYear() && date.getMonth() == today.getMonth() && date.getDate() < today.getDate())
	          ) {
	               return [false, ""]
	          }
	          return [true, ""];
  		}});
     
     window.addEventListener("DOMContentLoaded", function(){

    	// 顯示上傳圖片

	var the_file = document.getElementById("the_file");
		the_file.addEventListener("change", function(e) {

			var picture = document.getElementsByClassName("picture")[0];
			picture.innerHTML = ""; // 清空東西 

			let reader = new FileReader();
			reader.readAsDataURL(this.files[0]);
			reader.addEventListener("load",
					function() {

						var pic_src = reader.result; // 取得圖片編碼
						picture.innerHTML = "<img class='review'>";
						document.querySelector(".review").setAttribute('src',
								pic_src);
					})
		});

	});
</script>
</html>