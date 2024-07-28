

spring boot, mysql로 구현한 숙박시설 예약사이트. 숙박시설 지도, 예약, 등록, 카카오 테스트결제 등 기능
팀 프로젝트로 로그인, 회원가입, 메일인증, 지도 API 담당




- 메인 페이지br>
![travelmain(1)](https://github.com/user-attachments/assets/35f024be-85ad-4282-9018-88e2f86bed63)



- 현재 날짜를 기준으로 한 달력 형식 체크인,아웃 날짜 지정 기능, 지역 검색가능, 등록된 호텔정보
![calendar](https://github.com/user-attachments/assets/5d285c23-1108-4030-a3bf-22026d1a7bfc)<br>
![travelmain(2)](https://github.com/user-attachments/assets/2b5f8182-d0f0-40f1-9024-3722ef65a486)



- 리뷰<br>
![travelmain(3)](https://github.com/user-attachments/assets/5b98170a-f05e-498e-9d02-0e38f2d4d555)



- 검색한 정보로 생성되는 지도<br>
![searchpage(1)](https://github.com/user-attachments/assets/24fe5134-09d1-411d-b13e-2aea64d9d59e)



- 등록된 숙박시설<br>
![searchpage(2)](https://github.com/user-attachments/assets/0cb97d63-0d9a-4b04-ba8b-82799ed37d93)



- 마커 클릭시 자세한 정보 띄우기<br>
![searchinfo](https://github.com/user-attachments/assets/93004639-e2bc-4539-bf22-d83451e9d63a)



- 로그인 모달창<br>
![longinmodal](https://github.com/user-attachments/assets/42a89516-79d2-419b-aa9a-bdc35934565c)



- 회원가입 모달창<br>
![joinmodal](https://github.com/user-attachments/assets/69f01582-4f89-4bef-9c90-f07c60668ab3)



- fap게시판, 관리자만 글 등록 가능<br>
![faqlist](https://github.com/user-attachments/assets/856ab56e-9451-40b4-aa9a-ffa432b92ca0)



- qna게시판, 글쓰기는 모든회원이 가능하지만 답변은 관리자만 가능<br>
![qnalist](https://github.com/user-attachments/assets/e23f3851-17cc-4c6a-9926-77bbb9bc7437)



- 회원정보 수정, 이미지 등록, 숙소 등록, 구매내역 확인, 리뷰 확인등의 기능<br>
![userinfo](https://github.com/user-attachments/assets/6cec35ff-f861-4265-86ef-e3f971882fea)



- 숙박시설 세부정보 글. 결제창으로 넘어 가기전 숙소 세부정보 확인과 예약날짜 입력 가능<br>
![contentinfo](https://github.com/user-attachments/assets/0cf06eb0-8eee-4613-93cf-aec78dd581cb)



- 그리고 기타 숙소글 등록기능과 등록시 지역 입력창 팝업, 그리고 카카오페이 결제 페이지등의 기능<br>
![locationpop](https://github.com/user-attachments/assets/30f34304-1fe9-4453-9de8-e30d862f2921)



<hr>



# spring_travel

테이블 생성문

CREATE TABLE `travel_book` (
  `num` int NOT NULL AUTO_INCREMENT,
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `cost` int DEFAULT NULL,
  `check_in` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `check_out` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `cnt_of_person` int DEFAULT NULL,
  `no_num` int DEFAULT NULL,
  `reg_date` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_custom_service_qna` (
  `num` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `type` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `subject` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `re_ref` int NOT NULL,
  `re_lev` int NOT NULL,
  `reg_date` datetime NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_email` (
  `email` varchar(30) COLLATE utf8_bin NOT NULL,
  `number` varchar(5) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`number`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_host` (
  `num` int NOT NULL AUTO_INCREMENT,
  `id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `classification` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `housetype` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `staytype` varchar(35) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `countofperson` int NOT NULL,
  `countofbedroom` int NOT NULL,
  `countofbed` int NOT NULL,
  `countofsofebed` int NOT NULL,
  `countofsofe` int NOT NULL,
  `countofblanket` int NOT NULL,
  `countofbathroom` int NOT NULL,
  `postcode` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `address1` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `address2` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `amenities` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `safety` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `usefull` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `hostComment` varchar(1600) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cost` int NOT NULL,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `reg_date` datetime NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_host_image` (
  `num` int NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `filename` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uploadpath` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `noNum` int NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_host_save` (
  `num` int NOT NULL AUTO_INCREMENT,
  `host_num` int NOT NULL,
  `id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `isSave` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_location` (
  `location` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_review` (
  `num` int NOT NULL AUTO_INCREMENT,
  `id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `comment` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `score` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `no_num` int NOT NULL,
  `reg_date` datetime NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE `travel_user` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(60) COLLATE utf8_bin NOT NULL,
  `name` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(60) COLLATE utf8_bin NOT NULL,
  `tel` varchar(50) COLLATE utf8_bin NOT NULL,
  `uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `filename` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `uploadpath` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `reg_date` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `travel_custom_service_faq` (
  `num` int NOT NULL AUTO_INCREMENT,
  `id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `subject` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `readcount` int DEFAULT NULL,
  `reg_date` datetime NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
