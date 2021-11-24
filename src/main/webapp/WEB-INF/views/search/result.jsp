<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>  -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>  -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> -->

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> 글자 작음  -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 모달필수였던것 -->
<title>검색 결과</title>
<style>

button {
	margin: 0 5px;
	padding: 5px 10px;
	border: 1px solid lightgray;
	border-radius: 15px;
	color: black;
}

strong {
	font-size: 1.5em;
}

.flex {
	display: flex;
	flex-flow: row wrap;
	justify-content: space-between;
}
.flex span {
	padding: 10px;
}
.left {
	margin-left: 30px;
}
 .costTab {
	display: inline-block;
 	position: sticky;
 	z-index: 1;
 	background-color:white;
 	top: 30px;
}
td {
	padding: 0 10px;
}
table {
	margin: 20px 0;
}
#page_control {
	text-align:center;
	margin:20px 0 0 0;
	margin-right: auto;
	margin-left: auto;

}
#page_control a {
	padding:2px 5px;
	text-decoration: none;
	color: #333;
	margin:0 5px;

} 

#page_control a:hover {
	font-weight: bold;
	color: #F90;
	text-decoration: underline;
}

.mapOverflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: pre;
	width: 200px;
}

.contentOverflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: pre;
	width: 50px;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}
.contentTable {
	width: 100%;
}
.contentTable:hover {
	background-color: #e2e2e2;
	cursor: pointer;
}
#resultApp {
	width:1300px;
	margin:0;
	margin-right: auto;
	margin-left: auto;
}
/* #location { */
/* 	color:white; */
/* } */

</style>
</head>
<body style="background-color: #f2f2f2;">
<div id=resultApp style="background-color: white;">
	<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-6" style="padding:20px;">
				<div>숙박 ${mPageDto.count}건 ㆍ ${checkIn}~${checkOut} ㆍ 게스트 ${cntOfPerson}명</div>
				<div><strong>${address}의 숙소</strong></div><br>
				<hr>
				<div>
					<span><strong>지역</strong></span>
				</div>
				<br>
				
				<div id="myCarousel">
					<!-- Indicators -->
					<div id="map" style="width:500px;height:400px;"></div>
				
                </div>
                
			</div>
					
			<div class="col-md-6" style="padding:20px;margin-top:180px;">
                <div id="mapimage" >
                	<img alt="#" src="#">
                </div>    
		  	</div>
				
					<!-- Left and right controls -->
					<a class="carousel-control-prev" href="#myCarousel" data-slide="prev" style="margin-left: 0px;">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#myCarousel" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<hr>
				<div>
					<c:choose>
						<c:when test="${ not empty hostList }"><%-- ${ pageDto.count gt 0 } --%>
							<c:forEach var="search" items="${ hostList }">
								<table class="contentTable" onclick="location.href='/content/info?num=${ search.num }&pageNum=${ pageNum }&address=${ address }&checkIn=${ checkIn }&checkOut=${ checkOut }&cntOfPerson=${ cntOfPerson }'">
									<tr>
										<td rowspan="6">
											<img src="/upload/${ search.imageVo.uploadpath }/${ search.imageVo.uuid }_${ search.imageVo.filename }" width="200" height="200">
										</td>
									</tr>
									
									<tr>
										<td>숙소 이름 : ${ search.title }</td>
									</tr>
									<tr>
										<td>장소 : ${ search.address1 }</td>
									</tr>
									
									<tr>
										<td>옵션 : 최대 인원 ${ search.countOfPerson }명ㆍ침실 ${ search.countOfBedroom }개ㆍ욕실 ${ search.countOfBathroom }개</td>
									</tr>
									<c:if test="${ search.score gt 0 }">
										<tr>
											<td>별점 : <span style="color: #ff385c"><i class="fas fa-star"></i></span>${ search.score }</td>
										</tr>
									</c:if>
									<tr>
										<td>요금 : 1박/<fmt:formatNumber value="${ search.cost }" pattern="#,###,###"/>원</td>
									</tr>	
								</table>
								<hr>
							</c:forEach>
							
						</c:when>		
						<c:otherwise>
							<tr>
								<td>게시판 글 없음</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="text-center">
					<c:if test="${ mPageDto.count gt 0 }">
						<c:if test="${ mPageDto.startPage gt mPageDto.pageBlock }">
							<a href="/search/result?pageNum=${ mPageDto.startPage - mPageDto.pageBlock }&address=${ address }&checkIn=${ checkIn }&checkOut=${ checkOut }&cntOfPerson=${ cntOfPerson }">[이전]</a>
						</c:if>
						
						<c:forEach var="i" begin="${ mPageDto.startPage }" end="${ mPageDto.endPage }" step="1">
		
							<c:choose>
							
								<c:when test="${ pageNum eq i}">
									<a href="/search/result?pageNum=${ i }&address=${ address }&checkIn=${ checkIn }&checkOut=${ checkOut }&cntOfPerson=${ cntOfPerson }"><b>[${ i }]</b></a>
								</c:when>
								
								<c:otherwise>
									<a href="/search/result?pageNum=${ i }&address=${ address }&checkIn=${ checkIn }&checkOut=${ checkOut }&cntOfPerson=${ cntOfPerson }">[${ i }]</a>
								</c:otherwise>
							
							</c:choose>
					
						</c:forEach>
						<c:if test="${ mPageDto.endPage lt mPageDto.pageCount }">
							<a href="/search/result?pageNum=${ mPageDto.startPage + mPageDto.pageBlock }&address=${ address }&checkIn=${ checkIn }&checkOut=${ checkOut }&cntOfPerson=${ cntOfPerson }">[다음]</a>
						</c:if>
					</c:if>
				</div>
				<div class="text-center">
					숙소 ${mPageDto.count}개중 ${ pageNum }-${ pageNum*5 }
				</div>
			</div>

			<div class="col-md-6 " style="padding:0; margin-top: 80px;">
				<div class="costTab" id="map" style="width: 100%; height: 830px;" ></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>


<!-- <script type="text/javascript" -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=카카오APP키&libraries=services"></script>

<script>

	var infowindow = new kakao.maps.InfoWindow({zIndex:1, removable:true});

	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
	
	var latitude = parseFloat('<c:out value ="${locationVo.latitude}"/>'); // jstl태그로 locationVo정보 불러오기
	var longitude = parseFloat('<c:out value ="${locationVo.longitude}"/>');
	
	
	var mapOptions = {
			center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			level: 10 // 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOptions);
	
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 지역 이름 리스트 배열에 저장
		var list = [];
		var listNum= [];
		var imageList = [];
		var titleList = [];
		var costList = [];
		<c:forEach var="search" items="${ hostList }">
			list.push("${search.address1}");
			listNum.push("${ search.num }");
			imageList.push('/upload/${ search.imageVo.uploadpath }/${ search.imageVo.uuid }_${ search.imageVo.filename }');
			titleList.push('${ search.title }');
			costList.push('${ search.cost }');
			console.log('num : ' + '${ search.num }');
		</c:forEach>
		console.log('list : ' + list);

		// 지역 좌표 리스트 배열에 저장
		var positions = [];

		// 마커 이미지의 이미지 주소
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

		// 마커 이미지의 이미지 크기
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 

	    var text = 'asdfasdf';
	    
		list.forEach(function (addr, index) {
			geocoder.addressSearch(addr, function(result, status) {
				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						map: map, // 마커를 표시할 지도
						position: coords, // 마커를 표시할 위치
						title : list[index], // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						image : markerImage // 마커 이미지
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindowCost = new kakao.maps.InfoWindow({
			            content: '<div style="width:100px; height:30px; text-align:center;padding:6px 0;">'+costList[index]+'</div>'
			        });
			        infowindowCost.open(map, marker);
					
					// 마커를 클릭하면 장소명이 인포윈도우에 표출
					kakao.maps.event.addListener(marker, 'click', function() {
						console.log('index : ' + listNum[index]);
				        infowindow.setContent("<a href='/content/info?num=" + listNum[index] + "&pageNum=${ pageNum }'><img src='"+imageList[index]+"' width='200' height='200'><br>" + 
				        					  "<div class='mapOverflow' style='padding:5px;font-size:12px;'>" + titleList[index] +"<br>"+list[index]+ "</div></a>");
				        infowindow.open(map, marker);
						console.log('coords : ' + coords);
				    });

					map.setCenter(coords);
				}
			});
		});


</script>
</body>
</html>
