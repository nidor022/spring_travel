package com.example.controller;

import java.util.HashMap;
import java.util.List;
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

import com.example.domain.BookVo;
import com.example.domain.HostVo;
import com.example.domain.SaveVo;
import com.example.service.BookService;
import com.example.service.SaveService;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping("/travel/*")
public class TravelController {
	
	@Autowired
	private SaveService saveService;
	
	@Autowired
	private BookService bookService;
	
	@GetMapping("/history")
	public String appointment(@RequestParam(defaultValue = "pay") String viewType,
			HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		List<BookVo> bookList = bookService.getBooksAndHostVoById(id);
		List<HostVo> hostList = saveService.getContentInfoForSaveList(id);
		
		model.addAttribute("bookList", bookList);
		model.addAttribute("hostList", hostList);
		model.addAttribute("viewType", viewType);
		return "/travel/appointment";
	}
	
	@PostMapping("/cancel")
	@ResponseBody
	public Map<String, Object> cancel(int num) {
		int check = bookService.deleteBookInfo(num);
		
		Map<String, Object> checkInfo = new HashMap<>();
		if(check >= 1)
			checkInfo.put("isSuccess", true);
		else
			checkInfo.put("isSuccess", false);
		
		return checkInfo;
	}
	
	@GetMapping("/isExist")
	@ResponseBody // JSON으로 반환 시켜줌
	public int isExistSaveInfo(int hostNum, String id){
		int count = saveService.isExistSaveInfo(hostNum, id);
		return count;
	}
	
	@GetMapping("/save")
	@ResponseBody // JSON으로 반환 시켜줌
	public int save(SaveVo saveVo) {
		saveVo.setIsSave("Y");
		int count = saveService.addSave(saveVo);
		return count;
	}
	
	@GetMapping("/savelist")
	public String savelist(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		List<HostVo> hostList = saveService.getContentInfoForSaveList(id);
		
		model.addAttribute("hostList", hostList);
		
		return "/travel/saveList";
	}
	
	@GetMapping("/saveDelete")
	@ResponseBody
	public Map<String, Object> saveDelete(HttpSession session, int num, Model model) {
		String id = (String) session.getAttribute("id");
		
		Map<String, Object> deleteInfo = new HashMap<String, Object>();
		deleteInfo = saveService.deleteSaveInfo(num, id);
		
		return deleteInfo;
	}
}