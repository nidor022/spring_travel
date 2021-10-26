<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal-content">
	<div class="modal-header">
		<h2 class="text-center">QnA 답변</h2> <button type="button" class="close" data-dismiss="modal">×</button> 
	</div> 
	<div class="modal-body"> 
		<div>
			<table>
				<tr>
					<td>문의 유형</td>
					<td>
						<div>${ qnaVo.type }</div>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>
						<div>${ qnaVo.id }</div>
					</td>
				</tr>
				
				<tr>
					<td>제목</td>
					<td>
						<div>${ qnaVo.subject }</div>
					</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>
						<div>${ qnaVo.content }</div>
					</td>
				</tr>
			</table>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div>
			<p><b>답변 안내</b></p>
			<table>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" id="qnaContent" maxlength="500" placeholder="내용 입력" style="resize: none; width: 300px; height: 120px;" onkeyup="tst(this);"></textarea>				
					</td>
				</tr>
			</table>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div style="text-align: center;">
			<c:choose>
				<c:when test="${ form eq 'write' }">
					<input type="button" class="btn btn-dark" id="write" value="작성하기" onclick="writeEvent()">				
				</c:when>
				<c:otherwise>
					<input type="button" class="btn btn-dark" id="modify" value="수정하기" onclick="modifyEvent()">
				</c:otherwise>
			</c:choose>
			<input type="hidden" id="qnaNumModal" value="${ qnaVo.num }">
			<input type="hidden" id="replyNumModal" value="${ replyNum }">
			<input type="hidden" id="formModal" value="${ form }">
		</div>
	 </div> 
 </div>
<script>
	let inputText;
	function tst(obj) {
		inputText = obj.value;
	}

	console.log($('#formModal').val());
	$(function() {
		let form = $('#formModal').val();
		console.log(form);
		if(form == 'modify') {
			let content = '${ reply.content }';
			console.log(content);
			content = content.replace(/<br>/gi,'\n');
			$('textarea[name="content"]').val(content);
			inputText = content;
		}
	});
	
	function writeEvent() {
		let content = inputText;
		let reRef = $('#qnaNumModal').val();
		let reLev = 1;

		if(content.length == 0){
			alert('내용을 입력해주세요');
			return false;
		}
		
		let isWrite = confirm('상품 문의글을 작성하시겠습니까?');
		if(isWrite){
			$.ajax({
				url: '/customerCenter/qnaReply',
				data: { content: content, reRef: reRef, reLev: reLev },
				method: 'post',
				success:function(res){
					if(res.isSuccess) { 
						$('#qnaAnswer').modal('hide');
						updateQnaList();
					}
				}
			});
		}
	}

	function modifyEvent() {
		let content = inputText;
		let replyNum = $('#replyNumModal').val();

		console.log('modal content : ' + content);
		console.log('modal replyNum : '+ replyNum);
		if(content.length == 0){
			alert('내용을 입력해주세요');
			return false;
		}
		
		let isModify = confirm('답글을 수정하시겠습니까?');
		if(isModify){
			$.ajax({
				url: '/customerCenter/qnaReplyModify',
				data: { num: replyNum, content: content },
				method: 'post',
				success:function(res){
					if(res.isSuccess) { 
						$('#qnaAnswer').modal('hide');
						updateQnaList();
					}
				}
			});
		}
	}
</script>
	
