package com.example.mapper;

import java.util.List;

import com.example.domain.FaqVo;
import com.example.domain.QnaVo;

public interface ServiceCenterMapper {
	
	// Faq
	
	public void addFaqContent(FaqVo faqVo);
	
	public int getFaqCountAll();
	
	public List<FaqVo> getFaqContents(int startRow);
	
	public FaqVo getFaqContentByNum(int num);
	
	public void updateFaqReadcount(int num);
	
	public void updateFaqContent(FaqVo faqVo);
	
	public void deleteFaqContent(int num);
	
	// Qna
	
	public int addQnaContent(QnaVo qnaVo);
	
	public int getQnaCountAll();
	
	public List<QnaVo> getQnaContents(int startRow);
	
	public List<QnaVo> getQnaContentByRef(int num);
	
	public QnaVo getQnaContentByNum(int num);
	
	public int updateQnaContent(QnaVo qnaVo);
	
	public int deleteQnaContent(int num);
}
