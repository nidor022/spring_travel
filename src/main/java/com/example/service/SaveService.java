package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.domain.SaveVo;
import com.example.mapper.HostMapper;
import com.example.mapper.ImagesMapper;
import com.example.mapper.ReviewMapper;
import com.example.mapper.SaveMapper;

import lombok.extern.java.Log;

@Log
@Transactional
@Service
public class SaveService {
	
	@Autowired 
	private SaveMapper saveMapper;
	
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private ImagesMapper imagesMapper;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	public int addSave(SaveVo saveVo) {
		return saveMapper.addSave(saveVo);
	}
	
	public List<SaveVo> getSaveInfo(String id) {
		return saveMapper.getSaveInfo(id);
	}
	
	@Transactional
	public List<HostVo> getContentInfoForSaveList(String id) {
		List<SaveVo> saveList = saveMapper.getSaveInfo(id);
		
		List<HostVo> hostList = new ArrayList<HostVo>();
		
		for(SaveVo saveVo : saveList) {
			ImagesVo imagesVo = imagesMapper.getImageByNoNum(saveVo.getHostNum());
			HostVo hostVo = hostMapper.getContentInfo(saveVo.getHostNum());
			
			String score = reviewMapper.getAvgScoreByNoNum(hostVo.getNum()) == null ? "0": reviewMapper.getAvgScoreByNoNum(hostVo.getNum());
			double doScore = Double.parseDouble(score);
			doScore = Double.isNaN(doScore) ? 0.0 : doScore;
			int reviewCount = reviewMapper.countReviewByNoNum(hostVo.getNum());
			
			hostVo.setScore(doScore);
			hostVo.setImageVo(imagesVo);
			hostVo.setReviewCount(reviewCount);
			hostVo.setHostComment(hostVo.getHostComment().replace("\n", "<br>"));
			hostVo.setSaveVo(saveVo);
			hostList.add(hostVo);
		}
		
		return hostList;
	}
	
	public int isExistSaveInfo(int hostNum, String id) {
		return saveMapper.isExistSaveInfo(hostNum, id);
	}
	
	public int countSaveById(String id) {
		return saveMapper.countSaveById(id);
	}
	
	public void updateSaveInfo(SaveVo saveVo) {
		saveMapper.updateSaveInfo(saveVo);
	}
	
	@Transactional
	public Map<String, Object> deleteSaveInfo(int hostNum, String id) {
		int num = saveMapper.getSaveNum(hostNum, id);
		int deleteNum = saveMapper.deleteSaveInfo(num);
		
		int count = countSaveById(id);
		
		Map<String, Object> deleteInfo = new HashMap<String, Object>();
		deleteInfo.put("saveCount", count);
		deleteInfo.put("deleteNum", deleteNum);
		
		return deleteInfo;
	}
}
