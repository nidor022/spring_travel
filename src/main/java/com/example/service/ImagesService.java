package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.ImagesVo;
import com.example.mapper.ImagesMapper;

import lombok.extern.java.Log;

@Service
@Log
@Transactional
public class ImagesService {
	
	@Autowired
	private ImagesMapper imagesMapper;
	
	public void addImage(ImagesVo imagesVo) {
		imagesMapper.addImage(imagesVo);
	}
	
	public ImagesVo getImageByNum(int num) {
		return imagesMapper.getImageByNum(num);
	}
	
	public ImagesVo getImageByNoNum(int noNum) {
		return imagesMapper.getImageByNoNum(noNum);
	}
	
	public List<ImagesVo> getImagesByNoNum(int num){
		return imagesMapper.getImagesByNoNum(num);
	}
}
