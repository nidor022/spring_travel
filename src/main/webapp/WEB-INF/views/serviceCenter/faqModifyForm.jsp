<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 수정</title>
<style>
div {
	padding: 10px;
}
.faqContent {
	margin:50px;
	padding:20px;
}
#wrap {
	width:1020px;
	margin:0;
	margin-right: auto;
	margin-left: auto;
}
.float_right {
	float: right;
}
.modifyTable {
	width:800px;
	padding:5px;
	margin:20px;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div id="wrap" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div>
			<h2>자주 하는 질문</h2>
			<hr>
		</div>
		<form action="/customerCenter/faqModify" method="post">
			<input type="hidden" name="pageNum" value="${ pageNum }">
			<input type="hidden" name="num" value="${ faqVo.num }">
			<div class="faqContent">
				<div>
					<h2>FAQ 수정</h2>
					<table class="modifyTable table">
					<tr>
						<th>작성자</th>
						<td>
							<input type="text" name="id" value="관리자" readonly>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" style="width: 98%" name="subject" v-model="title" required>
							<span style="position: relative; left: 640px; top: -30px;">{{ titleCount }}</span>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea maxlength="500" rows="30" cols="40" style="resize: none; width: 98%; height: 200px;" name="content" v-model="content" required></textarea>
							<span style="position: relative; left: 630px; top: -35px;">{{ contentCount }}</span>
						</td>
					</tr>
					</table>	
				</div>
				<div class="float_right">
					<input type="submit" value="글수정" class="btn">
					<input type="button" value="글목록" class="btn" onclick="location.href = '/customerCenter/faqList?pageNum=${ pageNum }'">
				</div>
			</div>
		</form>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
<script>
	vue = new Vue({
		el:'#wrap',
		data: {
			title: '${ faqVo.subject }',
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
	// content 설정
	let content = '${ faqVo.content }';
	content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	vue.content = content;
</script>
</body>
</html>


