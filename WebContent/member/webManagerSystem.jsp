<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
	List<MemberVO> list = (List<MemberVO>)request.getAttribute("list");
	if(list == null){
		MemberService memberSvc = new MemberService();
		list = memberSvc.getAll();
		pageContext.setAttribute("list", list);
	}else{
		pageContext.setAttribute("list", list);
	}
%>


<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="../share/backend/Bmeta.file"%>
<title>Web Manager System UnderWater</title>
<style>
.navbar h1 {
	color: white;
	text-align: center;
}

.navbar h3 {
	color: white;
	margin-top: 27px;
}

#navInfo {
	position: relative;
	height: 80px;
}

#systemName {
	width: 500px;
	height: 80px;
	position: absolute;
	left: 50%;
	margin-left: -250px;
}

#systemInfo {
	width: 250px;
	height: 80px;
	position: absolute;
	right: 0;
	line-height: 1em;
}

.table {
	margin-top: 20px;
}

.container {
	position: relative !important;
}

.popBox {
	border: solid;
	width: 750px;
	height: 750px;
	position: absolute;
	left: 50%;
	top: 20%;
	margin-left: -250px;
	z-index: 100;
	background-color: white;
	text-align: center;
	display: none;
}

.popBox input {
	margin-top: 10px;
}


</style>
<link rel="stylesheet" href="css/bootstrap.css" />
</head>

<body>
<%@ include file="../share/backend/Bheader.file"%>

<div class="container">
 		<div class="row">
            <div class="col-lg-1">

            </div>
            <form action="<%=request.getContextPath()%>/member/MemberListServlet.do" method="post" style="width:82%">
            <div class="col-lg-6">
                <div class="input-group">
                    <input type="text" class="form-control" name="keyword" placeholder="????????????" id="searchInput">
                    <span class="input-group-btn">
                    	<input type="hidden" name="action" value="search">
                        <input class="btn btn-default" type="submit" value="??????">
                    </span>
                </div>
            </div>
			</form>
            <div class="col-lg-1" >
            	<form action="WebManagerSystemLogoutServlet.do" method="post">
            		<button class="btn btn-primary" type="submit" id="logout" >??????</button>
            	</form>
            	
            </div>
            <div><c:if test="${msg!=null}"> ${msg}</c:if></div>
        </div>
		
		<table class="table table-striped" style="text-align:center;">
                <tr>
					<td>??????</td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>????????????</td>
		   			<td>???????????????</td>
					<td>??????</td>
					<td>????????????</td>
					<td>????????????</td>
					<td>????????????</td>
					<td>????????????</td>
					<td>????????????</td>
					<td>????????????</td>
                </tr>
            <%@ include file="page1.file" %> 
           <c:forEach var="memberVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${memberVO.userID}</td>
			<td>${memberVO.account}</td>
			<td>${memberVO.nickName}</td>
			<td>${memberVO.userName}</td>
			<td>${memberVO.gender}</td>
			<td>${memberVO.birthDate}</td>
			<td>${memberVO.phone}</td>
			<td>${memberVO.certification}</td>
			<td><div class="picture"><img class="preview" src="GetImageCertificationPic.do?userid=${memberVO.userID}"></div></td>
			<td>${memberVO.personID}</td>
			<td>${memberVO.address}</td>
			<td>${memberVO.createTime}</td>
			<td>${memberVO.status}</td>
			<td>${memberVO.upDateTime}</td>
			<td>${memberVO.ratePeople}</td>
			<td>${memberVO.ratePoint}</td>
			<td><div class="picture"><img class="preview" src="GetImagepersonPhoto.do?userid=${memberVO.userID}"></div></td>
			<td>
				<form method="post"  action="<%=request.getContextPath()%>/member/MemberListServlet.do" >
					<input type="submit" class="update btn btn-primary btn-user" value="??????" onclick="showupdatediv();">
					<input type="hidden" name="userid"  value="${memberVO.userID}">
					<input type="hidden" name="action" value="getOne_For_Update">
				</form>
			</td>
		</tr>
	</c:forEach>
            </tbody>
        </table>
<%@ include file="page2.file"%>	



</div>
<%@ include file="../share/backend/Bfooter.file"%>
<%@ include file="../share/backend/Bjs.file"%>
</body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<script>
	
	$.datetimepicker.setLocale('zh');
    var today = new Date();
    $('.birthdate').datetimepicker({
    	theme: '',          //theme: 'dark',
        timepicker: false,   //timepicker: false,??????true
//         step: 60,            //step: 60 (??????timepicker???????????????60??????)
	       format: 'Y-m-d',
// 	       value: new Date(),
        //disabledDates:    ['2017/06/08','2017/06/09','2017/06/10'], // ??????????????????
        //startDate:	        '2017/07/10',  // ?????????
        //minDate:           '-1970-01-01', // ????????????(??????)??????
        maxDate:           '+1970-01-01'  // ????????????(??????)??????
     });
	//????????????????????????????????????
   const updateSureBtn = document.getElementById("updateSure");
    const addMember = document.getElementById("addMember");
    const searchInput = document.getElementById("searchInput");
    const search = document.getElementById("search");
	
    var popBox;
    window.onload = function(){
    	popBox = document.getElementById("popBox");
    };
    
    //??????????????????
    function showupdatediv(){
    	popBox.style.display="block";
    }
    //??????????????????
    function closeupdatediv(){
    	popBox.style.display="none";
    }
    </script>



</html>