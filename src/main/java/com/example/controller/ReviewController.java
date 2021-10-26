package com.example.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.domain.ReviewVo;
import com.example.service.ReviewService;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping("/review/*")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("content")
	public String content(int num, 
			@RequestParam(defaultValue = "1") int pageNum, Model model) {
		Map<String, Object> reviewContent=  reviewService.getReviewContent(num);
		ReviewVo reviewVo = (ReviewVo) reviewContent.get("reviewVo");
//		String comment = reviewVo.getComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
//		reviewVo.setComment(comment);
		
		HostVo hostVo = (HostVo) reviewContent.get("hostVo");
//		comment = hostVo.getHostComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
//		hostVo.setHostComment(comment);
		ImagesVo imagesVo = hostVo.getImageVo();
		
		int count = (int) reviewContent.get("count");
		
		model.addAttribute("reviewVo", reviewVo);
		model.addAttribute("hostVo", hostVo);
		model.addAttribute("imagesVo", imagesVo);
		model.addAttribute("count", count);
		model.addAttribute("pageNum", pageNum);
		
		return "/review/review";
	}
	
	@GetMapping("/write")
	public String write(int num, int bookNum, Model model) {
		
		Map<String, Object> reviewContent=  reviewService.getContentInfoForReview(num);
		HostVo hostVo = (HostVo) reviewContent.get("hostVo");
		String comment = hostVo.getHostComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		hostVo.setHostComment(comment);
		
		ImagesVo imagesVo = hostVo.getImageVo();
		int count = (int) reviewContent.get("count");
		
		model.addAttribute("hostVo", hostVo);
		model.addAttribute("bookNum", bookNum);
		model.addAttribute("imagesVo", imagesVo);
		model.addAttribute("count", count);
		
		return "/review/reviewWriteForm";
	}
	
	@PostMapping("/write")
	@ResponseBody
	public int write(HttpSession session, ReviewVo reviewVo) {
		String id = (String) session.getAttribute("id");
		reviewVo.setId(id);
		
		log.info(reviewVo.toString());
		
		int num = reviewService.addReview(reviewVo);
		
		return num;
	}
	
	@GetMapping("/modify")
	public String modify(int num, int pageNum, Model model) {
		Map<String, Object> reviewContent=  reviewService.getReviewContent(num);
		ReviewVo reviewVo = (ReviewVo) reviewContent.get("reviewVo");
		String comment = reviewVo.getComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		reviewVo.setComment(comment);
		
		HostVo hostVo = (HostVo) reviewContent.get("hostVo");
		comment = hostVo.getHostComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		hostVo.setHostComment(comment);
		ImagesVo imagesVo = hostVo.getImageVo();
		
		int count = (int) reviewContent.get("count");
		
		model.addAttribute("reviewVo", reviewVo);
		model.addAttribute("hostVo", hostVo);
		model.addAttribute("imagesVo", imagesVo);
		model.addAttribute("count", count);
		model.addAttribute("pageNum", pageNum);
		
		return "/review/reviewModifyForm";
	}
	
	@PostMapping("/modify")
	@ResponseBody
	public String modify(ReviewVo reviewVo) {
		int count = reviewService.updateReviewInfo(reviewVo);
		if(count == 1)
			return "OK";
		
		return "FALSE"; 
	}
	
	@GetMapping("/delete")
	public String delete(int num, int pageNum, RedirectAttributes rttr) {
		
		int count = reviewService.deleteReviewInfo(num);
		
		rttr.addAttribute("pageNum", pageNum);
		
		return "redirect:/user/MyReviews";
	}
}
