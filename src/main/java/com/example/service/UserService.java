package com.example.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.domain.UserVo;
import com.example.mapper.BookMapper;
import com.example.mapper.HostMapper;
import com.example.mapper.ImagesMapper;
import com.example.mapper.ReviewMapper;
import com.example.mapper.SaveMapper;
import com.example.mapper.UserMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 이 클래스의 모든 메소드가 각각 한개의 트랜잭션 단위로 수행됨
public class UserService {

	// 스프링 빈으로 등록된 객체들 중에서
	// 타입으로 객체의 참조를 가져와서 참조변수에 저장해줌
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private ReviewMapper reviewMapper;

	@Autowired
	private HostMapper hostMapper;

	@Autowired
	private ImagesMapper imagesMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private SaveMapper saveMapper;

	public Map<String, String> validateHandling(Errors errors) {
		Map<String, String> validatorResult = new HashMap<>();

		for (FieldError error : errors.getFieldErrors()) {
			String validKeyName = String.format("valid_%s", error.getField());
			validatorResult.put(validKeyName, error.getDefaultMessage());
		}

		return validatorResult;
	}

	public UserVo getMemberById(String id) {
		return userMapper.getMemberById(id);
	}

	@Transactional
	public String getMemberByIdAndUpdatePass(String id) {
		double randomVal = Math.random();
		int intVal = (int) (randomVal * 100000000);

		UserVo userVo = userMapper.getMemberById(id);
		userVo.setPassword(String.valueOf(intVal));
		int check = userMapper.update(userVo);

		if (check >= 1)
			return String.valueOf(intVal);
		log.info("임시비밀번호 : " + String.valueOf(intVal));
		return "false";
	}

	@Transactional
	public Map<String, Object> getMemberInfoByIdForReviews(String id) {
		UserVo userVo = userMapper.getMemberById(id);
		int cntOfReview = reviewMapper.countReviewById(id);
		int cntOfHost = hostMapper.countContentsById(id);

		Map<String, Object> userInfo = new HashMap<>();
		userInfo.put("userVo", userVo);
		userInfo.put("cntOfReview", cntOfReview);
		userInfo.put("cntOfHost", cntOfHost);

		return userInfo;
	}

	@Transactional
	public Map<String, Object> getMemberInfoByIdForHosts(String id, int startRow) {
		UserVo userVo = userMapper.getMemberById(id);
		int cntOfHost = hostMapper.countContentsById(id);

		List<HostVo> hostList = hostMapper.getContentsById(id, startRow);
		for (HostVo hostVo : hostList) {
			ImagesVo imagesVo = imagesMapper.getImageByNoNum(hostVo.getNum());
			int count = reviewMapper.countReviewByNoNum(hostVo.getNum());
			hostVo.setImageVo(imagesVo);
			hostVo.setReviewCount(count);
		}

		Map<String, Object> userInfo = new HashMap<>();
		userInfo.put("userVo", userVo);
		userInfo.put("cntOfHost", cntOfHost);
		userInfo.put("hostList", hostList);

		return userInfo;
	}

	public int addMember(UserVo userVo) {
		return userMapper.addMember(userVo);
	}

	public List<UserVo> getAllMembers() {
		List<UserVo> list = userMapper.getAllMembers();
		return list;
	}

	public int userCheck(String id, String password) {
		int check = -1;
		boolean isInt = true;
		char tmp;
		for (int i = 0; i < password.length(); i++) {
			tmp = password.charAt(i);
			if (!('0' <= tmp && tmp <= '9')) {
				isInt = false;
			}
		}

		String dbPasswd = userMapper.userCheck(id);
		if (dbPasswd != null) {
			if (!isInt)
				if (BCrypt.checkpw(password, dbPasswd)) { // 암호화된 비번이랑 입력비번 비교
					check = 1;
				} else {
					check = 0;
				}
			else {
				if(password.equals(dbPasswd)) {
					check = 1;
				} else {
					check = 0;
				}
			}
		} else { // dbPasswd == null
			check = -1;
		}
		return check;
	}

	public int getCountById(String id) {
		int count = userMapper.getCountById(id);
		return count;
	}

	public int update(UserVo userVo) {
		return userMapper.update(userVo);
	}

	@Transactional
	public int deleteById(String id, HttpServletRequest request) {
		// application 객체 참조 가져오기
		ServletContext application = request.getServletContext();
		
		// 업로드 기준 경로
		String realPath = application.getRealPath("/"); // webapp  경로
		
		List<HostVo> hostList = hostMapper.getContentAllById(id);
		
		// 게시물 이미지 삭제
		for(HostVo hostVo : hostList) {
			List<ImagesVo> images = imagesMapper.getImagesByNoNum(hostVo.getNum());
			for(ImagesVo imagesVo : images) {
				
				// 첨부파일 삭제하기
				String dir = realPath + "/upload/" + imagesVo.getUploadpath();
				String filename = imagesVo.getUuid()+ "_" + imagesVo.getFilename();
				
				// 삭제할 파일을 File 타입 객체로 준비
				File file = new File(dir, filename);

				// 파일 존재 확인 후 삭제하기
				if (file.exists()) {
					file.delete();
				}
			}
		}
		
		// 프로필 이미지 삭제
		UserVo userVo = userMapper.getMemberById(id);
		String userDir = realPath + "/upload" + userVo.getUploadpath();
		String userFilename = userVo.getUuid() + "_" + userVo.getFilename();
		
		File file = new File(userDir, userFilename);
		if (file.exists()) {
			file.delete();
		}
	
		for(HostVo hostVo : hostList) {
			imagesMapper.deleteImagesByNoNum(hostVo.getNum());
			bookMapper.deleteBookByNoNum(hostVo.getNum());
		}
		bookMapper.deleteBookById(id);
		saveMapper.deleteSaveById(id);
		hostMapper.deleteContentById(id);
		int userCheck = userMapper.deleteById(id); // 1
		
		return userCheck;
	}

	public void deleteAll() {
		userMapper.deleteAll();
	}

	// 회원가입 시, 유효성 체크
	public Map<String, String> validateHandlingMap(Errors errors) {
		Map<String, String> validatorResult = new HashMap<>();

		for (FieldError error : errors.getFieldErrors()) {
			String validKeyName = String.format("valid_%s", error.getField());
			validatorResult.put(validKeyName, error.getDefaultMessage());
		}

		return validatorResult;
	}
}
