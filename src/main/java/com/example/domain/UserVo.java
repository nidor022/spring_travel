package com.example.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class UserVo {
	private String id;
	private String password;
	private String name;
	private String email;
	private String tel;
	private String uuid;
	private String filename;
	private String uploadpath;
	private Timestamp regDate;
}
