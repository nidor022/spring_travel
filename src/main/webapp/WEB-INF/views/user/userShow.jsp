<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보</title>
<style>
div{
	padding: 10px;
/* 	border:1px solid lightgray; */
}
p {
	color: darkblue;
}
p:hover {
	text-decoration: underline;
	color: skyblue;
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

.drawOutLine {
	border: solid 1px #d2d2d2;
}
.userInfoContainer {
	width: 1100px;
	display: block;
	margin: 0 auto;
	position: relative;
}
</style>

</head>
<body style="background-color: #f2f2f2;">
	<div class="userInfoContainer" style="background-color: white;">
		<jsp:include page="/WEB-INF/views/include/commonHeader.jsp" />
		<div class="container text-center" id="app">
			<div class="drawOutLine"><h4><b>회원정보</b></h4></div>
			<div class="horizontal">
				<div class="verticality" style="width: 300px;">
					<div>
						<div v-show="!imageBtnShow" class="profileImageBox drawOutLine">
							<c:choose>
								<c:when test="${ not empty userVo.filename }">
									<img id="currentImg" src="/upload/${ userVo.uploadpath }/${ userVo.uuid }_${ userVo.filename }" width="150" height="150">
								</c:when>
								<c:otherwise>
									<span><i class="fas fa-user fa-10x"></i></span>
								</c:otherwise>
							</c:choose>
						</div>
						<div v-show="imageBtnShow" class="profileImageBox drawOutLine">
							<div>
								<p>현재 사진</p>
								<c:choose>
									<c:when test="${ not empty userVo.filename }">
										<img id="preImg" src="/upload/${ userVo.uploadpath }/${ userVo.uuid }_${ userVo.filename }" width="150" height="150">
									</c:when>
									<c:otherwise>
										<span><i class="fas fa-user fa-10x"></i></span>
									</c:otherwise>
								</c:choose>
							</div>
							<br>
							<div>
								<p>바뀔 사진</p>
								<img v-if="imageUrl" :src="imageUrl" width="150" height="150">
								<span v-if="!imageUrl"><i class="fas fa-user fa-10x"></i></span>
							</div>
						</div>
						<div v-show="!imageBtnShow">
							<button type="button" class="btn" v-on:click="imageBtnShow = true">프로필 사진 변경</button>
							
						</div>
						<div class="drawOutLine" v-show="imageBtnShow">
							<form id="FILE_FORM" method="post" enctype="multipart/form-data" action="">
					            <input type="file" id="FILE_TAG" name="filename" accept="image/*" @change="onFileChange" required>
					            <br><br>
					            <a class="ui-shadow ui-btn ui-corner-all btn btn-dark" href="javascript:uploadFile();">저장</a>
					            <button type="button" class="btn btn-dark" v-on:click="deleteFile">취소</button>
					        </form>
						</div>
					</div>
					<hr>
					<div class="drawOutLine">
						인증완료
					</div>
					
					<div class="drawOutLine">
						${ userVo.email }
					</div>
					<hr>
					<div>
						<button type="button" class="btn" onclick="deleteId()">회원 탈퇴</button>
					</div>
				</div>
				
				<div class="verticality" style="width: 750px;">
					<div class="drawOutLine">
						<div>
							${ userVo.id } 회원님
						</div>
						<div>
							가입일자 : <fmt:formatDate value="${ userVo.regDate }" pattern="yyyy년 MM월 dd일" />
						</div>
						<div>
							<div class="drawOutLine" v-show="profileBox">
								<h4>프로필</h4>
								<hr>
								<div class="text-left">
									<p v-on:click="setShowNameInfo" id="nameInfo">이름 : ${ userVo.name }</p>
									<p v-on:click="setShowTelInfo" id="telInfo">전화번호 : ${ userVo.tel }</p>
									<p v-on:click="setShowPwdInfo">비밀번호 : **** </p>
								</div>
							</div>
							
							
							<div class="drawOutLine" v-show="nameShow">
								<div>
									<h4>이름</h4>
									<hr>
									<input class="form-control" type="text" id="name" value="${ userVo.name }">
								</div>
								<div class="text-center">
									<button type="button" class="btn" v-on:click="setNameBtn">이름 변경</button>
									<button type="button" class="btn" v-on:click="setShowProfileBox">취소</button>
								</div>
							</div>
							
							<div class="drawOutLine" v-show="telShow">
								<div>
									<h4>전화번호</h4>
									<hr>
									<input class="form-control" type="tel" placeholder="xxx-xxxx-xxxx" id="telIn" maxlength="13" onkeyup="noSpaceForm(this);" value="${ userVo.tel }">
								</div>
								<div class="text-center">
									<button type="button" class="btn" v-on:click="setTelBtn">전화번호 변경</button>
									<button type="button" class="btn" v-on:click="setShowProfileBox">취소</button>
								</div>
							</div>
							
							<div class="drawOutLine" v-show="pwdShow">
								<div>
									<h4>비밀번호</h4>
									<hr>
									<label>현재 비밀번호</label> 
									<input type="password" class="form-control" name="currentPwd"><span id="msgPwd"></span><br>
									<label>새 비밀번호</label>
									<input type="password" class="form-control" name="newPwd1"><br>
									<label>비밀번호 확인</label>
									<input type="password" class="form-control" name="newPwd2"><span id="msgPass"></span><br>
								</div>
								<div class="text-center">
									<button type="button" class="btn" id="changePwdBtn" onclick="changePwd()" disabled>비밀번호 변경</button>
									<button type="button" class="btn" v-on:click="setShowProfileBox">취소</button>
								</div>
							</div>
						</div>
						
						
					</div>
					<hr>
					<div class="drawOutLine">
						<div>
							<a href="/user/MyReviews">후기 및 평점 보기 (${ cntOfReview })</a>
						</div>
						<hr style="margin: 0px;">
						<div>
							<a href="/user/MyHosts">게시글 보기 (${ cntOfHost })</a>
						</div>
						<hr style="margin: 0px;">
						<div>
							<a href="/travel/history">예약 내역 보기</a>
						</div>
					</div>
					<hr>
					<div>
						<button type="button" class="btn" onclick="location.href = '/content/write'">게시물 작성하기</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script>
		vue = new Vue ({
		    el: '#app',
		    data :{
		    	imageBtnShow: false,
		    	nameShow: false,
		    	telShow: false,
		    	pwdShow: false,
		    	profileBox: true,
		    	imageUrl: ''
		    },
		    methods:{
				setShowImageBtn: function() {
		             this.imageBtnShow = true;
				},
				setNameBtn: function() {
					let name = $('#name').val();
					let vm = this;
					$.ajax({
						url: '/user/saveName',
						method: 'post',
						data: { name: name},
						success: function(res) {
							if(res.isSuccess) {
								alert('이름이 변경되었습니다.');
								$('#nameInfo').text('이름 : ' + res.name);
								vm.nameShow = false;
								vm.profileBox = true;
							} else {
								alert('다시 시도해주세요.');
							}
						}
					});
				},
				setTelBtn: function() {
					let tel = $('#telIn').val();
					let vm = this;
					$.ajax({
						url: '/user/saveTel',
						method: 'post',
						data: {tel: tel},
						success: function(res) {
							if(res.isSuccess) {
								alert('전화번호가 변경되었습니다.');
								$('#telInfo').text('전화번호 : ' + res.tel);
								vm.telShow = false;
								vm.profileBox = true;
							} else {
								alert('다시 시도해주세요.');
							}
						}
					});
				},
		        setShowNameInfo: function() {
		            this.nameShow = true;
		            this.profileBox = false;
		        },
		        setShowTelInfo: function() {
		            this.telShow = true;
		            this.profileBox = false;
		        },
		        setShowPwdInfo: function() {
		            this.pwdShow = true;
		            this.profileBox = false;
		        },
		    	setShowProfileBox: function() {
		        	this.nameShow = false;
		        	this.telShow = false;
		        	this.pwdShow = false;
		        	this.profileBox = true;
		
		        	$('span#msgPwd').html('');
		       	},
				onFileChange(e) {
			        var files = e.target.files || e.dataTransfer.files;
			        if (!files.length)
			       		return;
			        this.createImage(files[0]);
		   		},
			    createImage(file) {
		       		var image = new Image();
		        	var reader = new FileReader();
		        	var vm = this;
			        reader.onload = (e) => {
			        	vm.imageUrl = e.target.result;
		       		};
			        reader.readAsDataURL(file);
		 	    },
		 	   	deleteFile: function() {
					let tag = $('input[name="filename"]');
					$(tag).val('');
					this.imageUrl= null;
					this.imageBtnShow = false;
				}
		    }
		});
		function uploadFile(){
			
		    var form = $('#FILE_FORM')[0];
		    var formData = new FormData(form);
		    formData.append("fileObj", $("#FILE_TAG")[0].files[0]);

		    if(typeof $("#FILE_TAG")[0].files[0] == 'undefined'){
			    alert('이미지를 선택해주세요!');
				return;
			}
			
		    $.ajax({
		        url: '/user/saveImage',
		        processData: false,
		        contentType: false,
		        data: formData,
		        type: 'POST',
		        success: function(result){
		            if(result.isSuccess){
		        		vue.imageBtnShow = false;
		        		$('#currentImg').attr('src', '/upload/'+result.uploadpath+'/'+result.uuid+'_'+result.filename);
		        		$('#preImg').attr('src', '/upload/'+result.uploadpath+'/'+result.uuid+'_'+result.filename);
						vue.deleteFile();
		            	alert("사진이 변경되었습니다.");
		            } else {
		            	alert("사진 변경이 실패하였습니다. 다시 시도해주세요.");
		            }
		        }
			});
		}
		
		//==================== 전화번호 =======================//
		
		function noSpaceForm(obj) { // 공백사용못하게
		    var str_space = /\s/;  // 공백체크
		    if(str_space.exec(obj.value)) { //공백 체크
		        alert("해당 항목에는 공백을 사용할수 없습니다.\n\n공백은 자동적으로 제거 됩니다.");
		        obj.focus();
		        obj.value = obj.value.replace(/(\s*)/g, ""); // 공백제거
		        return false;
		    }
		}
		
		var autoHypenPhone = function(str){
		    str = str.replace(/[^0-9]/g, '');
		    var tmp = '';
		    if( str.length < 4){
		        return str;
		    }else if(str.length < 7){
		        tmp += str.substr(0, 3);
		        tmp += '-';
		        tmp += str.substr(3);
		        return tmp;
		    }else if(str.length < 11){
		        tmp += str.substr(0, 3);
		        tmp += '-';
		        tmp += str.substr(3, 3);
		        tmp += '-';
		        tmp += str.substr(6);
		        return tmp;
		    }else{              
		        tmp += str.substr(0, 3);
		        tmp += '-';
		        tmp += str.substr(3, 4);
		        tmp += '-';
		        tmp += str.substr(7);
		        return tmp;
		    }
		
		    return str;
		}
		
		
		var phoneNum = document.getElementById('telIn');
		
		phoneNum.onkeyup = function(){
			this.value = autoHypenPhone( this.value ) ;  
		}
		
		// ================== 비밀번호 ==================//
		let pwdComform = false;
		let newPwdComform = false;
		$('input[name="currentPwd"]').keyup(function() {
			let pwd = $(this).val();
		
			if (pwd.length < 8) {
				return;
			}
		
			// 아이디 세글자 부터는 Ajax로 아이디 중복체크하기
			$.ajax({
				url : '/user/pwdChk',
				data : {
					password : pwd
				},
				//method: 'GET',
				success : function(response) {
					pwdComform = response.isCoincide;
					if (response.isCoincide) {
						$('span#msgPwd').html(response.comment).css('color', 'green');
						if(pwdComform && newPwdComform) {
							$('#changePwdBtn').attr('disabled', false);
						}
					} else {
						$('span#msgPwd').html(response.comment).css('color', 'red');
						$('#changePwdBtn').attr('disabled', true);
					}
				}
			});
		});
		
		$('input[name="newPwd2"]').focusout(function() {
			let pass1 = $('input[name="newPwd1"]').val();
			let pass2 = $(this).val();
		
			if (pass1 == pass2) {
				if(pass2.length < 8 || pass2.length > 20) {
					$('span#msgPass').html('8자리 ~ 20자리 이내로 입력해주세요.').css('color', 'red');
					return;
				}
				let num = pass2.search(/[0-9]/g);
				let eng = pass2.search(/[a-z]/ig);
				let spe = pass2.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				let currentPwd = $('input[name="currentPwd"]').val();
				if(pass2.search(/\s/) != -1){
					$('span#msgPass').html('비밀번호는 공백 없이 입력해주세요.').css('color', 'red');
					return false;
				}else if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
					$('span#msgPass').html('영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.').css('color', 'red');
					return false;
				} else if(currentPwd == pass2) {
					$('span#msgPass').html('현재 비밀번호와 동일합니다.').css('color', 'red');
					return false;
				}
					
				
				$('span#msgPass').html('비밀번호 일치함').css('color', 'green');
				newPwdComform = true;
				if(pwdComform && newPwdComform) {
					$('#changePwdBtn').attr('disabled', false);
				}
			} else {
				$('span#msgPass').html('비밀번호 불일치').css('color', 'red');
				newPwdComform = false;
				$('#changePwdBtn').attr('disabled', true);
			}
		});
		
		function changePwd() {
			let newPwd = $('input[name="newPwd1"]').val();
		
			$.ajax({
				url: '/user/savePwd',
				data: { password: newPwd },
				method: 'post',
				success: function(res) {
					if(res.isSuccess) {
						alert('비밀번호가 변경되었습니다.');
						$('span#msgPwd').html('');
						$('span#msgPass').html('');
		
						$('input[name="currentPwd"]').val('');
						$('input[name="newPwd1"]').val('');
						$('input[name="newPwd2"]').val('');
						
						$('#changePwdBtn').attr('disabled', true);
						
					 	vue.pwdShow = false;
			            vue.profileBox = true;
		
			            pwdComform = false;
			            newPwdComform = false;
					} else {
						alert('다시 시도해주세요.');
					}
				}
			});
		}
		function deleteId() {
			let isDelete = confirm('정말 삭제하시겠습니까?');
			
			if(isDelete) {
				location.href = '/user/delete';
			}
		}
	</script>
</body>
</html>