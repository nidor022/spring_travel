package com.example.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.domain.PageVo;
import com.example.domain.ReviewVo;
import com.example.domain.UserVo;
import com.example.service.HostService;
import com.example.service.ImagesService;
import com.example.service.MysqlService;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping("/content/*")
public class HostController {
	
	@Autowired
	private MysqlService mysqlService;
	
	@Autowired
	private ImagesService imagesService;
	
	@Autowired
	private HostService hostService;
	
	@GetMapping("/info")
	public String content(int num, Model model, PageVo pageVo) throws ParseException {
		log.info("content() 호출됨");
		Map<String, Object> contentInfo = hostService.getContentInfo(num);
		HostVo hostVo = (HostVo) contentInfo.get("hostVo");
		UserVo userVo = (UserVo) contentInfo.get("userVo");
		
		hostVo.setHostComment(hostVo.getHostComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		List<ImagesVo> imageList = (List<ImagesVo>) contentInfo.get("imageList");
		List<ReviewVo> reviewList = (List<ReviewVo>) contentInfo.get("reviewList");
		List<ReviewVo> reviewListFour = (List<ReviewVo>) contentInfo.get("reviewListFour");
		ArrayList<String> bookList = (ArrayList<String>) contentInfo.get("bookList");
		
		log.info("bookList : " + bookList);
		
		int count = (int) contentInfo.get("count");
		String score = (String) contentInfo.get("score")== null ? "0": (String) contentInfo.get("score");
		double doScore = Double.parseDouble(score);
		doScore = Double.isNaN(doScore) ? 0.0 : doScore;
		
		model.addAttribute("hostVo", hostVo);
		model.addAttribute("userVo", userVo);
		model.addAttribute("imageList", imageList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewListFour", reviewListFour);
		model.addAttribute("count", count);
		model.addAttribute("score", doScore);
		model.addAttribute("bookList", bookList);
		model.addAttribute("pageVo", pageVo);
		return "/content/content";
	}

	@GetMapping("/write")
	public String write() {
		log.info("Get - write() 호출됨");

		return "/content/contentWriteForm";
	}

	@PostMapping("/write")
	public String wrtie(
			HttpSession session,
			HttpServletRequest request,
			HostVo hostVo,
			@RequestParam("filename") List<MultipartFile> multipartFiles) throws Exception {
		log.info("Post - write() 호출됨");
		String id = (String) session.getAttribute("id");

		int num = mysqlService.getNextNum("travel_host");
		
		hostVo.setNum(num);
		hostVo.setId(id);
		hostVo.setAmenities(hostVo.getAmenities() == null ? "" : hostVo.getAmenities());
		hostVo.setSafety(hostVo.getSafety() == null ? "" : hostVo.getSafety());
		hostVo.setUsefull(hostVo.getUsefull() == null ? "" : hostVo.getUsefull());
		log.info("hostVo : " + hostVo);
		
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/"); // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);
		
		String strDate = this.getFolder();
		
		File dir = new File(realPath + "/upload", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		List<ImagesVo> imagesList = new ArrayList<>();
		
		// 임시폴더에 있는걸 파일을 업로드시킴 (application.properties에 설정되어있음)
		for(MultipartFile multipartFile : multipartFiles) {
			// 파일입력상자에서 선택하지 않은 요소는 건너뛰기
			if(multipartFile.isEmpty()) {
				continue;
			}
			
			// 실제 업로드한 파일이름 구하기
			String filename = multipartFile.getOriginalFilename();
			
			// 익스플로러는 파일이름에 경로가 포함되어 있으므로
			// 순수 파일이름만 부분문자열로 가져오기
			// lastIndexOf 없는 값이면 리턴값이 -1임.
			int beginIndex = filename.lastIndexOf("\\") + 1;
			filename = filename.substring(beginIndex);
			
			// 파일명 중복을 피하기 위해서 파일이름 앞에 붙일 uuid 문자열 구하기
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();
			
			// 업로드(생성)할 파일 이름
			String uploadFilename = strUuid + "_" + filename;
			
			// 생성할 파일정보를 File 객체로 준비
			File saveFile = new File(dir, uploadFilename);
			
			// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
			multipartFile.transferTo(saveFile);
			
			ImagesVo imagesVo = new ImagesVo();
			imagesVo.setNoNum(hostVo.getNum());
			
			imagesVo.setUuid(strUuid);
			imagesVo.setFilename(filename);
			imagesVo.setUploadpath(strDate);
			
			imagesList.add(imagesVo);
		}
		
		hostService.addContentAndImages(hostVo, imagesList);
		
		return "redirect:/content/info?num=" + hostVo.getNum();
	}

	@GetMapping("/modify")
	public String modify(int num, 
			@RequestParam(defaultValue = "1") int pageNum, 
			Model model) throws ParseException {
		log.info("modify() - get 호출");
		Map<String, Object> contentInfo = hostService.getContentInfo(num);
		HostVo hostVo = (HostVo) contentInfo.get("hostVo");
		hostVo.setHostComment(hostVo.getHostComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		List<ImagesVo> imageList = (List<ImagesVo>) contentInfo.get("imageList");
		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("hostVo", hostVo);
		model.addAttribute("imageList", imageList);
		model.addAttribute("imageList_size", imageList.size());
		
		return "/content/contentModifyForm";
	}
	
	@PutMapping("/modify")
	@ResponseBody
	public String modify(HostVo hostVo, String type, int num, Model model) {
		log.info("modify() - put 호출");
		hostVo.setNum(num);
		int count = hostService.updateContentInfo(hostVo, type);
		if(count == 1)
			return "OK";
		
		return "FALSE";
	}
	
	@PostMapping("/modify")
	public String modify(HttpServletRequest request, 
			int num,
			int pageNum,
			// name속성이 filename인 것들만 가져옴.
			@RequestParam(required = false, value = "filename") List<MultipartFile> multipartFiles,
			// delfile로 넘어오는 파일을 배열에 담음
			@RequestParam(required = false, value = "delfile") List<Integer> delFileNums,
			RedirectAttributes rttr) throws Exception {
		
		log.info("modify() - post 호출");
		
		// ===================== 파일 업로드를 위한 ㅊ폴더 준비===========================
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/"); // webapp 폴더의 실제경로
//		log.info("realPath : " + realPath);
		
		String strDate = this.getFolder();
		
		File dir = new File(realPath + "/upload", strDate);
//		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}
		// ===================== MultipartFile을 이용해 신규파일 업로드 수행 ===========================

		// ImagesVo 첨부파일정보 담을 리스트 준비
		List<ImagesVo> addImages = new ArrayList<>();
		
		if(multipartFiles != null) {
			// 임시폴더에 있는걸 파일을 업로드시킴 (application.properties에 설정되어있음)
			for(MultipartFile multipartFile : multipartFiles) {
				// 파일입력상자에서 선택하지 않은 요소는 건너뛰기
				if(multipartFile.isEmpty()) {
					continue;
				}
				
				// 실제 업로드한 파일이름 구하기
				String filename = multipartFile.getOriginalFilename();
				
				// 익스플로러는 파일이름에 경로가 포함되어 있으므로
				// 순수 파일이름만 부분문자열로 가져오기
				// lastIndexOf 없는 값이면 리턴값이 -1임.
				int beginIndex = filename.lastIndexOf("\\") + 1;
				filename = filename.substring(beginIndex);
				
				// 파일명 중복을 피하기 위해서 파일이름 앞에 붙일 uuid 문자열 구하기
				UUID uuid = UUID.randomUUID();
				String strUuid = uuid.toString();
				
				// 업로드(생성)할 파일 이름
				String uploadFilename = strUuid + "_" + filename;
				
				// 생성할 파일정보를 File 객체로 준비
				File saveFile = new File(dir, uploadFilename);
				
				// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
				multipartFile.transferTo(saveFile);
				
				// ===================== 첨부파일 AttachVo 준비하기 ===========================
				ImagesVo imagesVo = new ImagesVo();
				// 게시판 글번호 설정
				imagesVo.setNoNum(num);
				
				imagesVo.setUuid(strUuid);
				imagesVo.setFilename(filename);
				imagesVo.setUploadpath(strDate);
				
				// 트랜잭션 처리를 위해 attachVo를 리스트에 추가해서 모우기 
				addImages.add(imagesVo);
			}
		}
		// ================= delFileNums 로 첨부파일 삭제작업 수행================
		log.info("delFileNums : " + delFileNums );
		if(delFileNums != null) {
			for (int delNum : delFileNums) {
				// 첨부파일 번호에 해당하는 첨부파일 정보 한개를 VO로 가져오기
				ImagesVo imagesVo = imagesService.getImageByNum(delNum);
				
				//파일정보로 실제파일 존재여부 확인해서 삭제하기
				String path = realPath + "/upload/" + imagesVo.getUploadpath();
				String file = imagesVo.getUuid() +"_" + imagesVo.getFilename();
				File delFile = new File(path, file);
				if (delFile.exists()) {
					delFile.delete();
				}
			}
		}
		
//		hostService.updateContentInfo(hostVo, type);
		hostService.updateAddImagesAndDelImages(addImages, delFileNums);
		
		rttr.addAttribute("num", num);
		rttr.addAttribute("pageNum", pageNum);
		return "redirect:/content/modify";
	}
	
	@GetMapping("/delete")
	public String delete(int num, int pageNum, HttpServletRequest request, RedirectAttributes rttr) {
		List<ImagesVo> imageList = imagesService.getImagesByNoNum(num);
		
		// application 객체 참조 가져오기
		ServletContext application = request.getServletContext();
		
		// 업로드 기준 경로
		String realPath = application.getRealPath("/"); // webapp  경로
		
		// 첨부파일 삭제하기
		for(ImagesVo imagesVo : imageList) {
			String dir = realPath + "/upload/" + imagesVo.getUploadpath();
			String filename = imagesVo.getUuid()+ "_" + imagesVo.getFilename();
			
			// 삭제할 파일을 File 타입 객체로 준비
			File file = new File(dir, filename);

			// 파일 존재 확인 후 삭제하기
			if (file.exists()) {
				file.delete();
			}
		}
		
		hostService.deleteContentAndImages(num);

		rttr.addAttribute("pageNum", pageNum);
		// 삭제 시 자기가 등록한 호스트 목록보기로 이동
		return "redirect:/user/MyHosts";
	}
	
	// 오늘 날짜 형식의 폴더 문자열 가져오기
	private String getFolder() {
		// 오늘날짜 년월일 폴더가 존재하는지 확인해서 없으면 생성하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String strDate = sdf.format(date); // 2020/11/11
		
		return strDate;
	}
}
