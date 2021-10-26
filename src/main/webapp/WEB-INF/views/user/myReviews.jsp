<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 후기 및 평점 목록</title>
<style>
.app {
	width: 1120px;
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
pre{
    overflow: auto;
    white-space: pre-wrap; /* pre tag내에 word wrap */
}  
.drawOutLine {
	border: solid 1px #d2d2d2;
}
.cursorPointer:hover {
	cursor: pointer;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div class="app" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div id="app" >
			<div class="drawOutLine">
				<a href="/user/show">회원정보</a> > My Reviews
			</div>
			<div class="horizontal">
				<div class="verticality">
					<div style="width: 170px; height: 170px;" class="drawOutLine">
						<c:choose>
							<c:when test="${ not empty userVo.filename }">
								<img src="/upload/${ userVo.uploadpath }/${ userVo.uuid }_${ userVo.filename }" width="150" height="150">
							</c:when>
							<c:otherwise>
								<span><i class="fas fa-user fa-10x"></i></span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="drawOutLine">
						<p>아이디 : ${ userVo.id }</p>
						<p>이름 : ${ userVo.name }</p>
					</div>
				</div>
				<div class="verticality" style="width: 882px;">
					<div>
						후기 목록 [후기 갯수: ${ mPageDto.count }]
					</div>
					<c:choose>
						<c:when test="${ mPageDto.count gt 0 }">
							<c:forEach var="review" items="${ reviewList }">
								<div class="drawOutLine cursorPointer" onclick="location.href='/content/info?num=${ review.hostVo.num }'">
									<div class="horizontal">
										<div>
											<div class="verticality drawOutLine">
												<img src="/upload/${ review.imagesVo.uploadpath }/${ review.imagesVo.uuid }_${ review.imagesVo.filename }" width="200" height="200">
												<p class="overflow">${ review.hostVo.address1 } ${ review.hostVo.address2 } </p>
												<p>${ review.hostVo.stayType }ㆍ후기(${ review.count })</p>	
												<p>호스트 : ${ review.hostVo.id }</p>
												<p>${ review.bookVo.checkIn } ~ ${ review.bookVo.checkOut }</p>
											</div>
										</div>
										<div>
											<span><b>작성일자 : <fmt:formatDate value="${ review.regDate }"
										pattern="yyyy-MM-dd" /></b></span><br>
											<hr>
											<span><b>만족도</b></span><br>
											<span style="color: #ff385c"><i class="fas fa-star"></i></span><span>${ review.score }</span>
											<hr>
											<span><b>후기</b></span><br>
											<div style="width: 570px;" class="drawOutLine"><pre>${ review.comment }</pre></div>
										</div>
									</div>
										<hr>
									<div class="text-center">
										<input type="hidden" value="${ review.num }">
										<input type="hidden" value="${ pageNum }">
										<button type="button" class="btn btn-dark" onclick="modifyReview(event)">수정하기</button>
										<button type="button" class="btn btn-dark" onclick="deleteReview(event)">삭제하기</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="text-center">후기 글 없음</div>
						</c:otherwise>
					</c:choose>
					<div class="text-center">
						<c:if test="${ mPageDto.count gt 0 }">
							<c:if test="${ mPageDto.startPage gt mPageDto.pageBlock }">
								<a href="/user/MyReviews?pageNum=${ mPageDto.startPage - mPageDto.pageBlock }">[이전]</a>
							</c:if>
							
							<c:forEach var="i" begin="${ mPageDto.startPage }" end="${ mPageDto.endPage }" step="1">
			
								<c:choose>
								
									<c:when test="${ pageNum eq i}">
										<a href="/user/MyReviews?pageNum=${ i }"><b>[${ i }]</b></a>
									</c:when>
									
									<c:otherwise>
										<a href="/user/MyReviews?pageNum=${ i }">[${ i }]</a>
									</c:otherwise>
								
								</c:choose>
						
							</c:forEach>
							
							<c:if test="${ mPageDto.endPage lt mPageDto.pageCount }">
								<a href="/user/MyReviews?pageNum=${ mPageDto.startPage + mPageDto.pageBlock }">[다음]</a>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
	</div>
	<script>
		function modifyReview(e) {
			let num = $(e.currentTarget).prev().prev().val();
			console.log(num);
			let isModify = confirm('수정하시겠습니까?');
			if(isModify) {
				location.href = '/review/modify?num=' + num + '&pageNum=${ pageNum }';
			}
		}
		function deleteReview(e) {
			let num = $(e.currentTarget).prev().prev().prev().val();
			console.log(num);
			let isDelete = confirm('정말 삭제하시겠습니까?');
			if(isDelete) {
				location.href = '/review/delete?num=' + num + '&pageNum=${ pageNum }';
			}
		}
	</script>	
</body>
</html>