package com.example.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.BookVo;
import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.domain.UserVo;
import com.example.service.BookService;
import com.example.service.HostService;
import com.google.gson.Gson;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/book/*")
@Log
public class BookController {
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private HostService hostService;
	
	@GetMapping("/check")
	public String check(HttpSession session, BookVo bookVo, Model model) throws ParseException {
		String id = (String) session.getAttribute("id");
		
		Map<String, Object> contentInfo = hostService.getContentInfoForBooking(bookVo.getNoNum(), bookVo);
		HostVo hostVo = (HostVo) contentInfo.get("hostVo");
		UserVo userVo = (UserVo) contentInfo.get("userVo");
		bookVo.setId(id);
		
		ImagesVo imagesVo = (ImagesVo) contentInfo.get("imagesVo");
		int count = (int) contentInfo.get("count");
		Double score = Double.parseDouble((String) contentInfo.get("score") == null ? "0": (String) contentInfo.get("score"));
		int days = (int) contentInfo.get("days");
		ArrayList<String> bookList = (ArrayList<String>) contentInfo.get("bookList");
		
		
		model.addAttribute("hostVo", hostVo);
		model.addAttribute("userVo", userVo);
		model.addAttribute("bookVo", bookVo);
		model.addAttribute("imagesVo", imagesVo);
		model.addAttribute("count", count);
		model.addAttribute("score", score);
		model.addAttribute("days", days);
		model.addAttribute("bookList", bookList);
		
		return "/book/checkBook";
	}
	
	@GetMapping("/iamport")
	public void iamport(BookVo bookVo, Model model) {
		log.info("iamport - get()");
		log.info(bookVo.toString());
		model.addAttribute("bookVo", bookVo);
	}
	
	@PostMapping("/iamport")
	@ResponseBody
	public String iamportAjax(BookVo bookVo, Model model) {
		log.info("iamport - post()");
		Gson gson = new Gson();
		
		log.info(bookVo.toString());
		
		int num = bookService.addBook(bookVo);
		String strNum = String.valueOf(num);
		
		return strNum;
	}

	@GetMapping("/complete")
	public String bookList(HttpSession session, int num, Model model) {
		String id = (String) session.getAttribute("id");
		
		BookVo bookVo = bookService.getBookInfoByNumAndId(num, id);
		log.info(bookVo.toString());
		model.addAttribute("bookVo", bookVo);
		
		return "/book/bookList";
	}
}
