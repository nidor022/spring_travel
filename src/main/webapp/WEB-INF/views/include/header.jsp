<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#login {
	float: right;
}
#logo {
	float:left;
}
#top_menu {
	margin-top : -30px;
	margin-bottom: 10px;
	margin-left: 10px;
	float: right;
}
#top_menu ul {
	list-style: none;
	margin: 0;
}
#top_menu ul li {
	float: left;
	margin: 5px;
}
header {
	height: 80px;
	padding: 10px;
}
.clear {
	height: 10px;
	clear:both;
	padding: 0px;
	margin: 0px;
}

div {
/* 	border: 1px solid red; */
	padding: 10px;
}
hr {
	border: 0;
	height: 1px;
	background: #d2d2d2;
}
.modal-dialog.modal-fullsize { 
	width: 450px;
	height: auto; 
}
.modal-dialog.modal-Joinsize { 
	width: 480px;
	height: auto; 
}
.containerLogin {
	width: 370px;
}

.containerJoin {
	width: 400px;
}

</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<body>
	<header>
		<div id="login">
		<c:choose>
			<c:when test="${ not empty id }">
				<a href="/user/show">${ id }님</a> | <a href="/user/logout">로그아웃</a>		
			</c:when>
			<c:otherwise>
				<a data-toggle="modal" href="#loginModal">로그인</a>
		 	| <a data-toggle="modal" href="#joinModal">회원가입</a>
			</c:otherwise>
		</c:choose>
			
		</div>

		<div id="logo">
			<a href="/">
				<span style="color: #ff385c"><i class="fab fa-airbnb fa-2x"><b> airbnb</b></i></span>
			</a>
		</div>
		<div class="clear"></div>
		<div id="top_menu">
			<ul>
				<li><a href="#d">검색</a></li>
				<li><a href="#b">종류</a></li>
				<li><a href="#c">리뷰</a></li>
				<li><a href="/customerCenter/faqList">고객센터</a></li>
			</ul>
		</div>
	</header>
	<div class="modal fade" id="loginModal" role="dialog"> <!-- 사용자 지정 부분① : id명 -->
		<div class="modal-dialog modal-lg modal-fullsize">
			<div class="modal-content modal-fullsize">
				<div class="modal-header">
					<span style="font-size: 30px;">로그인</span>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				<div class="modal-body">
					<div class="containerLogin">
						<div class="middle">
							<div class="id">
								<label for="">아이디</label> <br> 
								<input type="text" name="id" id="loginId"><br> <br> 
								<label for="">비밀번호</label><br> 
								<input type="password" name="password" id="loginPwd"><br>
							</div>
							
							<div> 
								로그인 유지 <input type="checkbox" name="keepLogin" id="keepLogin" value="true">
								<button type="button" class="btn" onclick="loginCheck()">로그인</button> 
							</div> 		
							<hr>
							<div class="find">
<!-- 								<a data-toggle="modal" href="#findIdModal">아이디 찾기</a> | -->
								<button type="button" class="btn btn-link" id="findIdBtn" onclick="showIdModal()">아이디 찾기</button> |
								<button type="button" class="btn btn-link" id="findPwdBtn" onclick="showPwdModal()">비밀번호 찾기</button>
<!-- 								<a data-toggle="modal" href="#findPwdModal">비밀번호 찾기</a> -->
							</div>
							
							<div class="join">
								<label for="">계정이 없으세요?</label>
								<button type="button" class="btn btn-link" onclick="showJoinModal()">회원가입</button>
							</div>
							<hr>
							<div class="image">
								<img src="/images/nike.gif" width="300">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="findIdModal" role="dialog"> <!-- 사용자 지정 부분① : id명 -->
		<div class="modal-dialog modal-lg modal-fullsize">
			<div class="modal-content modal-fullsize">
				<div class="modal-header">
					<span style="font-size: 30px;">아이디 찾기</span>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				<div class="modal-body">
					<div class="containerFind">
						<div>
							<label>회원정보에 등록된 이메일을 입력하세요.</label><br><br>
							<input type="email" id="emailById" name="email" placeholder="xxx@xxx.xx"> 
							<button type="button" class="btn btn-dark" id="findId" onclick="findId()" style="margin-left: 10px;">아이디 발송</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="findPwdModal" role="dialog"> <!-- 사용자 지정 부분① : id명 -->
		<div class="modal-dialog modal-lg modal-fullsize">
			<div class="modal-content modal-fullsize">
				<div class="modal-header">
					<span style="font-size: 30px;">비밀번호 찾기</span>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				<div class="modal-body">
					<div class="containerFind">
						<div>
							<label>회원정보에 등록된 아이디, 이메일을 입력하세요.</label><br><br>
							<label>아이디</label>
							<input type="text" id="idByPwd" name="id" placeholder="아이디 입력"><br><br>
							<label>이메일</label>
							<input type="email" id="emailByPwd" name="email" placeholder="xxx@xxx.xx"><br><br>
							<div class="text-center">
								<button type="button" class="btn btn-dark" id="findPass" onclick="findPwd()">비밀번호 발송</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="joinModal" role="dialog"> <!-- 사용자 지정 부분① : id명 -->
		<div class="modal-dialog modal-lg modal-fullsize">
			<div class="modal-content modal-Joinsize">
				<div class="modal-header">
					<span style="font-size: 30px;">회원가입</span>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				<div class="modal-body">
					<div class="containerJoin">
						<div>
							<fieldset>
								<div>
									<label for="">아이디 (영문소문자,숫자 최소8자)</label> <br> 
									<input type="text" id="joinId" placeholder="아이디 입력" onkeyup="noSpaceForm(this);" required><br>
									<span id="msgIdDup"></span><br>
								</div>
								<hr>
								<div>
									<label for="">비밀번호 (영소문자,숫자 반드시 포함 최소8자)</label> <br> 
									<input type="password" id="joinPwd" placeholder="비밀번호 입력" onkeyup="noSpaceForm(this);" required>
								</div>
								<div>
									<label for="">비밀번호 재확인 </label> <br> 
									<input type="password" id="joinPwdConfirm" placeholder="비밀번호 재입력" onkeyup="noSpaceForm(this);" required><br>
									<span id="msgPass"></span>
								</div>
								<hr>
								<div>
									<label for="">이름 </label> <br> 
									<input type="text" id="joinName" placeholder="이름 입력" onkeyup="noSpaceForm(this);"><br>
								</div>
								<hr>
								<div>
									<label for="">이메일 </label> <br> 
									<input type="email" id="joinEmail" placeholder="이메일 입력" onkeyup="noSpaceForm(this)" required>
									<input type="button" name="emailBtn" id="sendEmailBtn" value="이메일 인증">
									
									<div id="emailDiv" style="display: none"> <%-- 보일려면 block --%>
										<input type="button" id="joinReEmailBtn" value="재발송" >
										<input type="text" id="emailConfirmNum" placeholder="인증번호 입력(5자리)">
										<input type="button" name="confirmBtn" id="checkConfirmNumBtn" value="확인"> <%-- 인증확인버튼 --%>
									</div>
								</div>
								<hr>
								<div>
									<label for="">전화번호 </label> <br> 
									<input type="tel" id="joinTel" placeholder="xxx-xxxx-xxxx" maxlength="13" onkeyup="noSpaceForm(this);" required><br>
								</div>
							</fieldset>
	
							<div>
								<input type="button" value="회원가입" id="joinBtn" onclick="userJoin()"> 
								<input type="reset" value="초기화" class="cancel">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/script/jquery-3.5.1.js"></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	
	<script src="https://code.jquery.com/jquery-1.12.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
	<script>
		function showIdModal() {
			$("#findIdModal").modal('show');
			$("#loginModal").modal('hide');
		}
		
		function showPwdModal() {
			$("#findPwdModal").modal('show');
			$("#loginModal").modal('hide');
		}

		function showJoinModal() {
			$('#joinModal').modal('show');
			$("#loginModal").modal('hide');
		}
		
		// 아이디 / 비번 찾기 창 닫으면 로그인 화면 호출
		$('#findIdModal').on('hidden.bs.modal', function () {
			$("#loginModal").modal('show');
		});

		$('#findPwdModal').on('hidden.bs.modal', function () {
			$("#loginModal").modal('show');
		});

		// 아이디 찾기 이벤트
		function findId() {
			let email = $('#emailById').val();
			alert('처리중입니다. 잠시만 기다려주세요. 확인하셨다면 버튼을 눌러주세요.');
			$.ajax({
				url: '/mail/findId',
				data: { email: email },
				method: 'post',
				success: function(res) {
					if(res.isSuccess) {
						alert('잠시 후 아이디에 등록된 메일로 아이디 정보를 발송합니다.');
						$("#findIdModal").modal('hide');
						$("#loginModal").modal('show');
					} else {
						alert('다시 시도해주세요.');
					}
					$('#emailById').val('');
				}
			});
		}

		// 비밀번호 찾기 이벤트
		function findPwd() {
			let id = $('#idByPwd').val();
			let email = $('#emailByPwd').val();
			alert('처리중입니다. 잠시만 기다려주세요. 확인하셨다면 버튼을 눌러주세요.');
			$.ajax({
				url: '/mail/findPass',
				data: { id: id, email: email },
				method: 'post',
				success: function(res) {
					if(res.isSuccess) {
						alert('잠시 후 아이디에 등록된 메일로 임시비밀번호가 발송합니다.');
						$("#findPwdModal").modal('hide');
						$("#loginModal").modal('show');
					} else {
						alert('다시 시도해주세요.');
					}
					$('#idByPwd').val('');
					$('#emailByPwd').val('');
				}
			});
		}

		// 로그인 이벤트
		function loginCheck() {
			let id = $('#loginId').val();
			let password = $('#loginPwd').val();
			let keepLogin = $('#keepLogin').is(':checked');
			let url = $(location).attr('href');
	
			$.ajax({
				url: '/user/login',
				data: { id: id, password: password },
				method: 'post',
				success: function(res){
					if(res != 1) {
						alert('아이디 또는 패스워드가 일치하지 않습니다.');
						return;
					}
					alert('로그인 하셨습니다.');
	
					let form = document.createElement("form");
			        let parm = new Array();
			        let input = new Array();
	
			        form.action = '/user/loginSuccess';
			        form.method = 'post';
	
	
			        parm.push( ['id', id] );
			        parm.push( ['keepLogin', keepLogin] );
			        parm.push( ['url', url] );
	
	
			        for (var i = 0; i < parm.length; i++) {
			            input[i] = document.createElement("input");
			            input[i].setAttribute("type", "hidden");
			            input[i].setAttribute('name', parm[i][0]);
			            input[i].setAttribute("value", parm[i][1]);
			            form.appendChild(input[i]);
			        }
			        document.body.appendChild(form);
			        form.submit();
				}
			});
		}

		let checkId = false;
		// 아이디 중복 확인
		$('#joinId').keyup(function() {
			let id = $(this).val();
			console.log(id);
			
			if(id.length > 4 && id.length < 8) {
				$('span#msgIdDup').html('형식에 맞게 입력해주세요.').css('color', 'red');
				checkId = false;
				return;
			}
			
			if (id.length < 8) {
				checkId = false;
				return;
			}

			let getCheckId = RegExp(/^[a-zA-Z0-9]{6,20}$/);
			if(!getCheckId.test(id)) {
				$('span#msgIdDup').html('형식에 맞게 입력해주세요.').css('color', 'red');
				checkId = false;
				return false;
			}
			$.ajax({
				url : '/user/ajax/joinIdDupChk',
				data : {
					id : id
				},
				success : function(response) {
					console.log(response);
					if (response.isIdDup) {
						$('span#msgIdDup').html('이미 사용중인 아이디 입니다.').css('color', 'red');
						checkId = false;
					} else {
						$('span#msgIdDup').html('사용 가능한 아이디 입니다.').css(	'color', 'green');
						checkId = true;
					}
				}
			});
		});

		let checkPwd = false;
		// 비밀번호 일치 여부 확인
		$('#joinPwdConfirm').focusout(function() {
			let pass1 = $('#joinPwd').val();
			let pass2 = $(this).val();

			if(pass2.length < 8) {
				$('#msgPass').html('형식에 맞게 입력해주세요.').css('color', 'red');
				$('#joinPwd').val('');
				$(this).val('');
				$('#joinPwd').focus();
				checkPwd = false;
				return;
			}
			
			let getCheckPwd = RegExp(/(?=.*[a-z])(?=.*[0-9]).{8,20}/);
			if(!getCheckPwd.test(pass2)) {
				$('#msgPass').html('형식에 맞게 입력해주세요.').css('color', 'red');
				$('#joinPwd').val('');
				$(this).val('');
				$('#joinPwd').focus();
				checkPwd = false;
				return false;
			}
			
			if (pass1 == pass2) {
				$('#msgPass').html('비밀번호 일치').css('color', 'green');
				checkPwd = true;
			} else {
				$('#msgPass').html('비밀번호 불일치').css('color', 'red');
				$(this).val('');
				$('#joinPwd').focus();
				checkPwd = false;
			}
		});

		// 이메일 유효성 검사
		function CheckEmail(str) {                                                 
		     let reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

		     if(!reg_email.test(str)) {                            
		          return false;         
		     }                            
		     else {                       
		          return true;         
		     }                            
		}

		// 이메일 인증 번호 전송 이벤트
		$('#sendEmailBtn').click(function() {
			let email = $('#joinEmail');

			if (email.val() == "") {             
				alert("이메일을 입력하세요!");
				email.focus();	
				return;
			}               
			else   {          
				if(!CheckEmail(email.val()))	{
					alert("이메일 형식이 잘못되었습니다");
					email.focus();
					return;
				}      
				else {
					alert("이메일이 발송되었습니다. 이메일이 도착하지 않는다면 재발송버튼을 눌러주세요");
					
					$.ajax({
						url : '/mail/ajax/email',
						method: 'get',
						data : {
								email : email.val()
						}
					});
					$('#sendEmailBtn').attr('disabled', true);
					$('#emailDiv').css('display', 'block');
				}
			}
		});

		// 이메일 인증 재전송 버튼 이벤트
		$('#joinReEmailBtn').click(function() {
			let email = $('#joinEmail').val();

			$.ajax({
				url : '/mail/ajax/reEmail',
				data : {
						email : email
				}
			});
			alert("인증번호가 전송되었습니다. 메일이 도착하지 않았다면 인증번호 재발송 버튼을 눌러주세요") 
			$('#sendEmailBtn').attr('disabled', true);					
		});

		let checkEmail = false;
		// 인증번호 확인 이벤트
		$('#checkConfirmNumBtn').click(function() {
			let email = $('#joinEmail').val();
			let number = $('#emailConfirmNum').val();

			$.ajax({
				url : '/mail/ajax/emailLast',
				data : {
					email : email,
					number : number
				},
				success : function(response) {

					if (response.emailnumber) {
						alert("인증에 성공하였습니다");
						$('#joinReEmailBtn').attr('disabled', true);
						$('#checkConfirmNumBtn').attr('disabled', true);
						$('#joinEmail').attr('readonly', true);
						checkEmail = true;
					} else {
						alert("인증번호나 이메일이 일치하지 않습니다. 인증번호를 다시 발급 받아주세요");
						checkEmail = false;
					}
				}
			});
		
		});

		function userJoin() {
			let id = $('#joinId').val();
			let pwd = $('#joinPwd').val();
			let pwdCofirm = $('#joinPwdConfirm').val();
			let name = $('#joinName').val();
			let email = $('#joinEmail').val();
			let tel = $('#joinTel').val();

			if(id.length == 0) {
				alert('아이디를 입력해주세요.');
				$('#joinId').focus();
				return;
			} else if(pwd.length == 0) {
				alert('비밀번호를 입력해주세요.');
				$('#joinPwd').focus();
				return;
			} else if(pwdCofirm.length == 0) {
				alert('비밀번호를 입력해주세요.');
				$('#joinPwdConfirm').focus();
				return;
			} else if(name.length == 0) {
				alert('이름을 입력해주세요.');
				$('#joinName').focus();
				return;
			} else if(email.length == 0) {
				alert('이메일을 입력해주세요.');
				$('#joinEmail').focus();
				return;
			} else if(tel.length == 0) {
				alert('전화번호를 입력해주세요.');
				$('#joinTel').focus();
				return;
			} else if(!checkId) {
				alert('아이디를 형식에 맞게 입력해주세요.');
				$('#joinId').focus();
				$('#joinId').val('');
				return;
			} else if(!checkPwd) {
				alert('비밀번호를 형식에 맞게 입력해주세요.');
				$('#joinPwd').focus();
				$('#joinPwd').val('');
				$('#joinPwdConfirm').val('');
				return;
			} else if(!checkEmail) {
				alert('이메일을 형식에 맞게 입력해주세요.');
				$('#joinEmail').focus();
				$('#joinEmail').val('');
				return;
			} else if(tel.length != 13) {
				alert('전화번호를 형식에 맞게 입력해주세요.');
				$('#joinTel').focus();
				$('#joinTel').val('');
				return;
			}

			$.ajax({
				url: '/user/join',
				data: { id: id, password: pwd, name: name, email: email, tel: tel },
				method: 'post',
				success: function(res) {
					if(res.isSuccess) {
						alert('회원 가입이 완료되었습니다.');
						$("#joinModal").modal('hide');
						$("#loginModal").modal('show');
					} else {
						$('#joinId').val('');
						$('#joinPwd').val('');
						$('#joinPwdConfirm').val('');
						$('#joinName').val('');
						$('#joinEmail').val('');
						$('#joinTel').val('');
						alert('다시 시도해주세요.');
					}
				}
			});
		}
		
		// 전화번호 유효성 검사
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

		var phoneNum = document.getElementById('joinTel');

		phoneNum.onkeyup = function(){
			console.log(this.value);
			this.value = autoHypenPhone( this.value ) ;  
		}
		
		function noSpaceForm(obj) { // 공백사용못하게
		    let str_space = /\s/;  // 공백체크
		    if(str_space.exec(obj.value)) { //공백 체크
		        alert("해당 항목에는 공백을 사용할수 없습니다.\n\n공백은 자동적으로 제거 됩니다.");
		        obj.focus();
		        obj.value = obj.value.replace(/(\s*)/g, ""); // 공백제거
		        return false;
		    }
		}
	</script>
</body>