<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가 및 후기 작성</title>
<style>
.app {
	width: 880px;
	display: block;
	margin: 0 auto;
	position: relative;
}

.verticality {
	display: inline-flex;
	flex-direction: column;
}

.horizontal {
	display: inline-flex;
	flex-direction: row;
}

div {
	padding: 10px;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}

.overflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 200px;
	height: 22px;
}

.blind {
	position: absolute;
	overflow: hidden;
	margin: -1px;
	padding: 0;
	width: 1px;
	height: 1px;
  	border: none;
  	clip: rect(0, 0, 0, 0);
}

.startRadio {
  	display: inline-block;
  	overflow: hidden;
	height: 40px;
}
.startRadio:after {
	content: "";
	display: block;
	position: relative;
	z-index: 10;
	height: 40px;
	background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFAAAABQCAYAAACOEfKtAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAACCBJREFUeNrsnHtwTFccx38pIpRQicooOjKkNBjrUX0ww0ijg4qpaCPTSjttPWYwU/X4o/XoH/7w7IMOQyg1SCco9d5EhTIebSSVoEQlxLQhoRIiJEF/33vOPrLdTe/u3pW7u/c3c/aeu3vuub/fZ3/nnN8999wb8piFDPFYnjIQGAANgAZAA6A+xXxZJD1LY70q9ohjg5kHRX5oZ6JGIYYHuiXrzxCduSHShjP69cAQPcaB92qIuq4k+uuO2G/fkqhgMlHzJoYHqpIlJ6zwzEjILz5heKAqKbkrvO9utbIbzwn6ZbQIFV4Y1cLwwHpl3hErvK2PP6MMTpnI4zv8ZjTheuRsKdG6320s7bniY22uKGMAdCGzfiaqfaRk17DnnbN8L/OrHz4WZQyATuRgEdHeS0r2CqcZTorMxG8ok1loAPxP0Dwj0xYCssdVOJaR332nkDwojjEAStmYR5R7XckeZ1DzXZXj375AGZT9Ps8AaA2aPz9s3V2n4pC1+JhzWBwb9AC/PEV0TTRYM3tY6v+V5zIAaMYxODaoAd6oJFp03MbSHe74wLHXK4MYIALjigdKdjt71n61x8my23Ds/CNBCvB8GVFqrtOgWa0ogw3qQF1BB3B23aA5393j5TFrUEdDBtcNAvAQh8q7CpTsNbD05uKFU/HuAlFnUAC0n2lGYMye9I+ndfGxtxF4I49AvCGC6ycOcBM3vOy/lewpBjDX2/pkHSdPl4i6Axrg/VoOmrPqBsQaiRKAo26c40mKzyZU0bn/cZMohz0D3oHLL6Tb95WfM9lzXtfUkAWUwZu41mFEvduJ1CeKyMSpWwRRYx+5iiZ35XBJlXdDgMq5LqDll7r0BkwbTPaBLahzJf9BcVk8oGTZDSphbGWPtgKmSYLt+aw291jc9sBbVQKSAkt61kX2tIfOa0GvlMPpNCdEfbmy4/ddk1pArXnTW6Y+nEycejiWw23SmAjhqQDbR8Jt00xDgFf5ejOXIWVbmmCJ+M6FnJSgcmTKZ1j39TBjwlDDJESTTAA7wFnZTuEMNUqA7Rsl8vhOFcAfLxAdKxaw4GXwNmdOaOdVOdKzLjKsh+RHwlAb8SZGeqrJzlvbOJaFV5pkvzqwI9HoF1wARHCbuI2o2obiqgSUbdcEr1IAC4PtZNcF9JVbfEehjHzrGKI3u9bThLecJXpvp7VPW8XAJlMQCwNdyZtJ6DM3JhCNi1XRB67mhjlpr7ghyzKaIe4MUniMjHZgWc6q4UQTTCoDaRRcNNS6u4MrGhyE8GDzDuTBwhm8eq9EZrzMkf1A2/U/V2gKIngYUA4pVzcDBQuP48BpZqLlvypZjMl9uTmfD3B43eWg2Wxaf6Kv4728FkYF7/dSsggxs/gEMQEMD7bhar0ZbP4qXoPJBHSgqSOJxnRTdvkCiPbxiaIDEB5s2gcbYStsVrOmU9UlNobwzaOJhgls0XJg6RhA8DrKASMaNsJWtStiVc9RIIjcnigicZaenNL5xO0CAB5sSIdNsA02wla14tYkD2Yvdr8jLrzltWSavHj3V3jQPQ22wCbY5u4MjduzZK2aEu0fR9Q9UtkdLCGG+SE86LwFNsAW2ATb3BWPphnbNicy8wmjhe8N4/SDHzogPO+Nzq2FLbDJE/F4nrZDONGBZKLnWiq7o/gfTfcj74OuCVi8bk4WtngqXk10d3mGx/0k67+XyIpt8gN40DEROu9PEjZ4I17fKcDUODpf2X8ks4LrdQwPuiVDV+gM3b0VTW61vNSeg6ix1hEshRVN1SE86JQCHaErdNakXi3vyu25RPTWVuuEbFO+bq7WCbxQ3jywxLIjumhXt6Y3+6CYKcq6q6fZG0UX6KYlPM0BQq6U27I6AnjFQTd9AqyqFU8aIcvNt0Qv9KQuVdCtqlbHAItsd3yLdDgIFznoqEOA5X4AsNzwQMMDDQ80PNDwQF0CLLT9u4U6BFjooKO+AFbWEJXeE1mOu0r1Rk/qVAkdK2t0CFDn/Z/P+kHN3hujdf8XskBZGWVZG3GUPShbI4Cx0DW2rd4AauSBDC6ON1M4JTh8jwVOK+Q7FAwPdAJuLG8+JHGPhZ5uQvSRnM9JzVH6LQBN4HIHeLuWQaZ7DLA8gAAykAm8SeI0BPuRzdn9+okUIdcrz+GGvOI3kcruKYCH8XFY/JPGIFcHBEB3QxgGgEe8RnAahP3nWxFNH8Au2Ft4n70A5LxBYpUU3tyx7KQyNQXgQ7ied3m7h0EubIhQRrMZ6chlRDfFmupINuamC2i4hQNww0msblAeP5j1CrtgLFETlTFBzSN2vbPieeF8W8CElwBgbctCPv8tF+eP4E0Z/pCy6ToCeKeaKHyxyLLy4U4Ux3oaPBg40fIdllHMZnAjuqpbxOM0toPrFTAxBnm0uM5PaNaLWJc/neiC5wxaVszkj1CdxIGuRmBWtp+8jQhDJgIUFmgfTSH6ZTzRSC/gKfWTqAN1HeM6R8VY60O/eonPvRk6+HIk1gagwwDCSr8uww4szUxG0xzPDTaPzfrpbaLXOmgfIb/Kde7kcTyffTyll7U7GAcdoAt08sVAokkT/pZHxykHRJYTHgKIt4QiH3Mo8smA+h9W8YUUV4jBZk1OnUs3vA3uAqep37CGU/vrBCCe/11i93o6hCJTZSji7qNTWgseFkL4s1yEQFbBiL80TidhjKU5IBT5VIYienlZIv7AuXYh0FIRAmkWymjigR/sEu85TXrRd4+VaiV4DDftHFHGZaINo3QUBwarGO+RNgAaAA2AwSz/CjAAQpkGTQKEVKkAAAAASUVORK5CYII=") repeat-x 0 0;
	background-size: contain;
	pointer-events: none;
}
.startRadio__box {
  	position: relative;
  	z-index: 1;
  	float: left;
  	width: 20px;
  	height: 40px;
  	cursor: pointer;
}

.startRadio__box input {
  	opacity: 0 !important;
  	height: 0 !important;
  	width: 0 !important;
  	position: absolute !important;
}
.startRadio__box input:checked + .startRadio__img {
/*   background-color: #0084ff; */
	background-color: #ff385c;
}
.startRadio__img {
  display: block;
  position: absolute;
  right: 0;
  width: 500px;
  height: 40px;
  pointer-events: none;
}
.drawOutLine {
	border: solid 1px #d2d2d2;
}
</style>
</head>
<body>
	<div class="app">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div id="app">
			<div>
				<a href="/travel/history">
					<span style="color: #d2d2d2;">
						<i class="fas fa-angle-left fa-lg"></i>
					</span>
				</a>
			</div>
			<div class="drawOutLine text-center"><h4><b>평가 및 후기 작성</b></h4></div>
			<hr>
			<div class="horizontal">
				<div class="verticality">
					<div class="text-center">
						<img src="/upload/${ imagesVo.uploadpath }/${ imagesVo.uuid }_${ imagesVo.filename }" width="200" height="200">
					</div>
					<div class="drawOutLine">
						<p class="overflow">${ hostVo.address1 } ${ hostVo.address2 } </p>
						<p>${ hostVo.stayType }ㆍ후기(${ count })</p>	
						<p>호스트 : ${ hostVo.id }</p>
						<p>2021-01-27 ~ 2021-01-28</p>
					</div>
				</div>
				
				<div>
					<h3>${ hostVo.id }에 대한 후기를 쓰세요.</h3>
					<h4>숙박이 어땟나요?</h4>
					<hr>
					<span><b>만족도</b></span><br>
					<div class="startRadio" style="padding: 0px;">
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">0.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">1</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">1.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">2</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">2.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">3</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">3.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">4</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">4.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="score" v-on:change="setScore($event)">
							<span class="startRadio__img"><span class="blind">5</span></span>
						</label>
					</div>
					<hr>				
					<span><b>후기</b></span><br>
					<span>회원님의 후기는 회원님의 프로필과 회원님의 호스트 숙소 페이지에서 전체 공개됩니다.</span>
					<textarea v-model="comment" name="comment" maxlength="500" style="resize: none; width: 570px; height: 120px;"></textarea>
					<span style="position: relative; left: 530px; top: -40px;">{{ commentCount }}</span>
					<hr>
					<div class="text-center">
						<button class="btn btn-dark" type="button" v-on:click="apply">등록하기</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script src="/script/jquery-3.5.1.js"></script>
	<script>
	 	
		new Vue({
			el: '#app',
			data: {
				comment: '',
				score: 0
				 
			},
			methods: {
				apply: function() {
					let isApply = confirm('등록하시겠습니까?');
					if(isApply) {
						$.ajax({
							url: '/review/write',
							method: 'post',
							data: { 
								noNum: ${ hostVo.num },
								bookNum: ${ bookNum },
								comment: this.comment, 
								score: this.score 
							},
							success: function(res) {
								if(res > 0) {
									location.href = '/user/MyReviews';
								}
							}
						});
					}
				},
				setScore: function(event) {
					let score = event.currentTarget.parentNode.querySelector('.blind').innerHTML;
					this.score = score;
				}
			},
			watch: {
				comment: function() {
					if(this.comment.length> 500) {
						this.comment = this.comment.subStr(0,500);
					}
				}
			},
			computed: {
				commentCount: function() {
					return 500 - this.comment.length;
				}
			}
		});
	
	</script>
</body>
</html>