<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="diveInfoSvc" scope="page" class="com.diveinfo.model.DiveInfoService"/>
<jsp:useBean id="partyMemberSvc" scope="page" class="com.partymember.model.PartyMemberService" />


<!DOCTYPE html>
<html>
<head>
	<%@ include file="../share/backend/Bmeta.file" %>
	<title>揪團後台修改</title>
</head>
<body>
<%@ include file="../share/backend/Bheader.file" %>

<h2>揪團後台修改</h2>
<form method="post" action="<%=request.getContextPath()%>/party/party.do">
	<table>
		<tr>
			<td class="partySN">揪團編號： </td>
			<td><input type="text" name="partySN" value="${partyVO.partySN}" readonly></td>
		</tr>
		<tr>
			<td class="partyHost">主揪人： </td>
			<td><input type="text" name="partyHost" value="${partyVO.partyHost}" readonly></td>
		</tr>
		<tr>
			<td class="partyTitle">揪團主旨: </td>
			<td><input type="text" name="partyTitle" value="${partyVO.partyTitle}"></td>
		</tr>
		<tr>
			<td class="date">活動日期: </td>
			<td>
				<input type="date" name="startDate" value="${partyVO.startDate}"> 至  <input type="date" name="endDate" value="${partyVO.endDate}">
			</td>
		</tr>
		<tr>
			<td class="regDate">報名開放日期: </td>
			<td><input type="date" name="regDate" value="${partyVO.regDate}"></td>
		</tr>
		<tr>
			<td class="closeDate">報名截止日期: </td>
			<td><input type="date" name="closeDate" value="${partyVO.closeDate}"></td>
		</tr>
		<tr>
			<td class="partyLocation">揪團潛點: </td>
			<td>
				<select size="" name="partyLocation">
				<c:forEach var="diveInfoVO" items="${diveInfoSvc.getAll()}">
					<option value="${diveInfoVO.pointSN}" ${diveInfoVO.pointSN == partyVO.partyLocation ? "selected" : ""}>${diveInfoVO.pointName}
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="partyMinSize">最低成團人數: </td>
			<td><input type="number" min="${partyMemberSvc.findByPartySNAndStatus(partyVO.partySN, '1').size()}" max="20" name="partyMinSize" value="${partyVO.partyMinSize}"></td>
		</tr>
		<tr>
			<td class="sizenow">目前已通過審核人數: </td>
			<td>${partyMemberSvc.findByPartySNAndStatus(partyVO.partySN, "1").size()}</td>
		</tr>
		<tr>
			<td class="status">揪團狀態: </td>
			<td>
				<select size="" name="status">
					<option value="0" ${partyVO.status == "0"? "selected": ""}>熱烈報名中
					<option value="1" ${partyVO.status == "1"? "selected": ""}>已額滿
					<option value="2" ${partyVO.status == "2"? "selected": ""}>已結束
					<option value="3" ${partyVO.status == "3"? "selected": ""}>已取消
					<option value="4" ${partyVO.status == "4"? "selected": ""}>已成團(仍可報名)
					<option value="5" ${partyVO.status == "5"? "selected": ""}>已下架
				</select>
			</td>
		</tr>
		<tr>
			<td class="partyDetail">詳細內容: (CKEditor還沒測) </td>
			<td><textarea name="partyDetail" maxlength=100>${partyVO.partyDetail}</textarea></td>
		</tr>
	</table>
	
	<button type="button" onclick="location.href='<%=request.getContextPath()%>/party/partyManage.jsp'" class="btn btn-primary btn-sm">回上頁(放棄修改)</button>
	<button type="submit" name="action" value="submitUpdate" class="btn btn-primary btn-sm">確認修改</button>
</form>

<%@ include file="../share/backend/Bfooter.file" %>
<%@ include file="../share/backend/Bjs.file" %>

<!-- 待更新js click browser goBack功能 -->


</body>
</html>