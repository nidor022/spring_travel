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
public class HostVo {
	private int num;
	private String id;
	private String classification;
	private String houseType;
	private String stayType;
	private int countOfPerson;
	private int countOfBedroom;
	private int countOfBed;
	private int countOfSofeBed;
	private int countOfSofe;
	private int countOfBlanket;
	private int countOfBathroom;
	private String postcode;
	private String address1;
	private String address2;
	private String amenities;
	private String safety;
	private String usefull;
	private String hostComment;
	private int cost;
	private String title;
	private Timestamp regDate;
	
	private ImagesVo imageVo;
	private SaveVo saveVo;
	private int reviewCount;
	private double score;
}
