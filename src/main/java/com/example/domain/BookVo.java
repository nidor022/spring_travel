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
public class BookVo {
	private int num;
	private String id;
	private int cost;
	private String checkIn;
	private String checkOut;
	private int cntOfPerson;
	private int noNum;
	private Timestamp regDate;
	
	private HostVo hostVo;
}
