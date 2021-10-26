package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.domain.HostVo;
import com.example.domain.LocationVo;
import com.example.domain.ReviewVo;
import com.example.service.LocationService;

import lombok.extern.java.Log;

@Controller
@Log
public class HomeController {
	
	@Autowired
	private LocationService locationService;
	
	@GetMapping("/")
	public String main(Model model) {
		Map<String, Object> obj = locationService.getLocationListAndMainInfo();

		List<LocationVo> locationList = (List<LocationVo>) obj.get("locationList");
		List<ReviewVo> reviewList = (List<ReviewVo>) obj.get("reviewList");
		List<HostVo> hostList = (List<HostVo>) obj.get("hostList");

		ArrayList<String> strLocationList = new ArrayList();
		for (LocationVo locationVo : locationList) {
			strLocationList.add(locationVo.getLocation());
		}

		model.addAttribute("reviewList", reviewList);
		model.addAttribute("locationList", strLocationList);
		model.addAttribute("hostList", hostList);
		
		return "index";
	}
}
