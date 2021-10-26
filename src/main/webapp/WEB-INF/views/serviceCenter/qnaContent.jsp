<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시물</title>

<!-- <link href="/css/hwh.css" rel="stylesheet" type="text/css"  media="all"> -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>

.qnaContent {
	margin:50px;
	padding:20px;
}
.float_right {
	float: right;
}
#wrap {
	width:1020px;
	margin:0;
	margin-right: auto;
	margin-left: auto;
}

</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div>
			<h2>QnA 게시판</h2>
		</div>
		<hr>
		<div class="qnaContent">
			<span class="float_right">
				작성일자 : <fmt:formatDate value="${ qnaVo.regDate }" pattern="yyyy-MM-dd" />
			</span>
			<table class="table">
				<tr>
					<th align="center">작성자</th>
					<td>${ qnaVo.id }</td>
				</tr>
				<tr>
					<th>유형</th>
					<td>${ qnaVo.type }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${ qnaVo.subject }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td style="background-color: #f8f8f8;">${ qnaVo.content }</td>
				</tr>
			</table>
			<div class="float_right">
				<input type=button value="글수정" class="btn" onclick="location.href = '/customerCenter/qnaModify?num=${ qnaVo.num }&pageNum=${ pageNum }'">
				<input type=button value="글삭제" class="btn" onclick="remove()">
				<input type=button value="글목록" class="btn" onclick="location.href = '/customerCenter/qnaList?pageNum=${ pageNum }'">
			</div>
			
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />	
	</div>
	<script>
		function remove() {
			var result = confirm('해당 글을 정말 삭제하시겠습니까?');
			console.log(typeof result);
			
			if (result == false) {
				return;
			}
			
			location.href = '/customerCenter/qnaDelete?num=${ qnaVo.num }&pageNum=${ pageNum }';
		} // remove
	</script>

</body>
</html>


