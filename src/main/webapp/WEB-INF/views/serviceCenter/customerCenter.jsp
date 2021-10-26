<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<style>
.faqContainer {
	display: grid;
/* 	margin:50px 50px 10px 50px; */
	grid-template-columns: 292px 292px 292px;
	grid-template-rows: 220px 220px 220px;
}
.faqTitle {
	width:272px;
	height:45px;
	display:block;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
.faqInfo {
	width:272px;
	height:130px;
	display:block;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}

.float_right {
	float: right;
}
.writePosition {
	float: right;
/* 	margin-right:50px; */
}
#wrap {
	width:1020px;
	margin:0;
	margin-right: auto;
	margin-left: auto;
	min-height:780px;
}
.pageBox {
	text-align: center;
	margin-top: 40px;
}

hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}
.content {
	border: solid 1px #d2d2d2;
}
.drawOutLine {
	border: solid 1px #d2d2d2;
}
</style>
</head>
<body style="background-color: #f2f2f2;">
	<div id="wrap" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div>
			<h2>고객센터</h2>
		</div>
		<hr>
		<div class="container">
			<div class="row">
				<div class="col">
					<ul class="nav nav-tabs">
						<li class="nav-item">
							<c:choose>
								<c:when test="${ viewType eq 'faq' }">
									<a class="nav-link active" data-toggle="tab" href="#faq" onclick="location.href = '/customerCenter/faqList'">FAQ</a>	
								</c:when>
								<c:otherwise>
									<a class="nav-link" data-toggle="tab" href="#faq" onclick="location.href = '/customerCenter/faqList'">FAQ</a>
								</c:otherwise>
							</c:choose>
						</li>
						<li class="nav-item">
							<c:choose>
								<c:when test="${ viewType eq 'qna' }">
									<a class="nav-link active" data-toggle="tab" href="#qna" onclick="location.href = '/customerCenter/qnaList'">QnA</a>	
								</c:when>
								<c:otherwise>
									<a class="nav-link" data-toggle="tab" href="#qna" onclick="location.href = '/customerCenter/qnaList'">QnA</a>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane fade show active" id="faq">
							<div class="faqContainer">
								<c:choose>
									<c:when test="${ not empty fContentList }">
										<c:forEach var="content" items="${ fContentList }">
											<div class="content">
											<span class="float_right">
												조회수:${ content.readcount }
											</span>
											<div class="faqTitle">
												
											<h4><a href ="/customerCenter/faqContent?num=${ content.num }&pageNum=${ fPageNum }">
												${ content.subject }</a></h4><hr>
											</div>
											<div class="faqInfo">
												${ content.content }
											</div>
										</div>
										</c:forEach>
									</c:when>		
									<c:otherwise>
										<div>게시판 글 없음</div>
									</c:otherwise>
								</c:choose>
							</div>
							<c:if test="${ id eq 'admin' }">
								<div class="writePosition">
									<input type="button" value="글쓰기" class="btn" onclick="location.href='/customerCenter/faqWrite?pageNum=${ fPageNum }'">
								</div>
							</c:if>
							<br>
							<div class="pageBox drawOutLine">
								<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
								<c:if test="${ fPageDto.count gt 0 }">
									<%-- [이전] --%>
									<c:if test="${ fPageDto.startPage gt fPageDto.pageBlock }">
										<a href="/customerCenter/faqList?pageNum=${ fPageDto.startPage - fPageDto.pageBlock }">[이전]</a>
									</c:if>
									
									<%-- 시작페이지 ~ 끝페이지 --%>
									<c:forEach var="i" begin="${ fPageDto.startPage }" end="${ fPageDto.endPage }" step="1">
										
										<c:choose>
										<c:when test="${ i eq fPageNum }">
											<a href="/customerCenter/faqList?pageNum=${ i }" class="active">[${ i }]</a>
										</c:when>
										<c:otherwise>
											<a href="/customerCenter/faqList?pageNum=${ i }">[${ i }]</a>
										</c:otherwise>
										</c:choose>
										
									</c:forEach>
									
									<%-- [다음] --%>
									<c:if test="${ fPageDto.endPage lt fPageDto.pageCount }">
										<a href="/customerCenter/faqList?pageNum=${ fPageDto.startPage + fPageDto.pageBlock }">[다음]</a>
									</c:if>
								</c:if>
							</div>	
						</div>
						<c:if test="${ viewType eq 'qna' }">
							<div class="tab-pane fade show active" id="qna">
								<table class="table table-striped text-center">
									<thead>
									<tr>
										<th>번호</th>
										<th>현황</th>
										<th>유형</th>
										<th>제목</th>
										<th>글쓴이</th>
										<th>작성일자</th>
									</tr>
									</thead>
									<tbody id="qnaContentBox">
										<c:choose>
											<c:when test="${ not empty qContentList }">
												<c:forEach var="content" items="${ qContentList }">
													<tr onclick="showQnaContent(event)">
														<td class="num">${ content.num }</td>
														<td class="status">${ content.status }</td>
														<td class="type">${ content.type }</td>
														<td>${ content.subject }</td>
														<td>${ content.id }</td>
														<td><fmt:formatDate value="${ content.regDate }" pattern="yyyy-MM-dd" /></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="6" class="text-center">등록된 글이 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<c:if test="${ not empty id }">
									<div class="float_right">
										<button type="button" class="btn" onclick="location.href='/customerCenter/qnaWrite?pageNum=${ qPageNum }'">글쓰기</button>
									</div>
								</c:if>
								<br>
								<br>
								<div class="pageBox drawOutLine">
									<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
									<c:if test="${ qPageDto.count gt 0 }">
										<%-- [이전] --%>
										<c:if test="${ qPageDto.startPage gt qPageDto.pageBlock }">
											<a href="/customerCenter/qnaList?pageNum=${ qPageDto.startPage - qPageDto.pageBlock }">[이전]</a>
										</c:if>
										
										<%-- 시작페이지 ~ 끝페이지 --%>
										<c:forEach var="i" begin="${ qPageDto.startPage }" end="${ qPageDto.endPage }" step="1">
											
											<c:choose>
												<c:when test="${ i eq qPageNum }">
													<a href="/customerCenter/qnaList?pageNum=${ i }" class="active">[${ i }]</a>
												</c:when>
												<c:otherwise>
													<a href="/customerCenter/qnaList?pageNum=${ i }">[${ i }]</a>
												</c:otherwise>
											</c:choose>
											
										</c:forEach>
										
										<%-- [다음] --%>
										<c:if test="${ qPageDto.endPage lt qPageDto.pageCount }">
											<a href="/customerCenter/qnaList?pageNum=${ qPageDto.startPage + qPageDto.pageBlock }">[다음]</a>
										</c:if>
									</c:if>
								</div>	
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<div id="qnaAnswer" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog"> 
				<div class="modal-content"> 
				</div> 
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />	
	</div>

<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> -->
<script>

	function addReply(num) {
		console.log(num);
		$(".modal-content").load('/customerCenter/qnaReply?num='+ num +'&pageNum=${ qPageNum }&form=write');
	}

	function modifyReply(refNum, replyNum) {
		console.log(refNum);
		console.log(replyNum);
		$(".modal-content").load('/customerCenter/qnaReplyModify?refNum='+ refNum +'&replyNum='+ replyNum +'&pageNum=${ qPageNum }&form=modify');
	}

	let type = '${ viewType }';
	if(type == 'faq') {
		$('#faq').addClass('active');
		$('#qna').removeClass('active');
	} else {
		$('#qna').addClass('active');
		$('#faq').removeClass('active');
	}

	var dupCheck = 0;
	function showQnaContent(event) {
		let tag = $(event.currentTarget);
		let num = tag.children('.num').text();

		$('.qnaContentInfo').remove();
		if(dupCheck == num) {
			dupCheck = 0;
			return;
		}
		$.ajax({
			url: '/customerCenter/qna/' + num,
			success:function(res) {
				dupCheck = res.qnaVo.num;
				let str = `
						<tr class="\${ num } text-left qnaContentInfo">
							<td colspan="6">
								<div>\${ res.qnaVo.content }</div>
								<div class="text-center">
									<input type="hidden" name="num" value="\${res.qnaVo.num}">
					`;
				if(res.qnaVo.status == '답변대기') {
					if('${ id }' == 'admin') {
						str +=`
									<button  class="btn btn-dark" data-toggle="modal" data-target="#qnaAnswer" role="button" onclick="addReply(\${res.qnaVo.num})">답글쓰기</button>
						`;
					}
					else if(res.qnaVo.id == '${ id }') {
						str +=`
									<button type="button" class="btn btn-dark" onclick="location.href='/customerCenter/qnaModify?pageNum=${ qPageNum }&num=\${res.qnaVo.num}'">수정하기</button>
									<button type="button" class="btn btn-dark" onclick="location.href='/customerCenter/qnaDelete?pageNum=${ qPageNum }&num=\${res.qnaVo.num}'">삭제하기</button>
						`;
					}
				}
				str +=`			
								</div>
				`;
				if(res.qnaVo.status == '답변완료') {
					console.log('res.reply.num : ' + res.reply.num);
					console.log('res.reply.reRef : ' + res.reply.reRef);
					str +=`
								
								<div class="text-left">
									<hr>
									\${res.reply.content}
								</div>
								<div class="text-center">
									<input type="hidden" name="replyNum" value="\${ res.reply.num }">
									<input type="hidden" name="refNum" value="\${ res.reply.reRef }">
					`;
					if('${ id }' == 'admin') {	
						str +=`
									<button  class="btn btn-dark" data-toggle="modal" data-target="#qnaAnswer" role="button" onclick="modifyReply(\${ res.reply.reRef }, \${ res.reply.num })">수정하기</button>
									<button type="button" class="btn btn-dark" onclick="qnaReplyDeleteBtn(event)">삭제하기</button>
								
						`;
					}
				}
					
				str +=`			
								</div>
							</td>
						</tr>
				`;
				tag.after(str);

			}
		});
	}
	function qnaReplyDeleteBtn(event) {
		let replyNum = $(event.currentTarget).prev().prev().prev('input[name=replyNum]').val();
		let refNum = $(event.currentTarget).prev().prev('input[name=refNum]').val();
		let removeContentTag = $(event.currentTarget).parent().prev();
		let removeBtnTag = $(event.currentTarget).parent();
		let changeTag = $(event.currentTarget).parent().parent().parent().prev().children('.status');
		let isDelete = confirm('정말 삭제하시겠습니까?');
		if(isDelete) {
			$.ajax({
				url: '/customerCenter/qnaReplyDelete',
				data: { num: replyNum, reRef: refNum },
				method: 'post',
				success: function(res) {
					if(res.isSuccess) {
						removeContentTag.remove();
						removeBtnTag.empty();
						changeTag.html('답변대기');

						let str =`
							<button  class="btn btn-dark" data-toggle="modal" data-target="#qnaAnswer" role="button" onclick="addReply(\${refNum})">답글쓰기</button>
						`;
						removeBtnTag.prepend(str);
						alert('삭제되었습니다.');
					} else {
						alert('다시 시도해주세요.');
					}
				}
			});
		}
	}
	
	function updateQnaList() {
		location.href = '/customerCenter/qnaList?pageNum=${ qPageNum }';

// 		$.ajax({
// 			url:'/customerCenter/qnaList',
// 			data: { pageNum: '${ qPageNum }' },
// 			method: 'post',
// 			success: function(res) {
// 				$('#qnaContentBox').empty();
// 				let str;
// 				if(res.qContentList != null) {
// 					for (let content in res.qContentList) { 
// 						let cDate = res.qContentList[content].regDate;
// 						res.qContentList[content].regDate = getFormatDate(new Date(cDate));
// 						str +=`
// 							<tr onclick="showQnaContent(event)">
// 								<td class="num">\${ res.qContentList[content].num }</td>
// 								<td class="status">\${ res.qContentList[content].status }</td>
// 								<td class="type">\${ res.qContentList[content].type }</td>
// 								<td>\${ res.qContentList[content].subject }</td>
// 								<td>\${ res.qContentList[content].id }</td>
// 								<td>\${ res.qContentList[content].regDate }</td>
// 							</tr>
// 						`;
// 					}

// 				}else {
// 					str = `
// 						<tr>
// 							<td colspan="6" class="text-center">등록된 글이 없습니다.</td>
// 						</tr>
// 					`;
// 				}
// 				$('#qnaContentBox').prepend(str);
// 			}
// 		});
	}

	function getFormatDate(date) {
		let year = date.getFullYear();
		let month = (1 + date.getMonth());
		month = month >= 10 ? month : '0' + month;
		let day = date.getDate();
		day = day >= 10 ? day: '0' + day;
		return year+'-'+month+'-'+day;
	}
</script>
</body>
</html>


