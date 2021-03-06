<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>예약정보-bookList</title>
<style>
.bookListApp {
	width: 1020px;
	display: block;
	margin: 0 auto;
	position: relative;
}

div {
	padding: 10px;
}

table, td, tr {
	border: solid 1px #d2d2d2;
}
th {
	text-align: center;
}
.verticality {
	display: inline-flex;
	flex-direction: column;
}

.horizontal {
	display: inline-flex;
	flex-direction: row;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}


</style>
</head>

<body style="background-color: #f2f2f2;">
    <div class="bookListApp" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div class="verticality">
	        <div class="horizontal">
	            <h1>예약정보</h1>
	        </div>
	        <div>
				<hr>
			</div>
	        <div class="verticality">
	            <div class="verticality">
	                 <h2>${ bookVo.hostVo.id }(호스트) 님의 숙소</h2>
	                 <div class="horizontal">
	                    <div class="verticality">
	                         <div>체크인</div>
	                         <div>${ bookVo.checkIn } 오후 2:00</div>
	                    </div>
	                    <div class="verticality">
	                        <div>체크아웃</div>
	                        <div>${ bookVo.checkOut } 오후 12:00</div>
	                    </div>
	                 </div>
	            </div>
				 <div>
					<hr>
				</div>
	            <div class="verticality">
	                <h2>결제정보</h2>
	                <div class="verticality">
	                    <table>
	                        <tr>
	                            <th>결제금액</th>
	                            <td><fmt:formatNumber value="${ bookVo.cost }" pattern="#,###,###"/>원</td>
	                        </tr>
	                        <tr>
	                            <th>결제수단</th>
	                            <td>카카오페이</td>
	                        </tr>
	                        <tr>
	                            <th>결제자아이디</th>
	                            <td>${ bookVo.id }</td>
	                        </tr>
	                        <tr>
	                            <th>결제시간</th>
	                            <td>${ bookVo.regDate }</td>
	                        </tr>
	                    </table>
	                </div>
	            </div>
				<div>
					<hr>
				</div>
	            <div class="verticality">
	                <h2>찾아가는 방법</h2>
	                <div class="verticality">
	                    <div>
	                        <div>주소 : ${ bookVo.hostVo.address1 } ${ bookVo.hostVo.address2 }</div>
	                    </div>
	                    <div>
	                    	<div id="map" style="width:900px;height:350px;"></div>
	                    </div>
	                </div>
	            </div>
	
	            <div>
					<hr>
				</div>
	            <div class="verticality">
	                <h2>숙소</h2>
	                <div class="verticality">
	                    <div>
	                        <a href="/content/info?num=${ bookVo.noNum }">숙소보기</a>
	                    </div>
	                </div>
	            </div>
	        </div>

			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
    </div>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=카카오APP키&libraries=services"></script>
    <script>
	    var mapContainer = document.getElementById('map'),
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667),
	        level: 3
	    };  
	
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		var geocoder = new kakao.maps.services.Geocoder();
	
		geocoder.addressSearch('${ bookVo.hostVo.address1 }', function(result, status) {
	
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
	
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리집</div>'
		        });
		        infowindow.open(map, marker);
	
		        map.setCenter(coords);
		    } 
		});  
    </script>
</body>
</html>
