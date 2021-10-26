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
