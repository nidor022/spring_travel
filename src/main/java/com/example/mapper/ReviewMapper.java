package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.ReviewVo;

public interface ReviewMapper {
	
	public void addReview(ReviewVo reviewVo);
	
	public ReviewVo getReviewInfo(int num);
	
	public List<ReviewVo> getReviewsByNoNumFour(int noNum);
	
	public List<ReviewVo> getReviewsByNoNum(int noNum);
	
	public List<ReviewVo> getReviews();
	
	public List<ReviewVo> getReviewsById(@Param("id") String id, @Param("startRow") int startRow);
	
	public String getAvgScoreByNoNum(int noNum);
	
	public int countReviewByNoNum(int noNum);
	
	public int countReviewById(String id);
	
	public int updateReviewInfo(ReviewVo reviewVo);
	
	public int deleteReviewInfo(int num);
}
