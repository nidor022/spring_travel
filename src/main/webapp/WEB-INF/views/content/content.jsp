<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물</title>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
<style>
.app {
	width: 1050px;
	display: block;
	margin: 0 auto;
	position: relative;
}

div {
	padding: 10px;
}

span {
/* 	border: solid green 1px; */
}

.float_right {
	float: right;
}

.containerImages {
	display: grid;
	grid-template-columns: 500px 250px 250px;
	grid-template-rows: 250px 250px;
}

.item:nth-child(1) {
	grid-colum: 1/3;
	grid-row: 1/3;
}

.dateNperson {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-template-rows: 1fr 1fr;
}
.dateNpersonItem:nth-child(3) {
/* 	grid-colum: 1/3; */
/* 	grid-row: 2/3; */
	grid-column: 1 / span 2;
	grid-row: 2 / span 1;
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

.notice {
	width: 297px;
}

.reviewWidth {
	width: 444px;
}

table, td, tr {
	border: solid 1px #d2d2d2;
}

.costTab {
	display: inline-block;
 	position: sticky;
 	z-index: 1;
 	background-color:white;
 	top: 100px;
}
.alignCenter {
	text-align: center;
}
.checkDates {
	width: 100px;
}

.overflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: pre;
	width: 420px;
	height: 150px;
}

.inputOutLine {
	border:none;
	border-right:0px;
	border-top:0px;
	boder-left:0px;
	boder-bottom:0px;
	width: 30px;
	text-align: center;
}
#checkInDate {
	z-index: 2;
}
#checkInDate {
	z-index: 2;
}

pre{
    overflow: auto;
    white-space: pre-wrap; /* pre tag내에 word wrap */
}

.drawOutLine {
	border: solid 1px #d2d2d2;
}
</style>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"> -->
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
</head>
<body style="background-color: #f2f2f2;">
	<div class="app drawOutLine" id="app" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<c:if test="${ pageVo.pageNum ne 0 }">
			<div>
				<a href="/search/result?pageNum=${ pageVo.pageNum }&address=${ pageVo.address }&checkIn=${ pageVo.checkIn }&checkOut=${ pageVo.checkOut }&cntOfPerson=${ pageVo.cntOfPerson }">
					<span style="color: #d2d2d2;">
						<i class="fas fa-angle-left fa-lg"></i>
					</span>
				</a>
			</div>
		</c:if>
		<div class="drawOutLine">${ hostVo.title }</div>
		<div>
			<c:choose>
				<c:when test="${ count eq 0 }">
					ㆍ<span id="address"></span>
				</c:when>
				<c:otherwise>
					<span style="color: #ff385c"><i class="fas fa-star"></i></span><span>${ score }(${ count })</span>ㆍ<span id="address"></span>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${ id eq hostVo.id || id eq 'admin'}">
				<button style="margin-left: 10px;" class="float_right btn btn-dark" type="button" v-on:click="contentDelete">삭제</button>
				<button class="float_right btn btn-dark" type="button" v-on:click="contentModify">수정</button>
			</c:if>
			
			<c:if test="${ not empty id && id ne 'admin' && id ne hostVo.id }">
				<button class="float_right btn btn-dark" type="button" v-on:click="contentSave">저장</button>
			</c:if>
			
		</div>
		<div class="containerImages">
			<c:choose>
				<c:when test="${ not empty imageList }">
					<c:forEach var="image" items="${ imageList }" varStatus="status">
						<div class="item">
							<c:choose>
								<c:when test="${ status.index eq 0 }">
									<img src="/upload/${ image.uploadpath }/${ image.uuid }_${ image.filename }" width="480" height="480">
								</c:when>
								<c:otherwise>
									<img src="/upload/${ image.uploadpath }/${ image.uuid }_${ image.filename }" width="230" height="230">
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>

		<div class="horizontal drawOutLine">
			<div class="verticality" style="width: 600px;">
				<div class="horizontal text-center">
					<div class="verticality drawOutLine">
						<div>${ hostVo.id }님이 호스팅하는 ${ hostVo.houseType }</div>
						<div>최대 인원 ${ hostVo.countOfPerson }명ㆍ침실 ${ hostVo.countOfBedroom }개ㆍ욕실 ${ hostVo.countOfBathroom }개</div>
					</div>
					<div class="float_right drawOutLine">
						<c:choose>
							<c:when test="${ not empty userVo.filename }">
								<img src="/upload/${ userVo.uploadpath }/${ userVo.uuid }_${ userVo.filename }" width="150" height="150">
							</c:when>
							<c:otherwise>
								<span><i class="fas fa-user fa-5x"></i></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<hr>
				<div>
					<table>
						<tr>
							<td class="alignCenter"><i class="fas fa-home fa-2x"></i></td>
							<td>
								<div>${ hostVo.stayType }</div>
								<div id="stayExplan"></div>
							</td>
						</tr>
						<tr>
							<td class="alignCenter"><i class="fas fa-hand-sparkles fa-2x"></i></td>
							<td>
								<div>청결 강화</div>
								<div>에어비앤비의 강화된 5단계 청소 절차를 준수하겠다고 동의한 호스트입니다.</div>
							</td>
						</tr>
						<tr>
							<td class="alignCenter"><i class="fas fa-tasks  fa-2x"></i></td>
							<td>
								<div>셀프 체크인</div>
								<div>키패드를 이용해 체크인하세요.</div>
							</td>
						</tr>
						<tr>
							<td class="alignCenter"><i class="fas fa-money-bill-wave fa-2x"></i></td>
							<td>
								<div>체크인 5일 전까지 수수료 없이 취소 가능</div>
								<div>그 이후로는 체크인 전에 취소하면 첫 1박 요금과 서비스 수수료를 제외하고 50%가 환불됩니다.</div>
							</td>
						</tr>
						<tr>
							<td class="alignCenter"><i class="fas fa-info-circle fa-2x"></i></td>
							<td>
								<div>숙소 이용규칙</div>
								<div>반려동물 동반, 파티, 흡연이 금지되는 숙소입니다.</div>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<hr>
				</div>
				<div>
					${ hostVo.hostComment }
				</div>
				<div>
					<hr>
				</div>
				<div>
					<h3>침대/침구 유형</h3>
					<div>
						침실 ${ hostVo.countOfBedroom}개
						<c:if test="${ hostVo.countOfBed gt 0 }">
							ㆍ침대 ${ hostVo.countOfBed }개
						</c:if>
						<c:if test="${ hostVo.countOfSofeBed gt 0 }">
							ㆍ소파배드 ${ hostVo.countOfSofeBed }개
						</c:if>
						<c:if test="${ hostVo.countOfSofe gt 0 }">
							ㆍ소파 ${ hostVo.countOfSofe }개
						</c:if>
						<c:if test="${ hostVo.countOfBlanket gt 0 }">
							ㆍ요/이불 ${ hostVo.countOfBlanket }개
						</c:if>
					</div>
				</div>
				<div>
					<hr>
				</div>
				<div>
					<h3>편의시설</h3>
					<c:choose>
						<c:when test="${ hostVo.amenities ne '' }">
							<c:forEach var="amenitie" items="${ hostVo.amenities }">
								<div>${ amenitie }</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div>편의시설이 없음</div>
						</c:otherwise>
					</c:choose>
					
				</div>
				<div>
					<hr>
				</div>
				<div>
					<h3>안전시설</h3>
					<c:choose>
						<c:when test="${ hostVo.safety ne '' }">
							<c:forEach var="safety" items="${ hostVo.safety }">
								<div>${ safety }</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div>안전시설이 없음</div>
						</c:otherwise>
					</c:choose>
					
				</div>
				<div>
					<hr>
				</div>
				<div>
					<h3>이용 가능한 시설</h3>
					
					<c:choose>
						<c:when test="${ hostVo.usefull ne '' }">
							<c:forEach var="usefull" items="${ hostVo.usefull }">
								<div>${ usefull }</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div>이용 가능한 시설이 없음</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div>
					<hr>
				</div>
			</div>
			<div>
				<div class="costTab drawOutLine" style="width: 332px;">
					<div>
						<span>{{ stayCostPerOneDay | comma }}원/1박</span>
						<span class="float_right">
							<c:if test="${ count gt 0 }">
								<span style="color: #ff385c"><i class="fas fa-star"></i></span><span>${ score }(${ count })</span>
							</c:if>
						</span>
					</div>
					<div class="dateNperson">
						<div class="dateNpersonItem"> 
							체크인
    						<input class="checkDates" type="text" id="checkInDate" readonly>
    					</div>
						<div class="dateNpersonItem">
							체크아웃
							<input class="checkDates" type="text" id="checkOutDate" readonly>
						</div>
						<div class="dateNpersonItem text-center">
							게스트 인원 
							<button type="button" class="btn btn-dark" v-on:click="cntOfGuestDown">-</button>
							<input class="inputOutLine" name="cntOfGuest" v-model="cntOfGuest" readonly>
							<button type="button" class="btn btn-dark" v-on:click="cntOfGuestUp">+</button>
						</div>
					</div>
					
					<div v-if="isPaymentShow">
						<hr>
						<div class="text-center">
							<button type="button" class="btn btn-dark" v-on:click="booking">예약하기</button>
						</div>
						<div>예약 확정 전에는 요금이 청구되지 않습니다.</div>
						<hr>
						<div>
							<table>
								<tr>
									<td id="period">
										{{ stayCostPerOneDay | comma }}원/{{ gapPeriod }}박
									</td>
									<td id="stayCost">
										{{ setPaymentCost | comma }}원
									</td>							
								</tr>
								
								<tr>
									<td>청소비</td>
									<td>{{ cleanerCost | comma }}원</td>							
								</tr>
								
								<tr>
									<td>서비스 수수료</td>
									<td>{{ setServiceCost | comma }}원</td>							
								</tr>
								
								<tr>
									<td>숙박세와 수수료</td>
									<td>{{ setTex | comma }}원</td>							
								</tr>
							</table>
						</div>
						<hr>
						<div>
						총금액 {{ setTotalCost | comma  }}원
						</div>
					</div>
				</div>
			</div>
		</div>
		<div>
		<hr>
			<div style="margin-bottom: 70px;">
				<h3>후기</h3>
				<div>
					<c:choose>
						<c:when test="${ not empty reviewListFour  }">
							<div><span style="color: #ff385c"><i class="fas fa-star"></i></span><span>${ score }(${ count })</span></div>
							<div class="horizontal drawOutLine" style="width: 932px; margin-bottom: 30px;">
								<div class="reviewWidth drawOutLine">
									<c:forEach var="review" varStatus="status" items="${ reviewListFour }">
										<c:if test="${ status.index lt 2 }">
											<span>${ review.id }</span><span class="float_right"><fmt:formatDate value="${ review.regDate }" pattern="yyyy-MM-dd" /></span>
											<div class="overflow">${ review.comment }</div>
											<c:if test="${ status.index eq 0 }"><br></c:if>
										</c:if>
									</c:forEach>
								</div>
								<div class="reviewWidth drawOutLine">
									<c:forEach var="review" varStatus="status" items="${ reviewListFour }">
										<c:if test="${ status.index gt 1 }">
											<span>${ review.id }</span><span class="float_right"><fmt:formatDate value="${ review.regDate }" pattern="yyyy-MM-dd" /></span>
											<div class="overflow">${ review.comment }</div>
											<c:if test="${ status.index eq 2 }"><br></c:if>
										</c:if>
									</c:forEach>
								</div>
							</div>
							<button type="button" v-on:click="showReviewList" class="float_right btn btn-dark" style="margin-bottom: 50px;">전체 리뷰 보기</button>
						</c:when>
						<c:otherwise>
							<div style="text-align: center;">후기글이 없음</div>
						</c:otherwise>
					</c:choose>
					
					<div id="dialog" style="width: auto;" title="후기 목록">
						<div><span style="color: #ff385c"><i class="fas fa-star"></i></span>${ score }점ㆍ(후기 ${ count }개)</div><br>
						<c:forEach var="review" items="${ reviewList }">
							<div class="drawOutLine">
								<span>${ review.id }</span><span class="float_right"><fmt:formatDate value="${ review.regDate }" pattern="yyyy-MM-dd" /></span>
								<div><pre>${ review.comment }</pre></div><br>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<hr>
			<div>
				<h3>위치</h3>
				<div id="map" style="width:965px;height:350px;"></div>
			</div>
			<hr>
			<div>
				<h3>알아두어야할 사항</h3>
				<div class="horizontal">
					<div class="notice">
						<h4>숙소 이용규칙</h4>
						<table>
							<tr>
								<td><i class="fas fa-user-clock"></i></td>
								<td>체크인 시간: 오후 3:00 이후</td>
							</tr>
							<tr>
								<td><i class="fas fa-user-clock"></i></td>
								<td>체크아웃 시간: 오전 11:00 이후</td>
							</tr>
							<tr>
								<td><i class="fas fa-smoking-ban"></i></td>
								<td>흡연 금지</td>
							</tr>
							<tr>
								<td><i class="fas fa-dog"></i></td>
								<td>반려동물 동반 불가</td>
							</tr>
							<tr>
								<td><i class="fas fa-birthday-cake"></i></td>
								<td>파티나 이벤트 금지</td>
							</tr>
						</table>
					</div>
					<div class="notice">
						<h4>숙소 이용규칙</h4>
						<table>
							<tr>
								<td><i class="fas fa-hand-sparkles"></i></td>
								<td>에어비앤비의 강화된 청소 절차 준수에 동의했습니다. 자세히 알아보기</td>
							</tr>
							<tr>
								<td><i class="fas fa-people-arrows"></i></td>
								<td>에어비앤비의 사회적 거리 두기 및 관련 가이드라인이 적용됩니다.</td>
							</tr>
						</table>
					</div>
					<div class="notice">
						<h4>환불 정책</h4>
						<p>체크인 5일전까지 수수료 없이 취소 가능</p>
						<p>서비스 수수료를 제외하고 50%가 환불됩니다.</p>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	
<!-- 	<script src="/script/jquery-3.5.1.js"></script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a2aaef4af8220ddff7af9d36feda352a&libraries=services"></script>
<!-- 	<script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script> -->
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.min.js"></script>
	
	<script>
		let bookList = '${ bookList }';
		let str = bookList.substring(1, bookList.length-1);
		str = str.replace(/ /g,"")
		
		var disabledDays = str.split(',');
		
		console.log(disabledDays);
		console.log('disabledDays : ' + disabledDays);
		
		// 집타입 설정
		if('${ hostVo.stayType }' == '집 전체'){
			$('#stayExplan').text('게스트가 숙소 전체를 다른 사람과 공유하지 않고 단독으로 이용합니다. 게스트 전용 출입구가 있고 공용 공간이 없습니다. 일반적으로 침실, 욕실, 부엌이 포함됩니다.');
		} else if('${ hostVo.stayType }' == '개인실') {
			$('#stayExplan').text('게스트에게 개인 침실이 제공됩니다. 침실 이외의 공간은 공용일 수 있습니다.');
		} else if('${ hostVo.stayType }' == '다인실') {
			$('#stayExplan').text('게스트는 개인 공간 없이, 다른 사람과 함께 쓰는 침실이나 공용 공간에서 숙박합니다.');
		}
		
		// 짧은 주소 설정
		let address = '${ hostVo.address1 }';
		let strAddress = address.split(' ');
		$('#address').text(strAddress[0]+ ' ' + strAddress[1]);
	
		$(function() {
            //input을 datepicker로 선언
            //datepicker 한국어로 사용하기 위한 언어설정
			$.datepicker.setDefaults($.datepicker.regional['ko']); 

    		$('#checkInDate').datepicker({
            	dateFormat: 'yy-m-d' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
//                 ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
//                 ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
//                 ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
//                 ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
            	,minDate: 1 
           	 	,showAnim: "slide"
            	,beforeShowDay: disableAllTheseDays
            	,onClose: function(date) {    
                    
            		$('#checkOutDate').datepicker("option", "maxDate");
            		
                    // 시작일을 입력해야 종료일을 입력할수 있도록 함
					if($("#checkInDate").val() != ''){
                    	
                    	vue.startDate = date;
                    	// 시작일(checkInDate) datepicker가 닫힐때
                        // 종료일(checkOutDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                    	// 선택된 날짜의 다음날로 제한하고자 할 때
						let startDate = $('#checkInDate').datepicker("getDate");  // Date return
                      	let endDate = $('#checkInDate').datepicker("getDate");  // Date return
						startDate.setDate( startDate.getDate() + 1 );
                        
                      	// 선택된 날 이후로 선택할수 있게 설정
						$('#checkOutDate').datepicker("option", "minDate", startDate);
    					
                      	// 체크아웃 선택 최대 선택가능한 날짜 설정
						for(let i=0;i<disabledDays.length;i++) {
							let compareDate = new Date(disabledDays[i]);
							let sDate = startDate - compareDate;
							console.log('sDate : ' + sDate);
							console.log('startDate : ' + startDate);
							console.log('compareDate : ' + compareDate);
							
							if(sDate == 0){
								alert('해당 날짜는 선택할 수 없습니다. 다시 선택해주세요.');
								$('#checkOutDate').datepicker('option', 'disabled', true);
								$('#checkInDate').datepicker('setDate');
								$('#checkOutDate').datepicker('setDate');
								vue.startDate = '';
								vue.endDate = '';
								vue.isPaymentShow = false;
								return;
							}
							
							if(sDate < 0) {
								
								let gapPeriod = sDate/(1000*60*60*24)*-1;
								endDate.setDate( startDate.getDate() + gapPeriod );
								$('#checkOutDate').datepicker("option", "maxDate", endDate);
								break;
							} else {
								endDate.setDate( startDate.getDate() + 365 );
								$('#checkOutDate').datepicker("option", "maxDate", endDate);
							}
						}
                      	
						$('#checkOutDate').datepicker('option', 'disabled', false);
                      	
                      	// 체크아웃 선택된 날짜 초기화
						$('#checkOutDate').datepicker('setDate');
					}
                }    
    		});
    		
    		$('#checkOutDate').datepicker({
            	dateFormat: 'yy-m-d' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,showAnim: "slide"
            	,beforeShowDay: disableAllTheseDays
            	,onClose: function(date) {  
            		
            		 if($("#checkOutDate").val() != ''){
						
	            		let startDate = $('#checkInDate').datepicker("getDate");
	            		let endDate = $('#checkOutDate').datepicker("getDate");
	            		let gap = endDate - startDate;
	            		let gapPeriod = gap/(1000*60*60*24);
	            		
//             			$('#checkInDate').datepicker("option", "maxDate", date);
            		  	
            			console.log('endDate : ' + endDate);
            			
						for(let i=0;i<disabledDays.length;i++) {
							let compareDate = new Date(disabledDays[i]);
							
							let sDate = startDate - compareDate;
							let eDate = endDate - compareDate;
							console.log('sDate : ' + sDate);
							console.log('eDate : ' + eDate);

							if((sDate < 0 && eDate > 0) || (sDate > 0 && eDate < 0)) {
								alert('다시 선택해주세요');
								$('#checkOutDate').datepicker('setDate');
								vue.endDate = '';
                        		return;
							}
							
						}
	            		
	            		vue.isPaymentShow = true;
	            		vue.gapPeriod = gapPeriod;
	            		vue.endDate = date;
            		}
            	}
    		});
    		
    		$('#checkOutDate').datepicker('option', 'disabled', true);
    		
			//초기값을 오늘 날짜로 설정
// 			$('#checkInDate').datepicker('setDate', 'today+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)   
			
		});        
        
		// 이전 날짜들은 선택막기
		function noBefore(date){
		    if (date < new Date())
		        return [false];
		    return [true];
		}
		
		function formatDate(date) { 
			let d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear(); 
			
			if (month.length < 2) 
				month = '0' + month; 
			if (day.length < 2) 
				day = '0' + day; 
			
			return [year, month, day].join('-'); 
		}

		
		// 특정일 선택막기
		function disableAllTheseDays(date) {
		    let m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
		    for (i = 0; i < disabledDays.length; i++) {
		        if($.inArray(y + '-' +(m+1) + '-' + d, disabledDays) != -1) {
		            return [false];
		        }
		    }
		    return [true];
		}
		
		vue = new Vue({
		  	el: '#app',
		  	data: {
		  		startDate: '',
		  		endDate: '',
// 		  		disabledDays: ["2021-2-8", "2021-2-11", "2021-2-12"], // 비활성화할 날짜
// 		  		disabledDays: str2,
		  		stayCostPerOneDay: ${ hostVo.cost },
		  		stayCost: 0,
		  		gapPeriod: 1,
		  		cntOfGuest: 1,
		  		cleanerCost: 20000,
		  		serviceCost: 0,
		  		totalCost: 0,
		  		isPaymentShow: false
		  	},		
		  	methods: {
		  		cntOfGuestDown: function() {
		  			if(this.cntOfGuest == 1) {
						alert('최소 인원 수 입니다.')
						return;
					}
		  			this.cntOfGuest--;
		  		},
		  		cntOfGuestUp: function() {
		  			if(this.cntOfGuest == ${ hostVo.countOfPerson }) {
						alert('최대 인원 수 입니다.')
						return;
					}
		  			this.cntOfGuest++;
		  		},
		  		contentModify: function() {
		  			let isModifyContent = confirm('수정하시겠습니까?');
		  			if(isModifyContent) {
		  				location.href = '/content/modify?num=${ hostVo.num }';
		  			}
		  		},
		  		contentDelete: function() {
		  			let isDeleteContent = confirm('정말 삭제하시겠습니까?');
		  			if(isDeleteContent) {
		  				location.href = '/content/delete?num=${ hostVo.num }';	
		  			}
		  			
		  		},
		  		contentSave: function() {
		  			let isSaveContent = confirm('저장하시겠습니까?');
		  			if(isSaveContent) {
		  				$.ajax({
		  					url: '/travel/isExist',
		  					data: { hostNum : ${ hostVo.num }, id: '${ id }' },
		  					success: function(res) {
		  						if(res == 0){
		  							$.ajax({
		  								url: '/travel/save',
		  								data: { hostNum : ${ hostVo.num }, id: '${ id }' },
		  								success: function(res) {
		  									// 1이면 등록된 것
		  									if(res == 1){
			  									let isMove = confirm('저장하였습니다. 저장목록으로 이동하시겠습니까?');
			  						  			if(isMove) {
			  						  				location.href = '/travel/history?viewType=save';
			  						  			}
		  									} else {
												alert('다시 시도해주세요.');
			  								}
		  								}
		  							});
		  						} else {
		  							let isMove = confirm('이미 저장 되어있습니다. 저장목록으로 이동하시겠습니까?');
  						  			if(isMove) {
  						  				location.href = '/travel/history?viewType=save';
  						  			}
		  						}
		  					}
		  				});
		  			}
		  		},
		  		showReviewList: function() {
		  			$("#dialog").dialog("open");
		  		},
		  		booking: function() {
					if('${ id }' == '') {
						alert('로그인을 하셔야 결제를 진행할 수 있습니다.')
						$("#loginModal").modal('show');
			  			return;
					}
		  			let isBooking = confirm('정말 결제하시겠습니까?');
		  			if(isBooking) {
			  			if(this.startDate == ''|| this.endDate == '') {
				  			alert('예약할 날짜를 선택해주세요!');
				  			return;
		  				}
		  				location.href='/book/check?checkIn='+this.startDate+'&checkOut='+this.endDate+'&cost=' + this.totalCost +'&cntOfPerson='+this.cntOfGuest+'&noNum=${ hostVo.num }';
		  			}
		  		}
		  	},
		  	computed: {
		  		setPaymentCost: function() {
		  			this.stayCost = this.gapPeriod * this.stayCostPerOneDay;
		  			return this.stayCost;
		  		},
		  		setServiceCost: function() {
		  			this.serviceCost = this.stayCost * 0.1
		  			return this.serviceCost;
		  		},
		  		setTex: function() {
		  			this.tex = this.gapPeriod * 800;
		  			return this.tex;
		  		},
		  		setTotalCost: function() {
		  			this.totalCost = this.stayCost + this.serviceCost + this.cleanerCost + this.tex;
		  			return this.totalCost;
		  		}
		  	},
		  	filters: {
		  		comma(val){
		  		  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		  		  }
		  	}
		});
		// ====================== 현재 집 위치 지도 ===========================
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${ hostVo.address1 }', function(result, status) {
	
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
	
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리집</div>'
		        });
		        infowindow.open(map, marker);
	
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});  

		// reviewList 다이얼로그
		$("#dialog").dialog({
			width: 600,
			height: 800,
			autoOpen:false, //자동으로 열리지않게
			draggable:false, //창 드래그 못하게
			//"center", "left", "right", "top", "bottom"
			modal:true, //모달대화상자
			resizable:false, //크기 조절 못하게
			position:{ my:"center"}
		});

	</script>
</body>
</html>