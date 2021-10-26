<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호스트 등록</title>
<style>
.app {
	width: 1000px;
	display: block;
	margin: 0 auto;
	position: relative;
}

div {
	padding: 10px;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}
.verticality {
	display: inline-flex;
	flex-direction: column;
}

.horizontal {
	display: inline-flex;
	flex-direction: row;
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

th {
	padding-right: 20px;
}

.drawOutLine {
	border: solid 1px #d2d2d2;
}
.tableSmall {
	width: 300px;
	height: 100px;
	margin: auto;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div class="app" style="background-color: white">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div id="app">
			<form action="/content/write" method="post" enctype="multipart/form-data">
				<a href="/user/show">
					<span style="color: #d2d2d2;">
						<i class="fas fa-angle-left fa-lg"></i>
					</span>
				</a>
				<div>
					<h3>등록하실 숙소 종류는 무엇인가요?</h3>
					<p>숙소의 건물 유형을 선택해주세요.</p>
					<select v-model="selectedItem" name="classification" v-on:change="selectedExplan">
						<option disabled selected>하나를 선택해주세요.</option>
						<option value="아파트">아파트</option>
						<option value="주택">주택</option>
						<option value="별채">별채</option>
						<option value="독특한 숙소">독특한 숙소</option>
						<option value="B&B">B&B</option>
						<option value="부티크 호텔">부티크 호텔</option>
					</select>
					<br>
					<br>
					<p>{{ explan }}</p>
					<hr>
					<div v-if="isDetailShow">
						<p>이제 더 구체적인 유형을 선택해주세요.</p>
						<select v-model="detailSelectedItem" name="houseType" v-on:change="detailSelectedExplan">
							<option v-for="option in options" v-bind:value="option.value">{{ option.text }}</option>
						</select>
						<br>
						<br>
						<p>{{ detailExplan }}<p>
						<hr>
					</div>
					
					<div v-if="isStayTypeShow">
						<p>게스트가 이용할 숙소 유형을 확인해주세요</p>
						<select v-model="staySeletedItem" name="stayType" v-on:change="staySeletedItemExplan">
							<option value="집 전체">집 전체</option>
							<option value="개인실">개인실</option>
							<option value="다인실">다인실</option>
						</select>
						<br>
						<br>
						<p>{{ stayExplan }}<p>
						<hr>
					</div>
				</div>
				
				<div v-if="isPersonCountShow">
					<h3>숙소에 얼마나 많은 인원이 숙박할 수 있나요?</h3>
					<p>모든 게스트가 편하게 숙박할 수 있도록 침대가 충분히 구비되어 있는지 확인하세요.</p>
					<table class="tableSmall">
						<tr>
							<th>최대 숙박 인원</th>
							<td>
								<button class="btn btn-dark" type="button" v-on:click="personCountDown">-</button>
								<input class="inputOutLine" name="countOfPerson" v-model="personCount" readonly>
								<button class="btn btn-dark" type="button" v-on:click="personCountUp">+</button>
							</td>
						</tr>
					</table>
					<hr>
					<p>게스트가 사용할수 있는 침실은 몇 개인가요?</p>
					<select name="countOfBedroom" v-model="countOfBedRoom">
						<option v-for="option in countOfBedRooms" v-bind:value="option.value">{{ option.text }}</option>
					</select>
					<hr>
					<p>게스트가 사용할수 있는 침대는 몇 개인가요?</p>
					<table class="tableSmall">
						<tr>
							<th>침대</th>
							<td>
								<button class="btn btn-dark" type="button" v-on:click="bedCountDown">-</button>
								<input class="inputOutLine" name="countOfBed" v-model="bedCount" readonly>
								<button class="btn btn-dark" type="button" v-on:click="bedCountUp">+</button>
							</td>
						</tr>
					</table>
					<br>
					<h4>침대의 유형</h4>
					<p>각 침실에 놓인 침대 유형을 명시하면 숙소에 침대가 어떻게 구비되어 있는지 게스트가 잘 파악할 수 있습니다.</p>
					<div class="drawOutLine text-center">
						<p>공용공간</p>
						<p>침대 {{ publicBedTotalCount }}개</p>
						<table class="tableSmall" v-if="isPublicBedShow">
							<tr>
								<th>소파베드</th>
								<td>
									<button class="btn btn-dark" type="button" v-on:click="sofeBedCountDown">-</button>
									<input class="inputOutLine" name="countOfSofeBed" v-model="sofeBedCount" readonly>
									<button class="btn btn-dark" type="button" v-on:click="sofeBedCountUp">+</button>
								</td>
							</tr>
							<tr>
								<th>소파</th>
								<td>
									<button class="btn btn-dark" type="button" v-on:click="sofeCountDown">-</button>
									<input class="inputOutLine" name="countOfSofe" v-model="sofeCount" readonly>
									<button class="btn btn-dark" type="button" v-on:click="sofeCountUp">+</button>
								</td>
							</tr>
							<tr>
								<th>요와 이불</th>
								<td>
									<button class="btn btn-dark" type="button" v-on:click="blanketCountDown">-</button>
									<input class="inputOutLine" name="countOfBlanket" v-model="blanketCount" readonly>
									<button class="btn btn-dark" type="button" v-on:click="blanketCountUp">+</button>
								</td>
							</tr>
						</table>
						<div class="text-center">
							<button class="btn btn-dark" type="button" v-on:click="setPublicBedShow">{{ addPublicBedBtnName }}</button>
						</div>
					</div>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isBathRoomCountShow" v-on:click="setBathRoomCountShow">욕실 수 정하기</button>
					</div>
				</div>
				<div v-if="isBathRoomCountShow">
					<h3>욕실 수</h3>
					<p>샤워실 또는 욕조가 없는 경우 0.5개로 간주합니다.</p>
					<table class="tableSmall">
						<tr>
							<th>욕실 수</th>
							<td>
								<button class="btn btn-dark" type="button" v-on:click="bathroomCountDown">-</button>
								<input class="inputOutLine" name="countOfBathroom" v-model="bathroomCount" readonly>
								<button class="btn btn-dark" type="button" v-on:click="bathroomCountUp">+</button>
							</td>
						</tr>
					</table>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isLocationShow" v-on:click="setLocationShow">숙소의 위치 정하기</button>
					</div>
				</div>
				
				<div v-if="isLocationShow">
					<h3>숙소의 위치를 알려주세요.</h3>
					<p>정확한 숙소 주소는 게스트가 예약을 완료한 후에만 공개됩니다.</p>
					<input type="text" name="postcode" placeholder="우편번호" readonly required v-model="postcode">
					<button class="btn btn-dark" type="button" v-on:click="openDaumZipAddress">주소찾기</button><br>
					<input type="text" name="address1" placeholder="주소" readonly required v-model="address1"><br>
					<input type="text" name="address2" placeholder="상세주소" required required v-model="address2"><br>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isAmenitiesShow" v-on:click="setAmenitiesShow">편의시설 정하기</button>
					</div>
				</div>
				
				<div v-if="isAmenitiesShow">
					<h3>어떤 편의시설을 제공하시나요?</h3>
					<p>일반적으로 게스트가 기대하는 편의시설 목록입니다. 숙소를 등록한 후 언제든 편의시설을 추가할 수 있어요.</p>
					<input type="hidden" name="amenities" v-model="amenitiesCheck">
					<table>
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="필수 품목"></td>
							<td>
								<p>필수 품목</p>
								<p>수건,침대 시트,비누,화장지,배게</p>
							</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="무선인터넷"></td>
							<td>무선인터넷</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="TV"></td>
							<td>TV</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="난방"></td>
							<td>난방</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="에어콘"></td>
							<td>에어콘</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="다리미"></td>
							<td>다리미</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="샴푸"></td>
							<td>샴푸</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="헤어드라이기"></td>
							<td>헤어드라이기</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="조식"></td>
							<td>조식</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="업무 가능 공간/책상"></td>
							<td>업무 가능 공간/책상</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="벽난로"></td>
							<td>벽난로</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="옷장/서랍장"></td>
							<td>옷장/서랍장</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="amenitiesCheck" value="게스트 전용 출입문"></td>
							<td>게스트 전용 출입문</td>
						<tr>
					</table>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isSafetyShow" v-on:click="setSafetyShow">안전시설 정하기</button>
					</div>
				</div>
				
				<div v-if="isSafetyShow">
					<h3>안전시설</h3>
					<input type="hidden" name="safety" v-model="safetyCheck">
					<table>
						<tr>
							<td><input type="checkbox" v-model="safetyCheck" value="화재 감지기"></td>
							<td>
								<p>화재 감지기</p>
								<p>잘 동작하는 화재 감지기를 모든 방에 구비해 놓아야 하는지 현지 법규를 확인해보세요.</p>
							</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="safetyCheck" value="일산화탄소 감지기"></td>
							<td>
								<p>일산화탄소 감지기</p>
								<p>일산화탄소 감지기 구비 요건에 대한 현지 법규를 확인해보세요.
								지역에 따라, 정상적으로 작동하는 일산화탄소 감지기를 모든 방에 설치해야 할 수 있습니다.</p>
							</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="safetyCheck" value="구급상자"></td>
							<td>구급상자</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="safetyCheck" value="소화기"></td>
							<td>소화기</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="safetyCheck" value="침실문 장금장치"></td>
							<td>
								<p>안전과 사생활 보호를 위해 방문을 잠글 수 있습니다.</p>
							</td>
						<tr>
					</table>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isUsefullShow" v-on:click="setUsefullShow">게스트 사용 공간 정하기</button>
					</div>
				</div>
				<div v-if="isUsefullShow">
					<h3>게스트가 어떤 공간을 사용할 수 있나요?</h3>
					<p>등록하고자 하는 숙소에서 게스트가 이용 가능한 공용 공간을 선택하세요.</p>
					
					<input type="hidden" name="usefull" v-model="usefullCheck">
					<table>
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="세탁 공간-건조기"></td>
							<td>세탁 공간-건조기</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="자쿠지"></td>
							<td>자쿠지</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="주방"></td>
							<td>주방</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="수영장"></td>
							<td>수영장</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="세탁 공간-세탁기"></td>
							<td>세탁 공간-세탁기</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="주차"></td>
							<td>주차</td>
						<tr>
						
						<tr>
							<td><input type="checkbox" v-model="usefullCheck" value="헬스장"></td>
							<td>헬스장</td>
						<tr>
					</table>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isPicFileShow" v-on:click="setPicFileShow">사진 업로드하기</button>
					</div>
				</div>
				
				<div v-if="isPicFileShow">
					<h3>멋진 사진으로 숙소가 돋보이게 해주세요.</h3>
					<p>휴대전화나 카메라를 사용하여 사진을 찍으세요.
					숙소를 등록하려면 1장 이상의 사진을 업로드하세요.
					원하는 대로 드래그하여 사진 배치 순서를 결정할 수 있습니다.
					언제든 사진을 추가하거나 수정할 수 있습니다.</p>
					<br>
					<br>
					<div id="fileBox">
						<div>
							<img v-if="imageUrl[0]" :src="imageUrl[0]" width="200">
							<input type="file" name="filename" accept="image/*" @change="onFileChange" required>
							<span class="file-delete" v-bind:data-num="0" v-on:click="deleteFile($event)"><i class="far fa-trash-alt"></i></span>
						</div>
						
						<div v-if="fileView[1]">
							<img v-if="imageUrl[1]" :src="imageUrl[1]" width="200" >
							<input type="file" name="filename" accept="image/*" @change="onFileChange">
							<span class="file-delete" v-bind:data-num="1" v-on:click="deleteFile($event)"><i class="far fa-trash-alt"></i></span>
						</div>
						
						<div v-if="fileView[2]">
							<img v-if="imageUrl[2]" :src="imageUrl[2]" width="200">
							<input type="file" name="filename" accept="image/*" @change="onFileChange">
							<span class="file-delete" v-bind:data-num="2" v-on:click="deleteFile($event)"><i class="far fa-trash-alt"></i></span>
						</div>
						
						<div v-if="fileView[3]">
							<img v-if="imageUrl[3]" :src="imageUrl[3]" width="200">
							<input type="file" name="filename" accept="image/*" @change="onFileChange">
							<span class="file-delete" v-bind:data-num="3" v-on:click="deleteFile($event)"><i class="far fa-trash-alt"></i></span>
						</div>
						
						<div v-if="fileView[4]">
							<img v-if="imageUrl[4]" :src="imageUrl[4]" width="200">
							<input type="file" name="filename" accept="image/*" @change="onFileChange">
							<span class="file-delete" v-bind:data-num="4" v-on:click="deleteFile($event)"><i class="far fa-trash-alt"></i></span>
						</div>
					</div>
					<div class="text-center">
						<input type="button" class="btn btn-dark" v-on:click="addFile" value="첨부파일 추가">
					</div>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isExplanShow" v-on:click="setExplanShow">숙소 설명하기</button>
					</div>
				</div>
				<div v-if="isExplanShow">
					<h3>게스트에게 숙소에 대한 설명해주세요.</h3>
					<p>숙소의 장점, 특별한 편의시설(예: 빠른 와이파이 또는 주차 시설)과 주변지역의 매력을 소개해주세요.</p>
					<div style="position: relative; padding: 0">
						<textarea name="hostComment" maxlength="500" v-model="hostComment" required style="resize: none; width: 570px; height: 120px;"></textarea>
						<span style="position: relative; left: -50px; top: -20px;">{{ hostCommentCount }}</span>
					</div>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" v-if="!isCostShow" v-on:click="setCostShow">숙소 요금 설정하기</button>
					</div>
				</div>
				<div v-if="isCostShow">
					<h3>숙소 요금 설정하기</h3>
					<h4>예약을 받을 가능성을 높이세요</h4>
					<p>스마트 요금을 설정하면 숙소가 위치한 지역에 대한 수요에 따라 1박 요금이 자동으로 조정되어 경쟁력을 유지할 수 있습니다.</p>
					<br>
					<h4>모든 날짜에 동일하게 적용할 기본 요금을 설정하세요</h4>
					<p>호스트가 책정한 숙박 요금에 14%의 게스트 서비스 수수료가 부과됩니다. 단, 숙박 기간에 따라 수수료 비율이 다를 수 있습니다.</p>
					<br>
					<h4>기본 요금</h4>
					<p>이 요금이 기본 요금이 됩니다.</p>
					<input type="number" name="cost" v-model="basicCost" value="10000" min="10000">
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-if="!isTitleShow" v-on:click="setTitleShow">숙소 제목 정하기</button>
					</div>
				</div>
				<div v-if="isTitleShow">
					<h3>숙소의 제목을 만드세요.</h3>
					<p>숙소의 특징과 장점을 강조하는 제목으로 게스트의 관심을 끟어보세요.</p>
					
					<div style="position: relative; padding: 0px;">
						<input type="text" name="title" v-model="title" maxlength="50" required style="width: 570px;">
						<span style="position: relative; left: -30px;">{{ titleCount }}</span>
					</div>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="submit">등록하기</button>
					</div>
				</div>
			</form>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script> -->
<!-- 	<script src="/script/jquery-3.5.1.js"></script> -->
<!-- 	<script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script> -->
	<script>
		var domEleArray = [$('input[name="filename"]').clone()];
		
		new Vue({
			el: '#app',
			data: {
				// 숙소의 타입 설정
				selectedItem: '',
				explan: '',
				options: [],
				detailSelectedItem: '',
				detailExplan: '',
				isDetailShow: false,
				staySeletedItem: '',
				stayExplan: '',
				isStayTypeShow: false,
				
				// 숙소 인원수 설정
				isPersonCountShow: false,
				personCount: 1,
				
				// 숙소 침실 및 침대 설정
				countOfBedRoom: 0,
				countOfBedRooms: [
					{ text: "침실0개", value: 0},
					{ text: "침실1개", value: 1},
					{ text: "침실2개", value: 2},
					{ text: "침실3개", value: 3},
					{ text: "침실4개", value: 4},
					{ text: "침실5개", value: 5},
				],
				bedCount: 1,
				
				// 욕실 설정
				isBathRoomCountShow: false,
				bathroomCount: 1,
				
				// 공용 침대 설정
				addPublicBedBtnName: '침대 추가하기',
				isPublicBedShow: false,
				sofeBedCount: 0,
				sofeCount: 0,
				blanketCount: 0,
				
				// 주소 설정
				isLocationShow: false,
				postcode: '',
				address1: '',
				address2: '',
				
				// 편의시설 설정				
				isAmenitiesShow: false,
				amenitiesCheck: [],
				
				// 안전시설 설정
				isSafetyShow: false,
				safetyCheck: [],
				
				// 사용가능한 시설 설정
				isUsefullShow: false,
				usefullCheck: [],
				
				// 사진 설정
				fileView: [true, false, false, false, false],
				isPicFileShow: false,
				imageUrl: [null, null, null, null, null],
				
				// 호스트 코멘트
				hostComment: '',
				isExplanShow: false,
				
				// 가격 설정
				basicCost: 0,
				isCostShow: false,
				
				// 제목 설정
				title: '',
				isTitleShow: false
				
			},
			methods: {
				selectedExplan: function() {
					this.isDetailShow = true;
					let appartment = [
							{ text: '아파트', value: '아파트' }, 
							{ text: '공동주택', value: '공동주택' }, 
							{ text: '레지던스', value: '레지던스' }, 
							{ text: '로프트', value: '로프트'} ];
					let housing = [
						{ text: '펜션', value: '펜션' }, 
						{ text: '단독 또는 다세대 주택', value: '단독 또는 다세대 주택' }, 
						{ text: '저택', value: '저택' }, 
						{ text: '타운하우스', value: '타운하우스'},
						{ text: '전원주택', value: '전원주택'},
						{ text: '방갈로', value: '방갈로'}];
					let separate_building = [
						{ text: '게스트 스위트', value: '게스트 스위트' }, 
						{ text: '게스트용 별채', value: '게스트용 별채' }, 
						{ text: '농장 체험 숙박', value: '농장 체험 숙박' }];
					let unique_accommodation = [
						{ text: '팬션', value: '팬션' }, 
						{ text: '초소형 주택', value: '초소형 주택' }, 
						{ text: '농장 체험 숙박', value: '농장 체험 숙박' }, 
						{ text: '캠핑카', value: '캠핑카'},
						{ text: '보트', value: '보트'},
						{ text: '캠핑장', value: '캠핑장'}];
					let bnb = [
						{ text: 'Bed and breakfast', value: 'Bed and breakfast' }, 
						{ text: '농장 체험 숙박', value: '농장 체험 숙박' }, 
						{ text: '산장', value: '산장' }];
					let boutique_hotel = [
						{ text: '호텔', value: '호텔' }, 
						{ text: '부티크 호텔', value: '부티크 호텔' }, 
						{ text: '호스텔', value: '호스텔' }, 
						{ text: '리조트', value: '리조트'},
						{ text: '레지던스', value: '레지던스'},
						{ text: '아파트 호텔', value: '아파트 호텔'}];
					
					if(this.selectedItem == '아파트') {
						this.explan = '아파트: 일반적으로 다세대가 거주하는 건물 또는 여러 사람이 함께 거주하는 단지를 의미합니다.';
						this.options = appartment;
					} else if (this.selectedItem == '주택') {
						this.explan = '주택: 주로 단독 세대가 사용하는 건물이지만, 듀플렉스 같은 주택의 경우에는 다른 세대와 벽이나 실외 공간을 공유할 수도 있습니다.';
						this.options = housing;
					} else if (this.selectedItem == '별채') {
						this.explan = '별채: 게스트용 전용 출입구가 있으며, 보통 다른 구조물과 필지를 공유합니다.';
						this.options = separate_building;
					} else if (this.selectedItem == '독특한 숙소') {
						this.explan = '독특한 숙소: 일반적인 주택이나 아파트에 비해 건물이 흥미롭거나 특이한 숙소입니다.';
						this.options = unique_accommodation;
					} else if (this.selectedItem == 'B&B') {
						this.explan = 'B&B: 게스트에게 조식을 제공하는 전문 숙박업체로, 호스트가 같은 건물에 사는 경우가 많습니다.';
						this.options = bnb;
					} else if (this.selectedItem == '부티크 호텔') {
						this.explan = '부티크 호텔: 브랜드 특색이 담긴 테마와 인테리어로 꾸며진 전문 숙박업체입니다.';
						this.options = boutique_hotel;
					}
				},
				detailSelectedExplan: function() {
					this.isStayTypeShow = true;
					 if (this.detailSelectedItem == '공동주택') {
						this.detailExplan = '공동주택: 일반적으로 다세대가 거주하는 건물 또는 여러 사람이 함께 거주하는 단지를 의미합니다. 공동주택은 개인이 소유하는 반면 아파트는 임대로 운영되는 것이 일반적입니다.';
					} else if (this.detailSelectedItem == '레지던스') {
						this.detailExplan = '레지던스: 전문 관리업체가 객실 내 모든 물품을 구비하고 서비스를 제공하는 아파트로, 매일 객실 청소, 프런트 데스크 등 호텔 같은 편의시설을 제공합니다.';
					} else if (this.detailSelectedItem == '로프트') {
						this.detailExplan = '로프트: 보통 아파트나 콘도에 있으며 개방적인 구조입니다. 로프트에는 대부분 내부 공간을 분리하는 벽이 없습니다.';
					} else if (this.detailSelectedItem == '펜션') {
						this.detailExplan = '펜션: 한국의 휴가용 별장으로, 주로 시골 지역에 위치해 있습니다. 바비큐 시설이 갖춰져 있는 경우가 많으며, 기타 공용 공간도 마련되어 있습니다.';
					} else if (this.detailSelectedItem == '단독 또는 다세대 주택') {
						this.detailExplan = '단독 또는 다세대 주택: 주로 단독 세대가 사용하는 건물입니다. 듀플렉스 같은 주택의 경우에는 다른 세대와 벽이나 실외 공간을 공유할 수도 있습니다.';
					} else if (this.detailSelectedItem == '저택') {
						this.detailExplan = '저택: 실내 및 실외 공간을 갖추고 큰 마당과 정원 또는 수영장이 있는 고급 주택을 말합니다.';
					} else if (this.detailSelectedItem == '타운하우스') {
						this.detailExplan = '타운하우스: 로우 하우스, 테라스 하우스와 같이 옆 세대의 건물과 붙어 있거나 실외 공간을 공유하기도 합니다.';
					}  else if (this.detailSelectedItem == '방갈로') {
						this.detailExplan = '방갈로: 넓은 현관과 박공지붕 등의 특징을 지닌 주택입니다. 단층으로 되어 있는 경우가 많습니다.';
					} else if (this.detailSelectedItem == '게스트 스위트') {
						this.detailExplan = '게스트 스위트: 가족을 위한 별채라고 불리는 형태로, 주택 등 본채 구조물의 내부에 있거나 나란히 붙어 있는 별도의 공간이며 전용 출입구를 갖추고 있습니다.';
					} else if (this.detailSelectedItem == '게스트용 별채') {
						this.detailExplan = '게스트용 별채: 주택 등 단독 건물과 필지를 공유하지만 단독으로 지어진 건물로, 예전에 마차 보관 용도로 사용했던 탓에 마차 보관소라고 불리기도 합니다.';
					}  else if (this.detailSelectedItem == '농장 체험 숙박') {
						this.detailExplan = '농장 체험 숙박: 농촌에서 게스트가 동물들과 교감하거나 등산이나 수공예 등의 여러 가지 활동을 즐길 수 있도록 서비스를 제공하며, 일반적으로 전문 숙박업체로 운영됩니다.';
					} else if (this.detailSelectedItem == '초소형 주택') {
						this.detailExplan = '초소형 주택: 크기가 매우 작고 내부 공간이 협소한 단독 주택으로, 37제곱미터(400제곱피트) 이하의 주택을 말합니다.';
					} else if (this.detailSelectedItem == '캠핑카') {
						this.detailExplan = '캠핑카: 크기에 상관없이 집과 차량의 중간 형태를 띤 주거용 차량이나 작은 주거 공간을 갖춘 캠핑 트레일러를 지칭합니다.';
					} else if (this.detailSelectedItem == '보트') {
						this.detailExplan = '보트: 레저용 요트에서 고급 요트까지 다양한 형태의 배로 게스트가 머무는 동안 정박 상태를 유지합니다. 선상 가옥이나 수상 가옥 등 주거용 보트인 경우에는 하우스보트를 선택하세요.';
					} else if (this.detailSelectedItem == '보트') {
						this.detailExplan = '캠핑장: 게스트가 자신의 텐트나 유르트, 캠핑용 자동차 또는 RV, 초소형 주택 등을 직접 세울 수 있도록 호스트가 허용할 수 있는 부지를 의미합니다.';
					} else if (this.detailSelectedItem == 'Bed and breakfast') {
						this.detailExplan = 'Bed and breakfast: 게스트에게 조식을 제공하는 전문 숙박업체로, 호스트가 같은 건물에 사는 경우가 많습니다.';
					} else if (this.detailSelectedItem == '산장') {
						this.detailExplan = '산장: 숲이나 산 등 자연 속에 지어진 전문 숙박업체를 지칭합니다.';
					} else if (this.detailSelectedItem == '부티크 호텔') {
						this.detailExplan = '부티크 호텔: 브랜드 특색이 담긴 테마와 인테리어로 꾸며진 전문 숙박업체입니다.';
					} else if (this.detailSelectedItem == '호스텔') {
						this.detailExplan = '호스텔: 여러 명이 함께 지내는 다인실이나 개인실을 운영하는 전문 숙박업체입니다.';
					} else if (this.detailSelectedItem == '리조트') {
						this.detailExplan = '리조트: 호텔 객실은 물론, 호텔보다 더 다양한 서비스와 편의시설을 제공하는 개인 임대 숙소까지 제공하는 전문 숙박업체입니다.';
					} else if (this.detailSelectedItem == '아파트 호텔') {
						this.detailExplan = '아파트 호텔: 프런트 데스크를 포함해 호텔과 비슷한 편의시설 및 아파트와 비슷한 방을 갖춘 호텔 같은 숙박 시설입니다.';
					} else if (this.detailSelectedItem == '아파트') {
						this.detailExplan = '아파트: 일반적으로 다세대가 거주하는 건물 또는 여러 사람이 함께 거주하는 단지를 의미합니다.';
					} 
				},
				staySeletedItemExplan: function() {
					this.isPersonCountShow = true;
					if (this.staySeletedItem == '집 전체') {
						this.stayExplan = '집 전체: 게스트가 숙소 전체를 다른 사람과 공유하지 않고 단독으로 이용합니다. 게스트 전용 출입구가 있고 공용 공간이 없습니다. 일반적으로 침실, 욕실, 부엌이 포함됩니다.';
					} else if (this.staySeletedItem == '개인실') {
						this.stayExplan = '개인실: 게스트에게 개인 침실이 제공됩니다. 침실 이외의 공간은 공용일 수 있습니다.';
					} else if (this.staySeletedItem == '다인실') {
						this.stayExplan = '다인실: 게스트는 개인 공간 없이, 다른 사람과 함께 쓰는 침실이나 공용 공간에서 숙박합니다.';
					}
				}, 
				personCountUp: function() {
					if(this.personCount == 10) {
						alert('최대 인원수 입니다.');
						return;
					}
					this.personCount++;
				},
				personCountDown: function() {
					if(this.personCount == 1) {
						alert('최소 인원수 입니다.');
						return;
					}
					this.personCount--;
				},
				bedCountUp:function() {
					if(this.bedCount == 5){
						alert('최대 침대수 입니다.');
						return;
					}
					this.bedCount++;
				},
				bedCountDown:function() {
					if(this.bedCount == 1){
						alert('최소 침대수 입니다.');
						return;
					}
					this.bedCount--;
				},
				sofeBedCountUp: function() {
					if(this.sofeBedCount == 5) {
						alert('최대값 입니다.')
						return;
					}
					this.sofeBedCount++;
				},
				sofeBedCountDown: function() {
					if(this.sofeBedCount == 0) {
						alert('최소값 입니다.')
						return;
					}
					this.sofeBedCount--;
				},
				sofeCountUp: function() {
					if(this.sofeCount == 5) {
						alert('최대값 입니다.')
						return;
					}
					this.sofeCount++;
				},
				sofeCountDown: function() {
					if(this.sofeCount == 0) {
						alert('최소값 입니다.')
						return;
					}
					this.sofeCount--;
				},
				blanketCountUp: function() {
					if(this.blanketCount == 5) {
						alert('최대값 입니다.')
						return;
					}
					this.blanketCount++;
				},
				blanketCountDown: function() {
					if(this.blanketCount == 0) {
						alert('최소값 입니다.')
						return;
					}
					this.blanketCount--;
				},
				setPublicBedShow: function() {
					if(this.isPublicBedShow) {
						this.isPublicBedShow = false;
						this.addPublicBedBtnName = '침대 추가하기';
						
					} else {
						this.isPublicBedShow = true;
						this.addPublicBedBtnName = '완료';
					}
				},
				
				setBathRoomCountShow: function() {
					this.isBathRoomCountShow = true;
				},
				
				bathroomCountUp: function() {
					if(this.bathroomCount == 5) {
						alert('최대 욕실수 입니다.')
						return;
					}	
					this.bathroomCount++;
				},
				
				bathroomCountDown: function() {
					if(this.bathroomCount == 1) {
						alert('최소 욕실수 입니다.')
						return;
					}	
					this.bathroomCount--;
				},
				setLocationShow: function() {
					this.isLocationShow = true;
				},
				openDaumZipAddress: function() {
					let vm = this;
					new daum.Postcode({
						oncomplete: function(data) {
							vm.postcode = data.zonecode;
							vm.address1 = data.address;
						}	
					}).open();
				},
				setAmenitiesShow: function() {
					this.isAmenitiesShow = true;
				},
				setSafetyShow: function() {
					this.isSafetyShow = true;
				},
				setUsefullShow: function() {
					this.isUsefullShow = true;
				},
				addFile: function() {
					for(let i=0;i<this.fileView.length;i++) {
						if(!this.fileView[i]) {
							this.fileView.splice(i, 1, true);
							break;
						}
					}
				},
				deleteFile: function($event) {
					let tag = event.currentTarget.parentNode.querySelector('input[name="filename"]');
					let num = $(event.currentTarget).data('num');
					this.fileView.splice(num, 1, false);
					$(tag).val('');
					this.imageUrl.splice(num, 1, null);
				},
				onFileChange(e) {
			        var files = e.target.files || e.dataTransfer.files;
			        if (!files.length)
			       		return;
			        let num = $(e.currentTarget.parentNode.querySelector('span')).data('num');
// 			        console.log('선택한 이미지번호 : ' + num);
			        this.createImage(files[0], num);
			     
		   		},
			    createImage(file, num) {
		       		var image = new Image();
		        	var reader = new FileReader();
		        	var vm = this;
					var ImageListNum = num;
			        reader.onload = (e) => {
			        	console.log('e.target.result : ' + e.target.result);
			        	vm.imageUrl.splice(ImageListNum, 1, e.target.result);
			          	vm.imageUrl[ImageListNum] = e.target.result;
		       		};
			        reader.readAsDataURL(file);
		 	    },
				setPicFileShow: function() {
					this.isPicFileShow = true;
				},
				setExplanShow: function() {
					this.isExplanShow = true;
				},
				setCostShow: function() {
					this.isCostShow = true;
				},
				setTitleShow: function() {
					this.isTitleShow = true;
				},
				 updateDate: function(d) {
				      this.date = d;
			    }
			    
			},
			watch: {
				hostComment: function() {
					if(this.hostComment.length> 500) {
						this.hostComment = this.hostComment.subStr(0,500);
					}
				},
				title: function() {
					if(this.title.length > 50) {
						this.title = this.title.subStr(0,50);
					}
				}
			},
			computed: {
				publicBedTotalCount: function() {
					return this.sofeBedCount + this.sofeCount + this.blanketCount;
				},
				hostCommentCount: function() {
					return 500 - this.hostComment.length;
				},
				titleCount: function() {
					return 50 - this.title.length;
				}
			}
	});
	
	</script>
</body>
</html>