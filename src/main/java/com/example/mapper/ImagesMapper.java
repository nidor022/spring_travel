package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.ImagesVo;

public interface ImagesMapper {
	
	void addImage(ImagesVo imagesVo);
	
	ImagesVo getImageByNum(int num);
	
	ImagesVo getImageByNoNum(int noNum);
	
	List<ImagesVo> getImagesByNoNum(int noNum);
	
	void deleteImagesByNoNum(int num);
	
	void deleteImagesByNums(@Param("numList") List<Integer> numList);
}
