<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가 및 후기</title>
<style>
.app {
	width: 860px;
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
	border: solid red 1px;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}

p {
	border: solid orange 1px;	
}

.overflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 200px;
	height: 22px;
}
pre{
    overflow: auto;
    white-space: pre-wrap; /* pre tag내에 word wrap */
}  
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app" id="app">
		<div><a href="/review/MyReviews?pageNum=${ pageNum }">돌아가기</a></div>
		<div>평가 및 후기</div>
		<hr>
		<div class="horizontal">
			<div>
				<img src="/upload/${ imagesVo.uploadpath }/${ imagesVo.uuid }_${ imagesVo.filename }" width="200" height="200">
				<p class="overflow">${ hostVo.address1 } ${ hostVo.address2 } </p>
				<p>${ hostVo.stayType }ㆍ후기(${ count })</p>	
				<p>호스트 : ${ hostVo.id }</p>
				<p>2021-01-27 ~ 2021-01-28</p>
			</div>
			
			<div>
				<span><b>만족도</b></span><br>
				<span style="color: #ff385c"><i class="fas fa-star"></i></span>{{ score }}
				<hr>				
				<span><b>후기</b></span><br>
				<div style="width: 570px;"><pre>${ reviewVo.comment }</pre></div>
				<hr>
				<button type="button" v-on:click="modifyReview">수정하기</button>
				<button type="button" v-on:click="deleteReview">삭제하기</button>
			</div>
		</div>
	</div>
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script>
	
		vue = new Vue({
			el: '#app',
			data: {
				comment: '',
				score: ${ reviewVo.score }
				 
			},
			methods: {
				modifyReview: function() {
					let isModify = confirm('수정하시겠습니까?');
					if(isModify) {
						location.href = '/review/modify?num=${ reviewVo.num }&pageNum=${ pageNum }';
					}
				},
				deleteReview: function() {
					let isDelete = confirm('정말 삭제하시겠습니까?');
					if(isDelete) {
						location.href = '/review/delete?num=${ reviewVo.num }&pageNum=${ pageNum }';
					}
				}
			}
		});
	
	</script>
</body>
</html>