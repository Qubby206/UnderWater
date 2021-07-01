<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="wrapper">
		<div class="main">
			<main class="content">
				<div class="container-fluid p-0">
					<div class="row">
						<div class="col-md-3 col-xl-2">

							<div class="card">
								<div class="list-group list-group-flush" role="tablist">
									<a class="list-group-item list-group-item-action" href="personinfo.jsp" role="tab"> 會員資訊 </a> 
									<a class="list-group-item list-group-item-action active" href="personinfochange.jsp" role="tab"> 資訊變更</a> 
									<a class="list-group-item list-group-item-action" href="personchangepwd.jsp" role="tab"> 密碼變更</a> 
									<a class="list-group-item list-group-item-action" href="#" role="tab"> 待新增 </a> 
									<a class="list-group-item list-group-item-action" href="<%=request.getContextPath()%>/orderforgroup/GroupOrder.jsp" role="tab"> 套裝行程訂單 </a> 
									<a class="list-group-item list-group-item-action" href="<%=request.getContextPath()%>/party/partyIJoin.jsp" role="tab"> 揪團管理 </a> 
									<a class="list-group-item list-group-item-action" href="#" role="tab"> 待新增 </a> 
									<a class="list-group-item list-group-item-action" href="#" role="tab"> 待新增  </a>
								</div>
							</div>
						</div>

						<div class="col-md-9 col-xl-10">
							<div class="tab-content">
								<div class="tab-pane fade show active" id="account" role="tabpanel">
									<div class="card">