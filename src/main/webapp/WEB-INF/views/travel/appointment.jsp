<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 내역</title>
<style>
.app {
	width: 900px;
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
.overflow {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 260px;
	height: 22px;
}

.container {
	display: grid;
	grid-template-columns: 280px 280px 280px;
}

.drawOutLine {
	border: solid 1px #d2d2d2;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div class="app" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div>
			<b><a href="/user/show">회원정보</a></b> > <b>여행 내역</b>
		</div>
		<hr>
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<c:choose>
					<c:when test="${ viewType eq 'pay' }">
						<a class="nav-link active" data-toggle="tab" href="#pay">결제한 숙박지</a>	
					</c:when>
					<c:otherwise>
						<a class="nav-link" data-toggle="tab" href="#pay">결제한 숙박지</a>	
					</c:otherwise>
				</c:choose>
			</li>
			<li class="nav-item">
				<c:choose>
					<c:when test="${ viewType eq 'save' }">
						<a class="nav-link active" data-toggle="tab" href="#save">저장한 숙박지</a>	
					</c:when>
					<c:otherwise>
						<a class="nav-link" data-toggle="tab" href="#save">저장한 숙박지</a>
					</c:otherwise>
				</c:choose>
		    	
			</li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane fade show active" id="pay">
				<c:choose>
					<c:when test="${ not empty bookList }">
						<c:forEach var="book" items="${ bookList }">
							<div class="drawOutLine">
								<div class="horizontal" style="width: 100%;">
									<div style="width: 60%;">
										<div class="text-center">
											<img src="/upload/${ book.hostVo.imageVo.uploadpath }/${ book.hostVo.imageVo.uuid }_${ book.hostVo.imageVo.filename }" width="200" height="200">
										</div>
										<p>숙박일정 : ${ book.checkIn } ~ ${ book.checkOut }</p>
										<p>금액 : <fmt:formatNumber value="${ book.cost }" pattern="#,###,###"/>원</p>
										<p>위치 : (${book.hostVo.postcode}) ${ book.hostVo.address1 } ${ book.hostVo.address2 }</p>
										<p>결제일자 : <fmt:formatDate value="${ book.regDate }" pattern="yyyy-MM-dd a hh:mm:ss" /></p>
									</div>
									<div class="drawOutLine" style="width: 100%;">
										<p>제목 : ${ book.hostVo.title }</p>
										<p>${ book.hostVo.hostComment }</p>
									</div>
								</div>
								<hr>
								<div class="text-center">
									<button type="button" class="btn" data-num="${ book.hostVo.num }" data-book-num="${ book.num }" onclick="writeReivew(event)">후기 작성하기</button>
									<button type="button" class="btn" data-num="${ book.num }" onclick="deleteBook(event)">취소하기</button>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="text-center">결제하신 숙박지가 없습니다.</div>	
					</c:otherwise>
				</c:choose>
			</div>
			<div class="tab-pane show fade" id="save">
				<c:choose>
					<c:when test="${ not empty hostList }">
						<div class="container">
							<c:forEach var="host" items="${ hostList }">
								<div class="item drawOutLine">
									<p class="overflow"><a href="/content/info?num=${ host.num }">${ host.title }</a></p>
									<a href="/content/info?num=${ host.num }">
										<img src="/upload/${ host.imageVo.uploadpath }/${ host.imageVo.uuid }_${ host.imageVo.filename }" width="250" height="250">
									</a>
									<p class="text-center">평점 <span style="color: #ff385c"><i class="fas fa-star"></i></span>${ host.score } /후기(${ host.reviewCount })</p>
									<p class="overflow">${ host.hostComment }</p>
									<div class="text-center">
										<input type="hidden" value="${ host.saveVo.hostNum }">
										<button type="button" class="btn btn-dark" onclick="saveDelete(event)">삭제하기</button>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<div class="text-center">저장한 숙박지가 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
<script>

	let type = '${ viewType }';
	if(type == 'pay') {
		$('#pay').addClass('active');
		$('#save').removeClass('active');
	} else {
		$('#save').addClass('active');
		$('#pay').removeClass('active');
		}

	function saveDelete(e) {
		let num = $(e.currentTarget).prev().val();
		let removeTag = $(e.currentTarget).parent().parent();
		let appendTag = removeTag.parent().parent();
		
		let isDelete = confirm('정말 삭제하시겠습니까?');
		if(isDelete) {
			$.ajax({
				url: '/travel/saveDelete',
				data: { num: num },
				success: function(res) {
					if(res.deleteNum == 1) {
						if(res.saveCount == 0) {
							let str =`
								<div class="text-center">저장한 숙박지가 없습니다.</div>
							`;
							appendTag.append(str);
							removeTag.parent().remove();
							alert('삭제되었습니다.');
							return;
						}
						removeTag.remove();
						alert('삭제되었습니다.');
					}
				}
			});
		}
	}
	
	function deleteBook(event) {
		let num = event.currentTarget.dataset.num;
		let removeTag = $(event.currentTarget).parent().parent();
		let appendTag = removeTag.parent().parent();
		
		let isDelete = confirm('정말 취소하시겠습니까?');
		if(isDelete) {
			$.ajax({
				url: '/travel/cancel',
				data: { num: num },
				method: 'post',
				success: function(res) {
					if(res.isSuccess) {
						removeTag.remove();
						alert('취소되었습니다.');
					}
				}
			});
		}
	}

	function writeReivew(event) {
		let num = event.currentTarget.dataset.num;
		let bookNum = event.currentTarget.dataset.bookNum;
		console.log(bookNum);
		let isWrite = confirm('후기를 작성하시겠습니까?');
		if(isWrite) {
			location.href = '/review/write?num=' + num + '&bookNum=' + bookNum;
		}
	}
</script>
</body>
</html>