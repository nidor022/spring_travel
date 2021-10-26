package com.example.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BookVo;
import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.domain.ReviewVo;
import com.example.domain.UserVo;
import com.example.mapper.BookMapper;
import com.example.mapper.HostMapper;
import com.example.mapper.ImagesMapper;
import com.example.mapper.ReviewMapper;
import com.example.mapper.UserMapper;

import lombok.extern.java.Log;

@Service
@Log
@Transactional
public class HostService {
	
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private ImagesMapper imagesMapper;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	public void addContent(HostVo hostVo) {
		hostMapper.addContent(hostVo);
	}
	
	public void addContentAndImages(HostVo hostVo, List<ImagesVo> imagesList) {
		hostMapper.addContent(hostVo);
		
		for(ImagesVo imagesVo : imagesList) {
			log.info(imagesVo.toString());
			imagesMapper.addImage(imagesVo);
		}
	}
	
	@Transactional
	public Map<String, Object> getContentInfoForBooking(int num, BookVo bookVo) throws ParseException {
		Map<String, Object> contentInfo = new HashMap<>();
		HostVo hostVo = hostMapper.getContentInfo(num);
		UserVo userVo = userMapper.getMemberById(hostVo.getId());
		
		contentInfo.put("hostVo", hostVo);
		contentInfo.put("userVo", userVo);
		contentInfo.put("imagesVo", imagesMapper.getImageByNoNum(num));
		contentInfo.put("count", reviewMapper.countReviewByNoNum(num));
		List<BookVo> bookList = bookMapper.getBookInfoByNum(num);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
		
		ArrayList<String> strBookList = new ArrayList<>();
		for(BookVo bookVo1 : bookList) {
			String checkIn = bookVo1.getCheckIn();
			String checkOut = bookVo1.getCheckOut();
		
			Date startDate = sdf.parse(checkIn);
			Date endDate = sdf.parse(checkOut);
			Date currentDate = startDate;
			while (currentDate.compareTo(endDate) <= -1) {
				strBookList.add(sdf.format(currentDate));
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
		}
		contentInfo.put("bookList", strBookList);
		
		String score = reviewMapper.getAvgScoreByNoNum(num);
		contentInfo.put("score", score);
		
		String checkIn = bookVo.getCheckIn();
		String checkOut = bookVo.getCheckOut();
	
		Date startDate = sdf.parse(checkIn);
		Date endDate = sdf.parse(checkOut);
		Date currentDate = startDate;
		int days = 0;
		while (currentDate.compareTo(endDate) <= -1) {
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
			days++;
		}
		contentInfo.put("days", days);
		
		return contentInfo;
	}
	
	public HostVo getContent(int num) {
		return hostMapper.getContentInfo(num);
	}
	
	@Transactional
	public Map<String, Object> getContentInfo(int num) throws ParseException {
		Map<String, Object> contentInfo = new HashMap<>();
		
		HostVo hostVo = hostMapper.getContentInfo(num);
		UserVo userVo = userMapper.getMemberById(hostVo.getId());
		
		log.info("userVo : " + userVo);
		contentInfo.put("hostVo", hostVo);
		contentInfo.put("userVo", userVo);
		contentInfo.put("imageList", imagesMapper.getImagesByNoNum(num));
		contentInfo.put("reviewList", reviewMapper.getReviewsByNoNum(num));
		contentInfo.put("reviewListFour", reviewMapper.getReviewsByNoNumFour(num));
		contentInfo.put("count", reviewMapper.countReviewByNoNum(num));
		List<ReviewVo> reviewList = reviewMapper.getReviewsByNoNum(num);
		List<BookVo> bookList = bookMapper.getBookInfoByNum(num);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
		
		ArrayList<String> strBookList = new ArrayList<>();
		for(BookVo bookVo : bookList) {
			String checkIn = bookVo.getCheckIn();
			String checkOut = bookVo.getCheckOut();
		
			Date startDate = sdf.parse(checkIn);
			Date endDate = sdf.parse(checkOut);
			Date currentDate = startDate;
			while (currentDate.compareTo(endDate) <= -1) {
				strBookList.add(sdf.format(currentDate));
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
		}
		contentInfo.put("bookList", strBookList);
		contentInfo.put("score", reviewMapper.getAvgScoreByNoNum(num));
		
		return contentInfo;
	}
	
	@Transactional
	public List<HostVo> getContentInfoForMain() {
		List<HostVo> hostList = new ArrayList<HostVo>();
		hostList.add(hostMapper.getContentInfoForMain("아파트"));
		hostList.add(hostMapper.getContentInfoForMain("주택"));
		hostList.add(hostMapper.getContentInfoForMain("독특한 숙소"));
		hostList.add(hostMapper.getContentInfoForMain("부티크 호텔"));
		
		for(HostVo hostVo : hostList) {
			hostVo.setImageVo(imagesMapper.getImageByNoNum(hostVo.getNum()));
		}
		
		return hostList;
	}
	
	@Transactional
	public int updateContentInfo(HostVo hostVo, String type) {
		if(type.equals("houseType")) {
			String classification = hostVo.getClassification();
			String houseType = hostVo.getHouseType();
			String stayType = hostVo.getStayType();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setClassification(classification);
			hostVo.setHouseType(houseType);
			hostVo.setStayType(stayType);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("personAndBed")) {
			int countOfPerson = hostVo.getCountOfPerson();
			int countOfBedroom = hostVo.getCountOfBedroom();
			int countOfBed = hostVo.getCountOfBed();
			int countOfSofeBed = hostVo.getCountOfSofeBed();
			int countOfSofe = hostVo.getCountOfSofe();
			int countOfBlanket = hostVo.getCountOfBlanket();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setCountOfPerson(countOfPerson);
			hostVo.setCountOfBedroom(countOfBedroom);
			hostVo.setCountOfBed(countOfBed);
			hostVo.setCountOfSofeBed(countOfSofeBed);
			hostVo.setCountOfSofe(countOfSofe);
			hostVo.setCountOfBlanket(countOfBlanket);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("bathroom")) {
			int countOfBathroom = hostVo.getCountOfBathroom();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setCountOfBathroom(countOfBathroom);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("address")) {
			String postcode = hostVo.getPostcode();
			String address1 = hostVo.getAddress1();
			String address2 = hostVo.getAddress2();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setPostcode(postcode);
			hostVo.setAddress1(address1);
			hostVo.setAddress2(address2);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("amenities")) {
			String amenities = hostVo.getAmenities();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setAmenities(amenities);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("safety")) {
			String safety = hostVo.getSafety();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setSafety(safety);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("usefull")) {
			String usefull = hostVo.getUsefull();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setUsefull(usefull);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("hostComment")) {
			String hostComment = hostVo.getHostComment();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setHostComment(hostComment);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("cost")) {
			int cost = hostVo.getCost();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setCost(cost);
			
			return hostMapper.updateContentInfo(hostVo);
		} else if(type.equals("title")) {
			String title = hostVo.getTitle();
			
			hostVo = hostMapper.getContentInfo(hostVo.getNum());
			hostVo.setTitle(title);
			
			return hostMapper.updateContentInfo(hostVo);
		}
		return -1;
	}
	
	@Transactional
	public void updateAddImagesAndDelImages(
		List<ImagesVo> imagesList, List<Integer> delFileNums) {
		for(ImagesVo imagesVo: imagesList) {
			imagesMapper.addImage(imagesVo);
		}
		
		if(delFileNums != null)
			imagesMapper.deleteImagesByNums(delFileNums);
	}
	
	public void deleteContentAndImages(int num) {
		hostMapper.deleteContentInfo(num);
		
		imagesMapper.deleteImagesByNoNum(num);
	}
}
