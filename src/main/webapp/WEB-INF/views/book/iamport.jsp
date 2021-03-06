<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제</title>
</head>

<!-- 결제 API CDN -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<body>
    <script>
        var IMP = window.IMP;
        IMP.init('가맹점 식별코드');
        IMP.request_pay({
            pg : 'kakao',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '주문명:결제테스트',
            amount : ${ bookVo.cost },
            buyer_email : 'iamport@siot.do',
            buyer_name : '${ bookVo.id }',
            buyer_tel : '010-1234-5678',
            buyer_addr : '서울특별시 강남구 삼성동',
            buyer_postcode : '123-456',
            m_redirect_url : 'https://www.yourdomain.com/payments/complete' 
        }, function(rsp) {
            if ( rsp.success ) {
				let sendDate = {
						id: '${ bookVo.id }',
						cost: ${ bookVo.cost },
						checkIn: '${ bookVo.checkIn }',
						checkOut: '${ bookVo.checkOut }',
						cntOfPerson: ${ bookVo.cntOfPerson },
						noNum: ${ bookVo.noNum },
				}
				console.log(sendDate)
				$.ajax({
					url: '/book/iamport',
					type: 'POST',
					data: sendDate,
					success: function(data) {
						alert('결제완료');
						location.href = '/book/complete?num=' + data;
					},
					error:function(jqXHR, textStatus, errorThrown) {
						console.log('데이터 전송 에러');
					}
				});
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
            }
        });
    </script>
</body>
</html>
