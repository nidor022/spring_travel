<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AIRBNB</title>

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->

<style>
#wrap {
	width:1040px;
	margin:0;
	margin-right: auto;
	margin-left: auto;
	min-height:780px;
}
.overflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: pre;
	width: 300px;
	height: 220px;
}
.contentTypes {
	display: grid;
	grid-template-columns: 500px 500px;
	grid-template-rows: auto auto;
}
.searchBox {
	display:grid;
	grid-template-columns: 200px 200px 200px 400px;
	grid-template-rows: 100px;
}
.mainComment {	
	font-size:72px;
	text-transform: inherit;
	max-width: 800px;
	font-weight: 600;
	line-height: 1.22;
	background-color: rgba(255, 0, 0, 0);
}
div {
	padding: 5px;
/* 	border: solid red 1px; */
}
.reviewComment:hover {
	background-color: #e2e2e2;
	cursor: pointer;
}
.contentInfo:hover {
	background-color: #e2e2e2;
	cursor: pointer;
}
.reviewBox {
	display: grid;
	grid-template-columns: 33% 33% 33%;
	grid-template-rows: 300px;
}
.float_right {
	float: right;
}
.search {
	padding:10px;
}

.drawOutLine {
	border: solid 1px #d2d2d2;
}

#banner {
	height: 600px;
	padding: 30px 0 30px 0;
	display: flex;
    justify-content: left;
    align-items: top;
	position: relative;
	background: url(/images/banner.jpg)no-repeat;
	background-size: cover;
	background-position: center;
}
pre{
	padding:10px;
    overflow: auto;
    white-space: pre-wrap; /* pre tag내에 word wrap */
    background: #f2f2f2;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
<div id="wrap" style="background-color: white;">

	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="clear"></div>
	
	<section id="banner">
		<div class="mainComment">
			Explore The Beautiful World
		</div>
		
	</section>
	
	<div class="clear"></div>

	<section id="d">
		<div class="abc">
			지금 바로 출발하세요!
			<br>
		</div>
	</section>
	
	<form action="/search/result" method="get">
		<div class="searchBox drawOutLine">
				<div class="search">
					<label>체크인</label>
					<input type="text" class="form-control input-sm" id="checkin" name="checkIn" readonly>
				</div>

				<div class="search">
					<label>체크아웃</label>
					<input type="text" class="form-control" id="checkout" name="checkOut" readonly>
				</div>

				<div class="search">
					<label>인원</label>
					<input type="number" class="form-control" name="cntOfPerson" min=1 value="1" required>
				</div>
				
				<div class="search" >
					<label>검색</label>
					<div class="row" style="padding: 0px; margin-left: 5px;">
						<div class="col-xs-4" style="padding: 0px;">
							<select name="address" class="form-control" style="width: 300px;" id="location" required>
								<option value="" disabled selected>지역을 선택해주세요</option>
							</select>
						</div>
						<div class="col-xs-2" style="padding: 0px; margin-left: 5px;">
							<input class="btn btn-dark" type="submit" value="검색" class="searchBtn">
						</div>
					</div>


				</div>
		</div>
	</form>	
	<hr>
	<section id="b">
		<div>
			<h2>최신 숙박지</h2>
		</div>
		
		<div class="contentTypes drawOutLine">
			<c:forEach var="host" items="${ hostList }">
				<c:if test="${ host.classification eq '부티크 호텔' }">
					<div class="contentInfo drawOutLine" onclick="location.href='/content/info?num=${ host.num }'">
						<img src="/upload/${ host.imageVo.uploadpath }/${ host.imageVo.uuid }_${ host.imageVo.filename }" width="480" height="400">
						<div class="txt3">
							<h3>호텔</h3>
							<div class="txt4">
								<p>${ host.title }</p>
								<p><pre>${ host.hostComment }</pre></p>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${ host.classification eq '주택' }">
					<div class="contentInfo drawOutLine" onclick="location.href='/content/info?num=${ host.num }'">
						<img src="/upload/${ host.imageVo.uploadpath }/${ host.imageVo.uuid }_${ host.imageVo.filename }" width="480" height="400">
						<div class="txt3">
							<h3>주택</h3>
							<div class="txt4">
								<p>${ host.title }</p>
								<p><pre>${ host.hostComment }</pre></p>
							</div>
						</div>
					</div>
				</c:if>
				
				<c:if test="${ host.classification eq '아파트' }">
					<div class="contentInfo drawOutLine" onclick="location.href='/content/info?num=${ host.num }'">
						<img src="/upload/${ host.imageVo.uploadpath }/${ host.imageVo.uuid }_${ host.imageVo.filename }" width="480" height="400">
						<div class="txt3">
							<h3>아파트</h3>
							<div class="txt4">
								<p>${ host.title }</p>
								<p><pre>${ host.hostComment }</pre></p>
							</div>
						</div>
					</div>
				</c:if>
				
				<c:if test="${ host.classification eq '독특한 숙소' }">
					<div class="contentInfo drawOutLine" onclick="location.href='/content/info?num=${ host.num }'">
						<img src="/upload/${ host.imageVo.uploadpath }/${ host.imageVo.uuid }_${ host.imageVo.filename }" width="480" height="400">
						<div class="txt3">
							<h3>독특한 숙소</h3>
							<div class="txt4">
								<p>${ host.title }</p>
								<p><pre>${ host.hostComment }</pre></p>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</section>
	<hr>
	<section id="c">
		<div>
			<h2>리뷰</h2>
		</div>
		
		<div class="reviewBox drawOutLine">
			<c:choose>
				<c:when test="${ reviewList ne null }">
					<c:set var="loop_flag" value="false" />
					<c:forEach var="review" items="${ reviewList }" varStatus="status">
						<div class="drawOutLine">
							<span>${ review.id }</span> ㆍ
							<span style="color: #ff385c"><i class="fas fa-star"></i></span>
							<span>${ review.score }</span>
							<span class="float_right"><fmt:formatDate value="${ review.regDate }" pattern="yyyy-MM-dd" /></span>
							<div class="overflow reviewComment" onclick="location.href = '/content/info?num=${ review.noNum }'">
								<pre>${ review.comment }</pre>
							</div>
						</div>
						<c:if test="${status.index eq 2 }">
							<c:set var="loop_flag" value="true" />
						</c:if>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					등록된 후기가 없습니다.
				</c:otherwise>
			</c:choose>
		</div>
		
	</section>
	
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
</div>

<script>
	let strLocationList = '${ locationList }';
	let str = strLocationList.substring(1, strLocationList.length-1);
	str = str.replace(/ /g,"")
	let locationList = str.split(',');

	for (var key in locationList) { 
		let option = $('<option value="' +locationList[key] + '">' + locationList[key] + '</option>');
		$('#location').append(option);
	}

	var rangeDate = 31; // set limit day
	var setSdate, setEdate;
	$("#checkin").datepicker({
		dateFormat : 'yy-mm-dd',
		minDate : 0,
		onSelect : function(selectDate) {
			var stxt = selectDate.split("-");
			stxt[1] = stxt[1] - 1;
			var sdate = new Date(stxt[0], stxt[1], stxt[2]);
			var edate = new Date(stxt[0], stxt[1], stxt[2]);
			edate.setDate(sdate.getDate() + rangeDate);

			$('#checkout').datepicker('option', {
				minDate : selectDate,
				beforeShow : function() {
					$("#checkout").datepicker("option", "maxDate", edate);
					setSdate = selectDate;
					console.log(setSdate)
				}
			});
			//checkout 설정
		}
	//checkin 선택되었을 때
	});

	$("#checkout").datepicker({
		dateFormat : 'yy-mm-dd',
		onSelect : function(selectDate) {
			setEdate = selectDate;
			console.log(setEdate)
		}
	});
	$('.searchBtn').on('click', function(e) {
		if ($('input#checkin').val() == '') {
			alert('시작일을 선택해주세요.');
			$('input#checkin').focus();
			return false;
		} else if ($('input#checkout').val() == '') {
			alert('종료일을 선택해주세요.');
			$('input#checkout').focus();
			return false;
		}
	});
	//조회 버튼 클릭
</script>

</body>
</html>


