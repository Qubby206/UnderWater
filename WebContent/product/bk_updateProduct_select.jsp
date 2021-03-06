<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
	<%@ include file="../share/backend/Bmeta.file" %>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
<title>修改商品</title>
</head>

<body>
<%@ include file="../share/backend/Bheader.file" %>
	<div class="container">
		<h3>查詢方式:</h3>
		
		<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>	
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</c:if>
		
	<%-- 	<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" /> --%>
		
		<ul>			
			<li><a href="<%=request.getContextPath()%>/product/bk_listAllProduct.jsp">所有商品</a></li><br>
			
			<li>
				<b>依商品編號查詢:</b>
				<form method="post" action="<%=request.getContextPath()%>/product/product.do">
					<b>請輸入編號:</b>
					<input type="text" name="productSN"> 
					<input type="hidden" name="action" value="bk_getOneProduct"> 
					<input type="submit" value="送出">
				</form>
			</li>
	
		</ul>
	</div>
	
<%@ include file="../share/backend/Bfooter.file" %>
<%@ include file="../share/backend/Bjs.file" %>
</body>
</html>