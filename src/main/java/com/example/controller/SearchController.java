package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.HostVo;
import com.example.domain.LocationVo;
import com.example.domain.PageDto;
import com.example.service.SearchService;

@Controller

@RequestMapping("/search/*")
public class SearchController {
	
	@Autowired
	private SearchService searchService; 
	
	@GetMapping("/result")
	public String result(
			// 기본데이터타입인 int의 경우 요청파라미터가 존재하지 않을때 null을 반환하기때문에 defaultValue를 지정해주어야 함
			@RequestParam(defaultValue = "1") int pageNum,  
			@ModelAttribute("address") String address,
			@ModelAttribute("checkIn") String checkIn, 
			@ModelAttribute("checkOut") String checkOut,
			@ModelAttribute("cntOfPerson") int cntOfPerson,
			Model model) {
		Map<String, Object> searchResult = searchService.getSearchResult(address, cntOfPerson, pageNum);
		int count = (int) searchResult.get("count");
		List<HostVo> hostList = (List<HostVo>) searchResult.get("hostList");
		
		LocationVo locationVo = searchService.getLocationListById(address);
		
		
	
		
		
		int pageSize = 5;
		
		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;
		
		PageDto mPageDto = new PageDto();
		if (count > 0) {
			// 총 필요한 페이지 갯수 구하기
			// 글50개. 한화면에보여줄글 10개 => 50/10 = 5 
			// 글55개. 한화면에보여줄글 10개 => 55/10 = 5 + 1페이지(나머지존재) => 6
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			//int pageCount = (int) Math.ceil((double) count / pageSize);
			
			// 한 화면에 보여줄 페이지갯수 설정
			int pageBlock = 5;
			
			// 화면에 보여줄 시작페이지번호 구하기
			// 1~5          6~10          11~15          16~20       ...
			// 1~5 => 1     6~10 => 6     11~15 => 11    16~20 => 16
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
			
			// 화면에 보여줄 끝페이지번호 구하기
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			
			// 뷰에서 필요한 데이터를 PageDto에 저장
			mPageDto.setCount(count);
			mPageDto.setPageCount(pageCount);
			mPageDto.setPageBlock(pageBlock);
			mPageDto.setStartPage(startPage);
			mPageDto.setEndPage(endPage);
		}
		
		model.addAttribute("locationVo",locationVo);
		model.addAttribute("mPageDto", mPageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("hostList", hostList);
		
		return "/search/result";
	}

}
