<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="com.party.model.*"  %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
		PartyService partySvc = new PartyService();
		Integer partyHost = 1;
		List<PartyVO> listAll = partySvc.findByPartyHost(partyHost);
		pageContext.setAttribute("listAll", listAll);
%>
<!-- �ݰʺA�a�J�|���s�� -->

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>�ک��|�쪺����(�ݧ�g�ʺA�a�J�|���s��)</title>

<style>
.partyShort {
	background-color: lightgrey;
	width: 500px;
	margin: 10px auto;
}
</style>
</head>
<body>

<h2>�ک��|�쪺����(�ݧ�g�ʺA�a�J�|���s��)</h2>

<c:if test="${empty listAll}">
	<div style="color:red">�z�èS���|����󴪹ά��ʳ�!</div>
</c:if>

<c:forEach var="partyVO" items="${listAll}">
	<div class="partyShort">
		<form method="post" action="<%=request.getContextPath()%>/party/party.do">
			<table>
				<tr>
					<td>���νs��: </td>
					<td>${partyVO.partySN}</td>
				</tr>
				<tr>
					<td>�D���H(����i�R��): </td>
					<td>${partyVO.partyHost}</td>
				</tr>
				<tr>
					<td>���ΥD��: </td>
					<td>${partyVO.partyTitle}</td>
				</tr>
				<tr>
					<td>���Ϊ��A: </td>
					<c:if test="${partyVO.status == '0'}">
						<td class="status">���P���W��</td>
					</c:if>
					<c:if test="${partyVO.status == '1'}">
						<td class="status">�w�B��</td>
					</c:if>
					<c:if test="${partyVO.status == '2'}">
						<td class="status">�w����</td>
					</c:if>
					<c:if test="${partyVO.status == '3'}">
						<td class="status">�w����</td>
					</c:if>
					<c:if test="${partyVO.status == '4'}">
						<td class="status">�w����(���i���W)</td>
					</c:if>
					<c:if test="${partyVO.status == '5'}">
						<td class="status">�w�U�[</td>
					</c:if>
				</tr>
				<tr>
					<td>�ݼf�֤H��(�ݧ���): </td>
					<td>partyMemberSvc.xxxxxx</td>
				</tr>
			</table>
			<input type="hidden" name="partySN" value="${partyVO.partySN}">
			<button type="submit" name="action" value="partyIHostDetail">�d�ݸԱ� / �ק鷺�e / �f�ֳ��W���</button>
		</form>
	</div>
</c:forEach>

</body>
</html>