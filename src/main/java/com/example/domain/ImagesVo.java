package com.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class ImagesVo {
	private int num;
	private String uuid;
	private String filename; 	// 실제 업로드된 파일명
	private String uploadpath; 	// 실제 업로드된 폴더 경로
	private int noNum;		 	// notice 테이블의 글번호 num
}
