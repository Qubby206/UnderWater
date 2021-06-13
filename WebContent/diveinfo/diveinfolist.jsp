<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.diveinfo.model.*"%>

<%
	DiveInfoService diveinfoSvc = new DiveInfoService();
	List<DiveInfoVO> list = diveinfoSvc.getAll();
	pageContext.setAttribute("list", list);
%>
<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
/*     text-align: center; */
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
/*     text-align: center; */
  }
</style>


<html>
<head>
<meta charset="BIG5">
<title>潛點資訊列表</title>
</head>
<body>
	<table>
		<tr>
			<th>潛點編號</th>
			<th>潛點名稱</th>
			<th>緯度</th>
			<th>經度</th>
			<th>簡介</th>
			<th>詳細介紹</th>
			<th>適合季節</th>
			<th>地區</th>
			<th>照片</th>
			<th>評價人數</th>
			<th>評價總分</th>
			<th>狀態</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="diveinfoVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${diveinfoVO.pointSN}</td>
				<td>${diveinfoVO.pointName}</td>
				<td>${diveinfoVO.latitude}</td>
				<td>${diveinfoVO.longitude}</td>
				<td>${diveinfoVO.view}</td>
				<td>${diveinfoVO.introduction}</td>
				<td>${diveinfoVO.season}</td>
				<td>${diveinfoVO.local}</td>
				<td><img src="<%=request.getContextPath()%>/diveinfo/ShowPic?pointSN=${diveinfoVO.pointSN}"></td>
				<td>${diveinfoVO.ratePoint}</td>
				<td>${diveinfoVO.ratePeople}</td>
				<td>${diveinfoVO.status}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/emp/emp.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="empno" value="${diveinfoVO.pointSN}"> <input type="hidden"
							name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/emp/emp.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="empno" value="${diveinfoVO.pointSN}"> <input type="hidden"
							name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>