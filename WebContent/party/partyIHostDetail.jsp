<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.partymember.model.*" %>
<jsp:useBean id="diveInfoSvc" class="com.diveinfo.model.DiveInfoService" />
<jsp:useBean id="partyMemberSvc" class="com.partymember.model.PartyMemberService" />
<jsp:useBean id="memberSvc" class="com.member.model.MemberService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>���|�쪺���� �ק鷺�e�f�ֳ��W���</title>
</head>
<body>

<h2>���|�쪺����: ${partyVO.partySN}</h2>
<h2>�ק鷺�e / �f�ֳ��W���</h2>

<form method="post" action="<%=request.getContextPath()%>/party/party.do">
	<table>
		<tr>
			<td class="partySN">���νs���G </td>
			<td><input type="text" name="partySN" value="${partyVO.partySN}" readonly></td>
		</tr>
		<tr>
			<td class="partyHost">�D���H�G </td>
			<td><input type="text" name="partyHost" value="${partyVO.partyHost}" readonly></td>
		</tr>
		<tr>
			<td class="partyTitle">���ΥD��: </td>
			<td><input type="text" name="partyTitle" value="${partyVO.partyTitle}"></td>
		</tr>
		<tr>
			<td class="date">���ʤ��: </td>
			<td>
				<input type="date" name="startDate" value="${partyVO.startDate}"> ��  <input type="date" name="endDate" value="${partyVO.endDate}">
			</td>
		</tr>
		<tr>
			<td class="regDate">���W�}����: </td>
			<td><input type="date" name="regDate" value="${partyVO.regDate}"></td>
		</tr>
		<tr>
			<td class="closeDate">���W�I����: </td>
			<td><input type="date" name="closeDate" value="${partyVO.closeDate}"></td>
		</tr>
		<tr>
			<td class="partyLocation">���μ��I: </td>
			<td>
				<select size="" name="partyLocation">
				<c:forEach var="diveInfoVO" items="${diveInfoSvc.getAll()}">
					<option value="${diveInfoVO.pointSN}" ${diveInfoVO.pointSN == partyVO.partyLocation? "selected" : ""}>${diveInfoVO.pointName}
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="partyMinSize">�̧C���ΤH��(�ݭק�): </td>
			<td><input type="number" min="${partyMemberSvc.findByPartySN(partyVO.partySN).size()}" max="20" name="partyMinSize" value="${partyVO.partyMinSize}"></td>
		</tr>
		<tr>
			<td class="sizenow">�ثe�w�q�L�f�֤H��(�ݭק�): </td>
			<td>${partyMemberSvc.findByPartySN(partyVO.partySN).size()}</td>
		</tr>
		<tr>
			<td class="status">���Ϊ��A: </td>
			<c:if test="${partyVO.status == 0}">
				<td>
					<select size="" name="status">
						<option value="0" selected>���P���W��
						<option value="2">����
						<option value="3">����
					</select>
				</td>
			</c:if>
			<c:if test="${partyVO.status == 1}">
				<td>
					<select size="" name="status">
						<option value="1" selected>�w�B��
						<option value="4">�w����(���i���W)
					</select>
				</td>
			</c:if>
			<c:if test="${partyVO.status == 2}">
				<td>
					<select size="" name="status">
						<option value="2" selected>�w����
					</select>
				</td>
			</c:if>
			<c:if test="${partyVO.status == 3}">
				<td>
					<select size="" name="status">
						<option value="3" selected>�w����
					</select>
				</td>
			</c:if>
			<c:if test="${partyVO.status == 4}">
				<td>
					<select size="" name="status">
						<option value="1" ${partyVO.status == "1"? "selected": ""}>�B��
						<option value="3" ${partyVO.status == "3"? "selected": ""}>����
						<option value="4" selected>�w����(���i���W)
					</select>
				</td>
			</c:if>
			<c:if test="${partyVO.status == 5}">
				<td>
					<select size="" name="status">
						<option value="5" selected>�����Τw�Q�U�[
					</select>
				</td>
			</c:if>
		</tr>
		<tr>
			<td class="partyDetail">�ԲӤ��e: (CKEditor�٨S��) </td>
			<td><textarea name="partyDetail" maxlength=100>${partyVO.partyDetail}</textarea></td>
		</tr>
	</table>
	
	<button type="submit" name="action" value="submitUpdate">�T�{�ק�</button>
	<button type="submit" name="action" value="goBackToPartyIHost">��^�e��(�ݰ�)</button>
<!-- �ݧ�sgoBack�\�� -->
</form>

<h2>���W���p</h2>
<c:if test="${empty partyMembers}">
	<div style="color:red">�ثe�|�L�|�����W��!</div>
</c:if>

<c:if test="${not empty partyMembers}">
	<table>
		<tr>
			<td>���W�Ǹ�</td>
			<td>���W�|��</td>
			<td>�ʧO</td>
			<td>E-mail</td>
			<td>���</td>
			<td>�X�ͦ~���</td>
			<td>�����Ҧr��</td>
			<td>�̰��ҷ�</td>
			<td>�ҷӹϤ�</td>
			<td>���W�ɶ�(�ݭ�)</td>
			<td>��L�Ƶ�</td>
			<td>���W���A</td>
			<td>�T�{�ᤣ�i�ק�</td>
		</tr>
	<c:forEach var="partyMember" items="${partyMembers}">
		<form method="post" action="<%=request.getContextPath()%>/party/party.do">
			<tr>
				<td>
					${partyMember.partyMemberSN}
					<input type="hidden" name="partyMemberSN" value="${partyMember.partyMemberSN}">
					<input type="hidden" name="partySN" value="${partyVO.partySN}">
				</td>
				<td>${memberSvc.getone(partyMember.partyMember).userName}</td>
				<td>${partyMember.gender == 0? "�k" : "�k"}</td>
				<td>${partyMember.email}</td>
				<td>${partyMember.phone}</td>
				<td>${partyMember.birthDate}</td>
				<td>${partyMember.personID}</td>
				<c:if test="${partyMember.certification == 'A1'}">
					<td>PADI OW</td>
				</c:if>
				<c:if test="${partyMember.certification == 'A2'}">
					<td>PADI AOW</td>
				</c:if>
				<c:if test="${partyMember.certification == 'B1'}">
					<td>SSI OW</td>
				</c:if>
				<c:if test="${partyMember.certification == 'B2'}">
					<td>SSI AOW</td>
				</c:if>
				<c:if test="${partyMember.certification == null}">
					<td>�L</td>
				</c:if>
				<td><button>(�ݰ�)</button></td>
				<td>${partyMember.appliedTime}</td>
				<td>${partyMember.comment}</td>
				<c:if test="${partyMember.status == '0'}">
					<td>
						<select size="" name="status">
								<option value="0" selected>�ݼf��
								<option value="1">�f�ֳq�L
								<option value="2">�f�֤��q�L
						</select>
					</td>
					<td><button type="submit" name="action" value="updatePartyMemberStatus">�T�{</button></td>
				</c:if>
				<c:if test="${partyMember.status == '1'}">
					<td>�f�ֳq�L</td>
					<td>
						<button disabled>�w�T�{</button>
					</td>
				</c:if>
				<c:if test="${partyMember.status == '2'}">
					<td>�f�֤��q�L</td>
					<td>
						<button disabled>�w�T�{</button>
					</td>
				</c:if>
			</tr>
		</form>
	</c:forEach>
	</table>
</c:if>

</body>
</html>