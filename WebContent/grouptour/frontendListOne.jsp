<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.collections.model.*"%>
<%@ page import="com.grouptour.model.*"%>


<%  
	// DisplayOne的頁面會拿到 userID, groupTourSN
// 	request.setAttribute("userID", 2);	// 先寫死
	GroupTourVO groupTourVO = (GroupTourVO) request.getAttribute("groupTourVO"); //listAll給的(KEEP)
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Group Tour</title>
<link rel="stylesheet" href="../share/index.css">
<link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.min.css">
<style>
.main {
	width: 900px !important;
	height: 2000px;
}

.main-container {
	margin: 0 auto;
	width: 900px;
	/* 		display: flex; */
	background-color: snow;
	border-radius: 10px;
	box-shadow: 0px 0px 9px 0px rgba(0, 0, 0, 0.4);
	padding: 30px;
	opacity: .9;
}

.row{
	margin-bottom: 20px;


}
.top {
	height: 50px;
}

.picture {
	width: 550px;
	height: 310px;
	overflow: hidden;
}

.preview {
	width: 550px;
	height: 310px;
	/*圖片撐滿 */
	object-fit: cover;
	object-position: center;
}

.content1 {
	padding-top: 20px;
}

.price {
	display: inline-block;
	padding: 60px 35px 10px 0;
}

.heart {
	cursor: pointer;
	color: pink;
	position: relative;
	bottom: 180px;
	left: 191px;
	font-size: 45px;
}
.heart.-on {
	color: red;
	
}
.notice{
	padding: 20px;
	background-color: LightGoldenrodYellow;	
	border-radius: 10px;
}
.notice-content{
	font-size: 10px;
}

</style>
</head>
<body>
<jsp:include page="../share/navbar.jsp" flush="true" />

<div class="top"></div>
<div class="main-container">


<div class="row">	

<div class="picture col-xl-8 col-lg-7">
	<img class='preview' src="<%=request.getContextPath()%>/grouptour/GetImage.do?id=${groupTourVO.groupTourSN}">
</div>

<div class="picture col-xl-4 col-lg-5">


	<div class="content1">
	<h2>${groupTourVO.tourName}</h2>
	</div>
	
	<div class="content1">
		<i class="fas fa-map-marker-alt"></i>
		<jsp:useBean id="diveInfoSvc" scope="page" class="com.diveinfo.model.DiveInfoService"></jsp:useBean>
		${diveInfoSvc.getOneDiveInfo(groupTourVO.pointSN).pointName}
	</div>
	
	<div>
		<h2 class="price">$ ${groupTourVO.price}</h2>
		人數限制 :<span class="attendNumber">${groupTourVO.attendNumber}</span> / <span class="limitNumder">${groupTourVO.limitNumder}</span>
	</div>

	<FORM NAME="orderForm" METHOD="post" ACTION="<%=request.getContextPath()%>/orderforgroup/orderforgroup.do" >
		<input type="hidden" class="userID" name="userID" value="${userID}">
		<input type="hidden" class="groupTourSN" name="groupTourSN" value="${groupTourVO.groupTourSN}">
		<input type="hidden" name="action" value="getOne_ForOrder">
		<input class="nonattend_btn btn btn-primary btn-block" type="submit" value="我要報名" >
		<input class="attend_btn btn btn-secondary btn-block" type="submit" value="已報名" disabled style="display:none">
	</FORM>
	
	<div class="collection"><!-- 收藏資料(ajax) -->
		<span class="heart btn" ><i class="fas fa-heart"></i></span>
	</div>
</div>

<!-- row end --></div>
<hr>
<div class="row">	
	<div class="col-xl-6 col-lg-6">行程時間  :  ${groupTourVO.startTime} - ${groupTourVO.endTime}</div>
	<div class="col-xl-6 col-lg-6">報名時間  :  ${groupTourVO.regTime} - ${groupTourVO.closeTime}</div>
	<div class="col-xl-6 col-lg-6">證照資格  :  
	        <c:if test="${groupTourVO.certificationLimit==0}">不限</c:if>
	        <c:if test="${groupTourVO.certificationLimit==1}">PADI OW / SSI OW</c:if>
	        <c:if test="${groupTourVO.certificationLimit==2}">PADI AOW / SSI AOW</c:if>
	</div>
<!-- row end --></div>
<hr>
<div class="row">
<div class="col-xl-12 col-lg-12">
		<p>潛點評價</p><jsp:useBean id="locationrateSvc" scope="page" class="com.locationrate.model.LocationrateService"></jsp:useBean>
		<div>
		<p>${locationrateSvc.getByPointSN(groupTourVO.pointSN)}</p>
		</div>
</div>	
<!-- row end --></div>	 
<hr>
<div class="row">
	<div class="col-xl-12 col-lg-12">
		<h3>行程內容</h3>
		<div>
		<p>${groupTourVO.content}</p>
		</div>
	</div>	
	
	
	
	<div class="col-xl-12 col-lg-12">	
	<div class="notice">
	

				<div class="notice-title">
					<h4>注意事項</h4>
					<hr>
					<div class="notice-content">
						<ul>
							<li>
								<p style="color=red;">因應 嚴重特殊傳染性肺炎（COVID-19) 肆虐配合中央流行疫情指揮中心政策三級警戒到7/12，
								為保障旅客健康及安全，宣布取消至7月12日出發之團體行程，旅客可以選擇退費、改期。
								後續將視疫情發展狀況，配合中央流行疫情指揮中心政策滾動式調整因應，以旅客最大權益為優先考量。</p>
							</li>
							<li>
								<p>若遇颱風、暴風雪等天候不佳的情況，將於出發前 3 天（當地時間 20:00
									）決定此團是否取消出發，之後將隨時以電子郵件形式通知。</p>
							</li>
							<li><p>不建議患有下列疾病或其他不宜受到過度刺激的旅客參加此項目</p>
								<p>高血壓、心臟病、懼高症、氣喘、癲癇、懷孕婦女</p></li>
							<li>
								<p>潛水後需要超過24到48小時才可以搭乘飛機，請特別注意。</p>
							</li>
							<li>
								<p>體驗結束後之照片檔案將會透過雲端連結提供。</p>
							</li>
							<li>
								<p>請於預訂日期之集合時間準時報到，逾時 30 分鐘即視同放棄體驗，並請提早10分鐘抵達以免耽誤行程時間。</p>
							</li>
							<li>
								<p>請自備泳衣、換洗衣物、盥洗用品、毛巾、容器及環保餐具。</p>
							</li>
							<li>
								<p>每次的潛點位置並非固定，教練會依當日天氣海象、參與者之程度決定路線。</p>
							</li>
						</ul>
					</div>
				</div>

			</div>
		
		</div>
<!-- row end --></div>		



<div class="row">

		
		<!-- 有空改寫 -->
		<div><!-- 抓收藏、報名用(有空把他寫在DAO好了 好醜)   -->
			<jsp:useBean id="colSvc" scope="page" class="com.collections.model.CollectionsService"></jsp:useBean>
			<span class="favorite">${(userID == null)?"":colSvc.getCollectionsByUserid(userID)}</span>
			<jsp:useBean id="orderSvc" scope="page" class="com.orderforgroup.model.OrderForGroupService"></jsp:useBean>
			<span class="order_list">${(userID == null)?"":orderSvc.checkRepeatOrder(userID)}</span>
		</div>
<!-- row end --></div>		
		
<!-- container end --></div>

<!-- Msg -->   
<c:if test="${not empty errMsg}">
	<script>alert("${errMsg}");</script>
</c:if>

<jsp:include page="../share/footer.jsp" flush="true" />

<script src="https://kit.fontawesome.com/d3e24e4d81.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

function init() {
	
	// 抓取收藏
	var favorite = $(".favorite").text();
	var groupTourSN = $(".groupTourSN").text();
	if(favorite.indexOf(groupTourSN) > 0) {
		$(".heart").addClass("-on");
	}
	
	// 抓取訂單
	var orderList = $(".order_list").text();
	if(orderList.indexOf(groupTourSN) > 0) {
		$(".attend_btn").show();
		$(".nonattend_btn").hide();
	}
	
	// 抓取是否已額滿	>>上面三駝都可以寫在 c:if
	var attendNumber = $(".attendNumber").text();
	var limitNumder = $(".limitNumder").text();
	if(attendNumber>=limitNumder) {
		$(".attend_btn").val("已額滿");
		$(".attend_btn").show();
		$(".nonattend_btn").hide();
	}
	
}

$(function () {
	
	init();
	
	// 更新收藏
    $(".heart").on("click", function(){
        // confirm("ADD COLLECTIONS?");
        var that = this;
        var userID = $(".userID").val();		// 先寫死
        var groupTourSN = $(".groupTourSN").text();
        console.log(userID, "+",groupTourSN);
    
        $.ajax({
          		url: "<%=request.getContextPath()%>/collections/collections.do?action=favorite&userID=" + userID + "&groupTourSN=" + groupTourSN,
<%--            url: "<%=request.getContextPath()%>/collections/collections.do", --%>
                type: "GET",
                dataType: "text",
//                 data: {
//                 	"action": "favorite",
//                 	"userID": userID,
//                 	"groupTourSN": groupTourSN,
//                 },
                success: function(data){
                    console.log(data);
                    if(data == "delete") {
                    	alert("移除收藏");
                    	$(that).removeClass("-on");
                    }else if(data == "add"){
                    	alert("加入收藏");
                    	$(that).addClass("-on");
                    }else if(data == "fail"){	// 
                    	alert("請確認是否已登入");
                    }
                }
        });
    })
    
    
})
</script>
</body>
</html>