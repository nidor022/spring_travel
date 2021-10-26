<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 게시글 목록</title>
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
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div class="app" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div  id="app">
			<div class="drawOutLine">
				<a href="/user/show">회원정보</a> > My Hosts
			</div>
			<div class="horizontal">
				<div>
					<div class="drawOutLine" style="width: 170px; height: 170px;">
						<c:choose>
							<c:when test="${ not empty userVo.filename }">
								<img src="/upload/${ userVo.uploadpath }/${ userVo.uuid }_${ userVo.filename }" width="150" height="150">
							</c:when>
							<c:otherwise>
								<span><i class="fas fa-user fa-10x"></i></span>
							</c:otherwise>
						</c:choose>
					</div>
					<br>
					<div class="drawOutLine">
						<p>아이디 : ${ userVo.id }</p>
						<p>이름 : ${ userVo.name }</p>
					</div>
				</div>
				<div class="verticality drawOutLine" style="width: 882px;">
					<div>
						게시글 목록 [게시글 갯수: ${ mPageDto.count }]
					</div>
					<c:choose>
						<c:when test="${ mPageDto.count gt 0 }">
							<c:forEach var="host" items="${ hostList }">
								<div class="drawOutLine">
									<div class="horizontal" onclick="location.href='/content/info?num=${ host.num }'">
										<div>
											<img src="/upload/${ host.imageVo.uploadpath }/${ host.imageVo.uuid }_${ host.imageVo.filename }" width="200" height="200">
											<p class="overflow">${ host.address1 } ${ host.address2 } </p>
											<p>${ host.stayType }ㆍ후기(${ host.reviewCount })</p>	
										</div>
										<div>
											<span><b>작성일자 : <fmt:formatDate value="${ host.regDate }" pattern="yyyy-MM-dd" /></b></span><br>
											<hr>
											<span><b>제목</b></span><br>
											<div style="width: 570px;"><pre>${ host.title }</pre></div>
											<hr>
											<span><b>소개글</b></span><br>
											<div style="width: 570px;"><pre>${ host.hostComment }</pre></div>
										</div>
									</div>
									<div class="text-center">
										<button type="button" class="btn btn-dark" v-on:click="showContent">게시물 보러가기</button>
										<input type="hidden" value="${ host.num }">
										<input type="hidden" value="${ pageNum }">
										<button type="button" class="btn btn-dark" v-on:click="modifyHost($event)">수정하기</button>
										<button type="button" class="btn btn-dark" v-on:click="deleteHost($event)">삭제하기</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="text-center drawOutLine">게시글 없음</div>
						</c:otherwise>
					</c:choose>
					<div class="text-center">
						<c:if test="${ mPageDto.count gt 0 }">
							<c:if test="${ mPageDto.startPage gt mPageDto.pageBlock }">
								<a href="/user/MyHosts?pageNum=${ mPageDto.startPage - mPageDto.pageBlock }">[이전]</a>
							</c:if>
							
							<c:forEach var="i" begin="${ mPageDto.startPage }" end="${ mPageDto.endPage }" step="1">
			
								<c:choose>
								
									<c:when test="${ pageNum eq i}">
										<a href="/user/MyHosts?pageNum=${ i }"><b>[${ i }]</b></a>
									</c:when>
									
									<c:otherwise>
										<a href="/user/MyHosts?pageNum=${ i }">[${ i }]</a>
									</c:otherwise>
								
								</c:choose>
						
							</c:forEach>
							
							<c:if test="${ mPageDto.endPage lt mPageDto.pageCount }">
								<a href="/user/MyHosts?pageNum=${ mPageDto.startPage + mPageDto.pageBlock }">[다음]</a>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script>
	 	
		vue = new Vue({
			el: '#app',
			data: {
				 
			},
			methods: {
				modifyHost: function(e) {
					let num = $(e.currentTarget).prev().prev().val();
					console.log(num);
					let isModify = confirm('수정하시겠습니까?');
					if(isModify) {
						location.href = '/content/modify?num=' + num + '&pageNum=${ pageNum }';
					}
				},
				deleteHost: function(e) {
					let num = $(e.currentTarget).prev().prev().prev().val();
					console.log(num);
					let isDelete = confirm('정말 삭제하시겠습니까?');
					if(isDelete) {
						location.href = '/content/delete?num=' + num + '&pageNum=${ pageNum }';
					}
				},
				showContent: function(e) {
					let num = $(e.currentTarget).next().val();
					console.log(num);
					let isMove = confirm('게시물로 이동하겠습니까?');
					if(isMove) {
						location.href = '/content/info?num=' + num;
					}
				}
			}
		});
	
	</script>	
</body>
</html>