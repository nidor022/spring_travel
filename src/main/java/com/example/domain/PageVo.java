package com.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class PageVo {
	private int pageNum;
	private String address;
	private String checkIn;
	private String checkOut;
	private int cntOfPerson;
}
