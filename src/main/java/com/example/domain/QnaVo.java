package com.example.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class QnaVo {
	private int num;
	private String status;
	private String type;
	private String id;
	private String subject;
	private String content;
	private int reRef;
	private int reLev;
	private Timestamp regDate;
}
