<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> <!--     <link rel="stylesheet" type="text/css" href="/css/style.css"> -->
<title>예약하기</title>
<style>
.app {
	width: 1320px;
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

.costTab {
    display: inline-block;
    width: 500px;
    position: sticky;
    top: 10px;
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
.checkDates {
	width: 100px;
}

.drawOutLine {
	border: solid 1px #d2d2d2;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}

.verticalityTags {
/* 	text-align: center; */
/*     display: table-cell; */
/*     vertical-align: middle; */
	display: flex;
	justify-content: space-around;
}

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>

<body style="background-color: #f2f2f2;">
    <div class="app drawOutLine" id="app" style="background-color: white;">
        <div>
            <a href="/content/info?num=${ bookVo.noNum }">
            	<span style="color: #d2d2d2;">
					<i class="fas fa-angle-left fa-lg"></i>
				</span>
			</a>
			<br>
            <h1>예약 요청하기</h1>
            <hr>
        </div>
        <form action="/book/iamport" method="get">
        <div class="horizontal">
            <div>
                <div class="verticality" style="width: 600px;">
                    <div class="discount_info">
                        <div>저렴한 요금</div>
                        <div>검색하시는 날짜의 요금은 지난 3개월의 평균 1박 요금보다 $7 저렴합니다.</div>
                    </div>
                    <div>
                    	<hr>
                    </div>
                    <div class="verticality book_info text-center">
                        <h2>예약정보</h2>
                        <div class="horizontal">
                            <div style="width: 100%; padding: 0px;" class="verticality drawOutLine text-center">
                             	<div style="background: #f2f2f2;">날짜</div>
                                <div>
                                	<input class="checkDates" type="text" id="checkInDate" name="checkIn" v-model="startDate" required readonly>
                                	~
                                	<input class="checkDates" type="text" id="checkOutDate" name="checkOut" v-model="endDate" required readonly>  
                                </div>
                                <div><i class="far fa-clock"></i> 체크인 : 오후 3:00이후</div>
                                <div class="text-center" v-if="showDateBtn">
                                	<button class="btn btn-dark" type="button" v-on:click="setShowDatepicker">날짜 수정하기</button>
                                </div>
                                <div class="text-center" v-if="!showDateBtn">
                                	<button class="btn btn-dark" type="button" v-on:click="setModifyDatepicker">수정</button>
                                </div>
                            </div>
                        </div>
                        <div class="horizontal">
                            <div style="width: 100%; padding:0;" class="verticality drawOutLine text-center" v-if="!showPersonCnt">
								<input type="hidden" name="cntOfPerson" v-model="cntOfPerson">
                                <div style="background: #f2f2f2;">게스트 {{ cntOfPerson }}명</div>
                                <div>
                                	<button class="btn btn-dark" type="button" v-on:click="showPersonCnt = true" v-if="!showPersonCnt">수정</button>
                                </div>
                            </div>
                            <div style="width: 100%; padding:0;" class="drawOutLine text-center" v-if="showPersonCnt">
                            	<div style="background: #f2f2f2;">게스트 인원수 수정</div>
                            	<div>
	                            	<button class="btn btn-dark" type="button" v-on:click="personCountDown">-</button>
									<input class="inputOutLine" name="cntOfPerson" v-model="cntOfPerson" required readonly>
									<button class="btn btn-dark" type="button" v-on:click="personCountUp">+</button>
								</div>
								<div>
									<button class="btn btn-dark" type="button" v-on:click="showPersonCnt = false">설정</button>
									<button class="btn btn-dark" type="button" v-on:click="canelModifyPersonCount">취소</button>
								</div>
                            </div>
                        </div>
                    </div>
                    <div>
                    	<hr>
                    </div>
                    <div class="verticality payment_means text-center">
                        <h2>결제 수단</h2> 
                        <div class="verticalityTags text-center">
                        	<i class="far fa-credit-card fa-2x"></i>
                        	<i class="fas fa-mobile-alt fa-2x"></i>
                        	<img src="/images/kakaopay_icon.png" width="35">
                        	<img src="/images/paypal_icon.png" width="35">
                        	<img src="/images/googleplay_icon.png" width="35">
                        	<img src="/images/payco_icon.png" width="35">
                        	<img src="/images/samsungpay_icon.png" width="35">
                        </div>
                        <div>
                            <select name="payment_means" id="payment-select">
                                <option value="">--Please choose an option--</option>
                                <option value="kakaopay">Kakaopay</option>
                                <option value="paypal">Paypal</option>
                                <option value="payco">Payco</option>
                                <option value="googlepay">googlepay</option>
                            </select>
                        </div>
                        <div><a href="">쿠폰 입력하기</a></div>
                    </div>
                    <div>
                    	<hr>
                    </div>
                    <div class="verticality required_info text-center">
                        <h2>필수 입력 정보</h2>
                        <div class="verticality text-left">
                            <div>호스트에게 메시지 보내기</div>
                            <div>호스트에게 여행 목적과 도착 예정 시간을 알려주세요.</div>
                        </div>
                        <div class="horizontal host_info">
                            <div class="host_photo">
								<c:choose>
									<c:when test="${ not empty userVo.filename }">
										<img src="/upload/${ userVo.uploadpath }/${ userVo.uuid }_${ userVo.filename }" width="100" height="100">
									</c:when>
									<c:otherwise>
										<span><i class="fas fa-user fa-8x"></i></span>
									</c:otherwise>
								</c:choose>
							</div>
                            <div class="verticality text-left">
                                <div class="host_name">${ userVo.id }</div>
                                <div class="host_join_date">에어비앤비 가입: <fmt:formatDate value="${ userVo.regDate }" pattern="yyyy년 MM월 dd일" /></div>
                            </div>
                        </div>
                        <div>
                        	<textarea name="message_to_host" id="message_to_host" cols="30" rows="10" style="resize: none; width: 500px; height: 150px;"></textarea>
                        </div>
                    </div>
                    <div>
                    	<hr>
                    </div>
                    <div class="verticality refund_policy text-center">
                        <h2>환불 정책</h2>
                        <div class="text-left">
                            {{ startDate }} 12:00 PM 전에 예약을 취소하면 요금 전액이 환불됩니다.
                            <br>
                            <a href="">자세히 알아보기</a>
                        </div>
                        <div class="text-left">
                            호스트가 제공하는 환불 정책이 내게 적합한지 확인하세요. 3월 15일 혹은 그 이후 확정된 예약에는 코로나19 확산 사태에 따른 정상참작이 가능한 상황 정책이 적용되지 않습니다.
                            <a href="">자세히 알아보기</a>
                        </div>
                    </div>
                    <div class="confirm_message">
                        <div class="horizontal confirm_message_top">
                            <div class="icon"><i class="far fa-calendar-check"></i></div>
                            <div>호스트가 24시간 이내 예약 요청을 수락하기 전까지는 예약이 아직 확정된 것이 아닙니다.
                                <br>
                                예약 확정 전까지는 요금이 청구되지 않습니다.
                            </div>
                        </div>
                        <div class="confirm_message_bottom">
                            아래 버튼을 선택하면, 숙소 이용규칙, 안전 정보 공개, 환불 정책, 에어비앤비의 사회적 거리 두기 및 기타 코로나19 관련 가이드라인, 및 게스트 환불 정책에 동의하는 것입니다. 또한 숙박세 및 서비스 수수료를 포함하여 표시된 총 금액에 동의합니다. 에어비앤비는 이제 이 지역에서 정부가 부과한 숙박세를 징수하여 납부합니다.
                        </div>
                    </div>
                    <div>
                    	<hr>
                    </div>
                    <div class="btn_book text-center">
                    	<button class="btn btn-dark" type="button" v-on:click="gotoPaymentPage">예약 요청하기</button>
                    </div>
                </div>
            </div>

            <!-- costTab -->
            <div>

                <div class="verticality costTab drawOutLine">
                    <div class="horizontal">
                    <input type="hidden" name="noNum" value="${ bookVo.noNum }">
                        <div class="accommodation_photo">
                        	<img src="/upload/${ imagesVo.uploadpath }/${ imagesVo.uuid }_${ imagesVo.filename }" width="150" height="150">
                        </div>
                        <div class="accommodation_info">
							<p>${ hostVo.id }의 ${ hostVo.houseType } ${ hostVo.stayType }</p>
							<p>${ hostVo.title }</p>
							<p>침대 ${ hostVo.countOfBed }개ㆍ욕실 ${ hostVo.countOfBathroom }개</p>
							<c:if test="${ count ne 0 }">
								<span style="color: #ff385c"><i class="fas fa-star"></i></span><span>${ score }(${ count })</span>
							</c:if>
								
                        </div>
                    </div>
                    <hr>
                    <div class="rate_details text-center">
                    	<input type="hidden" name="cost" v-model="totalCost">
                        <h2>요금 세부정보</h2>
                        <table style="width: 100%">
                            <tr>
                                <td>{{ oneCost | comma }}원 x {{ days }}박</td>
                                <td>{{ setOneCostAndDays | comma }}원</td>
                            </tr>
                        
                            <tr>
								<td>청소비</td>
								<td>{{ 20000 | comma }}원</td>							
							</tr>
                            
                            <tr>
                                <td>서비스 수수료</td>
                                <td>{{ setServiceCost | comma }}원</td>
                            </tr>
                            <tr>
                                <td>숙박세와 수수료</td>
                                <td>{{ serTaxCost | comma }}원</td>
                            </tr>
                            <tr>
                                <td>총 합계 (WON)</td>
                                <td>{{ setTotalCost | comma }}원</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </form>
	</div>
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script>
		let bookList = '${ bookList }';
		let str = bookList.substring(1, bookList.length-1);
		str = str.replace(/ /g,"")
		
		var disabledDays = str.split(',');
		console.log(disabledDays);
		
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
							
							if(sDate == 0){
								alert('해당 날짜는 선택할 수 없습니다. 다시 선택해주세요.');
								$('#checkOutDate').datepicker('option', 'disabled', true);
								$('#checkInDate').datepicker('setDate');
								$('#checkOutDate').datepicker('setDate');
								vue.startDate = '';
								vue.endDate = '';
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
						vue.endDate = '';
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
	            		console.log('gapPeriod : ' + gapPeriod);
//             			$('#checkInDate').datepicker("option", "maxDate", date);
            			
						for(let i=0;i<disabledDays.length;i++) {
							let compareDate = new Date(disabledDays[i]);
							
							let sDate = startDate - compareDate;
							let eDate = endDate - compareDate;

							if((sDate < 0 && eDate > 0) || (sDate > 0 && eDate < 0)) {
								alert('다시 선택해주세요');
								$('#checkOutDate').datepicker('setDate');
								vue.endDate = '';
                        		return;
							}
							
						}
	            		
	            		vue.isPaymentShow = true;
	            		vue.days = gapPeriod;
	            		vue.endDate = date;
            		}
            	}
    		});
    		
    		$('#checkOutDate').datepicker('option', 'disabled', true);
    		$('#checkInDate').datepicker('option', 'disabled', true);
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
				showDateBtn: true,
				startDate: '${ bookVo.checkIn }',
				endDate: '${ bookVo.checkOut }',
				showPersonCnt: false,
				cntOfPerson: ${ bookVo.cntOfPerson },
				oneCost: ${ hostVo.cost },
				days: ${ days },
				serviceCost: 0,
				taxCost: 0,
				totalCost: 0
			},
			methods: {
				personCountUp: function() {
					if(this.cntOfPerson == ${ hostVo.countOfPerson }) {
						alert('최대 인원수 입니다.');
						return;
					}
					this.cntOfPerson++;
				},
				personCountDown: function() {
					if(this.cntOfPerson == 1) {
						alert('최소 인원수 입니다.');
						return;
					}
					this.cntOfPerson--;
				},
				canelModifyPersonCount: function() {
					this.cntOfPerson = ${ bookVo.cntOfPerson };
					this.showPersonCnt = false
				},
				setShowDatepicker: function() {
					$('#checkInDate').datepicker('option', 'disabled', false);
					this.showDateBtn = false;
				},
				setModifyDatepicker: function() {
					if($('#checkOutDate').val() == '' || $('#checkInDate').val() == '') {
						alert('날짜를 넣어주세요!');
						return;
					}
						
					$('#checkOutDate').datepicker('option', 'disabled', true);
		    		$('#checkInDate').datepicker('option', 'disabled', true);
					this.showDateBtn = true;
				},
				gotoPaymentPage: function() {
					if($('#checkOutDate').val() == '' || $('#checkInDate').val() == '') {
						alert('날짜를 넣어주세요!');
						return;
					}

					location.href='/book/iamport?id=${ bookVo.id }&checkIn=' + this.startDate + '&checkOut='+this.endDate+'&cntOfPerson='+this.cntOfPerson+'&noNum=${ bookVo.noNum }&cost='+this.totalCost;
				}
			},
			computed: {
				setOneCostAndDays: function() {
					return this.oneCost * this.days;
				},
				setServiceCost: function() {
					this.serviceCost = this.oneCost * this.days * 0.1;
					return this.serviceCost;
				},
				serTaxCost: function() {
					this.taxCost = this.days * 800;
					return this.taxCost;
				},
				setTotalCost: function() {
					this.totalCost = this.oneCost * this.days + 20000 + this.serviceCost + this.taxCost;
					return this.totalCost;
				}
			},
			filters: {
		  		comma(val){
		  		  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		  		  }
		  	}
			
		});
</script>
</body>
</html>