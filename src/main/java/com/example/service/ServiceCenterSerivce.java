package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.FaqVo;
import com.example.domain.QnaVo;
import com.example.mapper.ServiceCenterMapper;

import lombok.extern.java.Log;

@Service
@Log
public class ServiceCenterSerivce {

	@Autowired
	private ServiceCenterMapper serviceCenterMapper;
	
	// faq
	
	public void addFaqContent(FaqVo faqVo) {
		serviceCenterMapper.addFaqContent(faqVo);
	}
	
	public List<FaqVo> getFaqContents(int startRow) {
		return serviceCenterMapper.getFaqContents(startRow);
	}
	
	public int getFaqCountAll() {
		return serviceCenterMapper.getFaqCountAll();
	}
	
	public FaqVo getFaqContentByNum(int num) {
		return serviceCenterMapper.getFaqContentByNum(num);
	}
	
	public void updateFaqReadcount(int num) {
		serviceCenterMapper.updateFaqReadcount(num);
	}
	
	public void updateFaqContent(FaqVo faqVo) {
		serviceCenterMapper.updateFaqContent(faqVo);
	}
	
	public void deleteFaqContent(int num) {
		serviceCenterMapper.deleteFaqContent(num);
	}
	
	// Qna
	
	public void addQnaContent(QnaVo qnaVo) {
		serviceCenterMapper.addQnaContent(qnaVo);
	}
	
	public List<QnaVo> getQnaContents(int startRow) {
		return serviceCenterMapper.getQnaContents(startRow);
	}
	
	public int getQnaCountAll() {
		return serviceCenterMapper.getQnaCountAll();
	}
	
	public QnaVo getQnaContentByNum(int num) {
		return serviceCenterMapper.getQnaContentByNum(num);
	}
	
	public List<QnaVo> getQnaContentByRef(int num) {
		return serviceCenterMapper.getQnaContentByRef(num);
	}
	
	public int updateQnaContent(QnaVo qnaVo) {
		return serviceCenterMapper.updateQnaContent(qnaVo);
	}
	
	@Transactional
	public boolean updateQnaReplyContent(int num, String content) {
		QnaVo qnaVo = serviceCenterMapper.getQnaContentByNum(num);
		log.info("qnaVo : " + qnaVo);
		qnaVo.setContent(content);
		
		int updateNum = serviceCenterMapper.updateQnaContent(qnaVo);
		if(updateNum == 1)
			return true;
		else 
			return false;
	}
	
	@Transactional
	public boolean addQnaReply(int reRef, QnaVo addVo) {
		QnaVo updateVo = serviceCenterMapper.getQnaContentByNum(reRef);
		updateVo.setStatus("답변완료");
		int updateNum = serviceCenterMapper.updateQnaContent(updateVo);
		
		int addNum = serviceCenterMapper.addQnaContent(addVo);
		
		if((updateNum + addNum) == 2)
			return true;
		else
			return false;
	}
	
	public int deleteQnaContent(int num) {
		return serviceCenterMapper.deleteQnaContent(num);
	}
	
	@Transactional
	public boolean deleteQnaContent(int num, int reRef) {
		QnaVo qnaVo = getQnaContentByNum(reRef);
		qnaVo.setStatus("답변대기");
		int updateCheck = updateQnaContent(qnaVo);
		int deleteCheck = serviceCenterMapper.deleteQnaContent(num);
		
		if(updateCheck + deleteCheck >= 2)
			return true;
		return false;
	}
}
