package com.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class PageDto {
	
	// VO(Value Object) : 데이터베이스 테이블과 연관된 값 객체
	// DTO(Data Transfer Object) : 데이터베이스 테이블과 무관한 데이터 전송용도의 값 객체
	
	private int count; // 전체글갯수
	private int pageCount; // 총 필요한 페이지(마지막 페이지번호)
	private int pageBlock; // 페이지블록 당 페이지 갯수
	private int startPage; // 페이지블록 내 시작페이지 번호
	private int endPage; // 페이지블록 내 끝페이지 번호
}
