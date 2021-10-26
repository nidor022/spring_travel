package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.HostVo;
import com.example.domain.LocationVo;
import com.example.mapper.HostMapper;
import com.example.mapper.ImagesMapper;
import com.example.mapper.LocationMapper;
import com.example.mapper.ReviewMapper;

@Service
public class SearchService {
	
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private ImagesMapper imagesMapper;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private LocationMapper locationMapper;
	
	@Transactional
	public Map<String, Object> getSearchResult(String location, int cntOfPerson, int pageNum) {
		Map<String, Object> searchResult = new HashMap<String, Object>();
		int count = hostMapper.getContentCount(location, cntOfPerson);
		List<HostVo> hostList = null;
		int pageSize = 5; 
		int startRow = (pageNum - 1) * pageSize;
		
		if(count > 0) {
			hostList = hostMapper.getContentsByAddress(location, cntOfPerson, startRow);
			
			for(int i=0;i<hostList.size();i++) {
				hostList.get(i).setImageVo(imagesMapper.getImageByNoNum(hostList.get(i).getNum()));
				String score = reviewMapper.getAvgScoreByNoNum(hostList.get(i).getNum()) == null ? "0": reviewMapper.getAvgScoreByNoNum(hostList.get(i).getNum());
				hostList.get(i).setScore(Double.parseDouble(score));
			}
		}
		searchResult.put("count", count);
		searchResult.put("hostList", hostList);
		
		return searchResult;
	}
	
	// 지역별 위도 경도
	public LocationVo getLocationListById(String address) {
		return locationMapper.getLocationListByAd(address);
	}
	
}
