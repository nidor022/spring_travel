<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 등록</title>
<style>
div {
	padding: 10px;
}
.inputOutLine {
	border:none;
	border-right:0px;
	border-top:0px;
	boder-left:0px;
	boder-bottom:0px;
}
hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}

.table {
	width:800px;
	padding:5px;
	margin:20px;
}
#wrap {
	width:1020px;
	margin:0;
	margin-right: auto;
	margin-left: auto;
}
.contentWriteForm {
	margin:50px;
	padding:20px;
}
.float_right {
	float: right;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div id="wrap" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />	
		<div>
			<h2>QnA 게시판</h2>
			<hr>
		</div>
		<form action="/customerCenter/qnaWrite" class="form2" method="post">
			<input type="hidden" name="pageNum" value="${ pageNum }">
			<div class="contentWriteForm">
				<div>
					<h2>QnA 등록</h2>
					<table class="table">
						<tr>
							<th class="write">작성자</th>
							<td>
								<input type="text" class="inputOutLine" name="id" value="${ id }" readonly>
							</td>
						</tr>
						<tr>
							<th class="write">유형</th>
							<td>
								<select name="type" required>
									<option value="" disabled selected>문의 유형을 선택해주세요</option>
									<option value="문의">문의</option>
									<option value="환불">환불</option>
									<option value="호스트">호스트</option>
									<option value="예약">예약</option>
									<option value="기타문의">기타문의</option>
								</select>
							</td>
						</tr>
						<tr>
							<th class="write">제목</th>
							<td>
								<input type="text" style="width: 98%" name="subject" v-model="title" required>
								<span style="position: relative; left: 640px; top: -30px;">{{ titleCount }}</span>
							</td>
						</tr>
						<tr>
							<th class="write">내용</th>
							<td>
								<textarea maxlength="500" rows="30" cols="40" style="resize: none; width: 98%; height: 200px;" name="content" v-model="content" required></textarea>
								<span style="position: relative; left: 630px; top: -35px;">{{ contentCount }}</span>
							</td>
						</tr>
					</table>
				</div>
				<div class="float_right">
					<input type="submit" value="글쓰기" class="btn">
					<input type="button" value="목록" class="btn" onclick="location.href = '/customerCenter/qnaList?pageNum=${ pageNum }'">
				</div>
			</div>
		</form>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script>
	new Vue({
		el:'#wrap',
		data: {
			title: '',
			content:''
		},
		methods: {
			
		},
		watch: {
			title: function() {
				if(this.title.length > 50)
					this.title = this.title.substr(0,50);
			},
			content: function() {
				if(this.content.length > 500)
					this.content = this.title.substr(0,500);
			}
		},
		computed: {
			titleCount: function() {
				return 50 - this.title.length;
			},
			contentCount: function() {
				return 500 - this.content.length;
			}
		}
	});
</script>


</body>
</html>


