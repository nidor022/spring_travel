package com.example.controller;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.domain.HostVo;
import com.example.domain.PageDto;
import com.example.domain.ReviewVo;
import com.example.domain.UserVo;
import com.example.service.ReviewService;
import com.example.service.UserService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/join")
	public void join() {
		log.info("get - join() 호출됨");
	}
	
	@PostMapping("/join")
	@ResponseBody
	public Map<String, Object> join(UserVo userVo) {
		log.info("POST - join() 호출됨");
        
		// 비번 암호화시켜서 저장
		String pass = userVo.getPassword();
		String hashedPwd = BCrypt.hashpw(pass, BCrypt.gensalt());
		log.info("hashedPwd :" +hashedPwd);
		userVo.setPassword(hashedPwd);
		
		// 회원가입 날짜 설정
		userVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		log.info("userVo : " + userVo);
		
		// 회원가입 처리
		int check = userService.addMember(userVo);
		Map<String, Object> userAddCheck = new HashMap<>();
		
		if(check >= 1)
			userAddCheck.put("isSuccess", true);
		else
			userAddCheck.put("isSuccess", false);
		
		return userAddCheck;
		
	}
	
	
	@GetMapping(value = "/ajax/joinIdDupChk", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public Map<String, Boolean> ajaxJoinIdDupChk(String id) {
		
		int count = userService.getCountById(id);

		Map<String, Boolean> map = new HashMap<>();
		if (count == 0) {
			map.put("isIdDup", false);
		} else { // count == 1
			map.put("isIdDup", true);
		}
		
		return map;
	}
	
	@GetMapping("/find")
    public String find() {
        return "/user/find";
    }
	
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}
	
	@PostMapping("/login")
	@ResponseBody
	public int login(String id, String password) {
			
		return userService.userCheck(id, password);
	} // login
	
	@PostMapping("loginSuccess") 
	public ResponseEntity<String> loginSuccess(
			HttpServletResponse response, 
			HttpSession session,
			String url,
			boolean keepLogin, String id) {
		
		session.setAttribute("id", id);
		log.info("session id : " + session.getAttribute("id"));
		if (keepLogin) { // keepLogin == true
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(60 * 10);  // 60 * 10 / 쿠키 유효시간 10분
			cookie.setPath("/");

			response.addCookie(cookie);
		}
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", url); // 리다이렉트 경로를 Location으로 설정
		// 리다이렉트일 경우는 HttpStatus.FOUND 를 지정해야 함
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	}
	
	@GetMapping("/logout")
	public String postLogout(HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		
		log.info("Testing.postLogout() 호출됨");
		
		// 세션 초기화
		session.invalidate();
		
		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					cookie.setMaxAge(0); // 유효시간 0
					cookie.setPath("/"); // 경로는 생성할때와 동일하게 설정해야 삭제됨
					
					response.addCookie(cookie); // 삭제할 쿠키정보를 추가
				}
			}
		}
		
		return "redirect:/";
	} // logout

	
	@GetMapping("/show")
	public String show(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		
		Map<String, Object> userInfo = userService.getMemberInfoByIdForReviews(id);
		
		UserVo userVo = (UserVo) userInfo.get("userVo");
		int cntOfReview = (int) userInfo.get("cntOfReview");
		int cntOfHost = (int) userInfo.get("cntOfHost");
		
		model.addAttribute("userVo", userVo);
		model.addAttribute("cntOfReview", cntOfReview);
		model.addAttribute("cntOfHost", cntOfHost);
		return "/user/userShow";
	}
	
	@GetMapping("/MyReviews")
	public String reviewList(Model model, HttpSession session,
			@RequestParam(defaultValue = "1") int pageNum) {
		String id = (String) session.getAttribute("id");
		
		Map<String, Object> userInfo = userService.getMemberInfoByIdForReviews(id);
		UserVo userVo = (UserVo) userInfo.get("userVo");
		int count = (int) userInfo.get("cntOfReview");
		
		//=====================================
		// 한 페이지에 해당하는 글목록 구하는 작업
		//=====================================
		
		// 한페이지당 보여줄 글갯수 설정
		int pageSize = 5;
		
		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;
		
		List<ReviewVo> reviewList = null;
		if(count > 0)
			reviewList = reviewService.getContentForReviewList(id, startRow);
	
		//=====================================
		// 페이지블록 관련 정보 구하기 작업
		//=====================================
		
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
		
		model.addAttribute("userVo", userVo);
		model.addAttribute("mPageDto", mPageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("reviewList", reviewList);
		
		return "/user/myReviews";
	}
	
	@GetMapping("/MyHosts")
	public String hostList(Model model, HttpSession session,
			@RequestParam(defaultValue = "1") int pageNum) {
		String id = (String) session.getAttribute("id");
		
		// 한페이지당 보여줄 글갯수 설정
		int pageSize = 5;
		
		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;
		
		Map<String, Object> userInfo = userService.getMemberInfoByIdForHosts(id, startRow);
		UserVo userVo = (UserVo) userInfo.get("userVo");
		int count = (int) userInfo.get("cntOfHost");
		
		//=====================================
		// 한 페이지에 해당하는 글목록 구하는 작업
		//=====================================
		List<HostVo> hostList = null;
		if(count > 0)
			hostList = (List<HostVo>) userInfo.get("hostList");
	
		//=====================================
		// 페이지블록 관련 정보 구하기 작업
		//=====================================
		
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
		
		model.addAttribute("userVo", userVo);
		model.addAttribute("mPageDto", mPageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("hostList", hostList);
		
		return "/user/myHosts";
	}
	
	@PostMapping("/saveImage")
	@ResponseBody
	public Map<String, Object> saveImage(
			HttpServletRequest request,
			HttpSession session,
			@RequestParam("filename") MultipartFile multipartFile) throws Exception {
		String id = (String) session.getAttribute("id");
		
		
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/"); // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);
		
		String strDate = this.getFolder();
		
		File dir = new File(realPath + "/upload", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		UserVo userVo = userService.getMemberById(id);
		
		if(userVo.getFilename() != null) {
			String path = realPath + "/upload/" + userVo.getUploadpath();
			String file = userVo.getUuid() +"_" + userVo.getFilename();
			File delFile = new File(path, file);
			if (delFile.exists()) {
				delFile.delete();
			}
		}
		
		int check = 0;
		
		if(multipartFile != null) {
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
			
			userVo.setUuid(strUuid);
			userVo.setFilename(filename);
			userVo.setUploadpath(strDate);
			
			check = userService.update(userVo);
		}
		Map<String, Object> checkDate = new HashMap<>();
		if(check >= 1) {
			checkDate.put("isSuccess", true);
			checkDate.put("uuid", userVo.getUuid());
			checkDate.put("filename", userVo.getFilename());
			checkDate.put("uploadpath", userVo.getUploadpath());
		}
		else
			checkDate.put("isSuccess", false);
		
		return checkDate;
		
	}
	
	// 오늘 날짜 형식의 폴더 문자열 가져오기
	private String getFolder() {
		// 오늘날짜 년월일 폴더가 존재하는지 확인해서 없으면 생성하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String strDate = sdf.format(date); // 2020/11/11
		
		return strDate;
	}
	
	@PostMapping("/saveName")
	@ResponseBody
	public Map<String, Object> saveName(HttpServletRequest request,
			HttpSession session,
			String name) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String id = (String) session.getAttribute("id");
		
		UserVo userVo = userService.getMemberById(id);
		userVo.setName(name);
		
		// 정보 업데이트
		int check = userService.update(userVo);
		
		Map<String, Object> checkInfo = new HashMap<>();
		if(check >= 1) {
			checkInfo.put("isSuccess", true);
			checkInfo.put("name", userVo.getName());
		} else 
			checkInfo.put("isSuccess", false);
		
		return checkInfo;	
	}
	
	@PostMapping("/saveTel")
	@ResponseBody
	public Map<String, Object> saveTel(HttpServletRequest request,
			HttpSession session,
			String tel) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String id = (String) session.getAttribute("id");
		
		UserVo userVo = userService.getMemberById(id);
		userVo.setTel(tel);
		
		// 정보 업데이트
		int check = userService.update(userVo);
		
		Map<String, Object> checkInfo = new HashMap<>();
		if(check >= 1) {
			checkInfo.put("isSuccess", true);
			checkInfo.put("tel", userVo.getTel());
		} else 
			checkInfo.put("isSuccess", false);
		
		return checkInfo;	
	}
	
	@GetMapping("/pwdChk")
	@ResponseBody
	public Map<String, Object> pwdChk(HttpSession session, String password) {
		String id = (String) session.getAttribute("id");
		
		int check = userService.userCheck(id, password);
		String comment = "";
		boolean isCoincide = false;
		switch(check) {
		case -1:
		case 0:
			comment = "일치하지 않는 비밀번호입니다.";
			isCoincide = false;
			break;
			
		case 1:
			comment = "비밀번호가 일치합니다.";
			isCoincide = true;
			break;
		}
		
		Map<String, Object> checkInfo = new HashMap<>();
		checkInfo.put("isCoincide", isCoincide);
		checkInfo.put("comment", comment);
		
		return checkInfo;
	}
	
	@PostMapping("/savePwd")
	@ResponseBody
	public Map<String, Object> savePwd(HttpSession session, String password) {
		String id = (String) session.getAttribute("id");
		UserVo userVo = userService.getMemberById(id);
		
		String hashedPwd = BCrypt.hashpw(password, BCrypt.gensalt());
		log.info("hashedPwd :" +hashedPwd);
		userVo.setPassword(hashedPwd);
		
		int check = userService.update(userVo);
		
		Map<String, Object> checkInfo = new HashMap<>();
		checkInfo.put("isSuccess", check);
		
		return checkInfo;
	}
	
	@GetMapping("/delete")
	public String deleteUser(HttpSession session, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String id = (String) session.getAttribute("id");
		String url;
		
		int check = userService.deleteById(id, request);
		
		if(check >= 1) {
			session.invalidate();
			
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("id")) {
						cookie.setMaxAge(0); // 유효시간 0
						cookie.setPath("/"); // 경로는 생성할때와 동일하게 설정해야 삭제됨
						
						response.addCookie(cookie); // 삭제할 쿠키정보를 추가
					}
				}
			}
			url = "redirect:/";
		} else {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('다시 시도해주세요.');</script>");
            out.flush();
			url = "/user/show";
		}
		return url;
	}
}









