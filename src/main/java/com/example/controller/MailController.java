package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.EmailService;
import com.example.service.MailHandler;
import com.example.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;

@Log
@Controller
@AllArgsConstructor
@RequestMapping("/mail/*")
public class MailController {

	@Autowired
	private EmailService emailService;
	
	private JavaMailSender mailSender;
	
	@Autowired
	private UserService userService;
	
	 @GetMapping("/email")
	    public String dispMail() {
	        return "email";
	    }

	    @GetMapping(value = "/ajax/email", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	    @ResponseBody
	    public void ajaxEmail(String email, Model model) {
	    	
	        // 임의의 숫자 다섯개 생성하기
	        int num[] = new int[5];
	        	for(int i=0; i<5; i++) {
	        		num[i]=(int)(Math.random()*9);
        		for(int j=0; j<i;j++) {
	               if(num[i]==num[j]) {i--; break;}
	           }    
	        }
	        	
	        String randomNum = ""+num[0]+""+num[1]+""+num[2]+""+num[3]+""+num[4]+"";
	         
	        // 숫자 잘들어갔는지 확인
            log.info(randomNum);
            
            try {
                MailHandler mailHandler = new MailHandler(mailSender);
                
                // 받는 사람
               mailHandler.setTo(email);
                // 보내는 사람
               mailHandler.setFrom("ruitest20@gmail.com");
               
               mailHandler.setSubject("인증번호 발송 메일 입니다다다");
                // HTML Layout
                String htmlContent = "<h1>" + randomNum +"</h1>"; // <img src='cid:sample-img'> 이미지 추가할려면 이거 뒤에 추가하면됨
                mailHandler.setText(htmlContent, true);
                // 첨부 파일
//               mailHandler.setAttach("newTest.txt", "static/originTest.txt");
                // 이미지 삽입
//               mailHandler.setInline("sample-img", "static/sample1.jpg");

                mailHandler.send();
                emailService.deleteByEmail(email);
                emailService.addNumber(email, randomNum);
                
            }
            catch(Exception e){
                e.printStackTrace();
            }
            
	    }
	    
	    @GetMapping(value = "/ajax/reEmail", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	    @ResponseBody
	    public void ajaxReEmail(String email) {
	    	
	        // 임의의 숫자 다섯개 생성하기
	        int num[] = new int[5];
	        	for(int i=0; i<5; i++) {
	        		num[i]=(int)(Math.random()*9);
        		for(int j=0; j<i;j++) {
	               if(num[i]==num[j]) {i--; break;}
	           }    
	        }
	        	
	        String randomNum = ""+num[0]+""+num[1]+""+num[2]+""+num[3]+""+num[4]+"";
	         
	        // 숫자 잘들어갔는지 확인
            log.info(randomNum);
            
            try {
                MailHandler mailHandler = new MailHandler(mailSender);
                
                // 받는 사람
               mailHandler.setTo(email);
                // 보내는 사람
               mailHandler.setFrom("ruitest20@gmail.com");
                // 제목
               mailHandler.setSubject("인증번호 발송 메일 입니다다다");
                // HTML Layout
                String htmlContent = "<h1>" + randomNum +"</h1>"; // <img src='cid:sample-img'> 이미지 추가할려면 이거 뒤에 추가하면됨
                mailHandler.setText(htmlContent, true);
                // 첨부 파일
//               mailHandler.setAttach("newTest.txt", "static/originTest.txt");
                // 이미지 삽입
//               mailHandler.setInline("sample-img", "static/sample1.jpg");

                mailHandler.send();
                emailService.deleteByEmail(email);
                emailService.addNumber(email, randomNum);
            }
            catch(Exception e){
                e.printStackTrace();
            }
			
	    }
	    
	    
	    @GetMapping(value = "/ajax/emailLast", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE }) 
    	@ResponseBody	
    	public Map<String, Boolean> emailLastTest (String email, String number) {
	    	
	    	String num = emailService.getNumberByEmail(email);
	    	
	    	Map<String, Boolean> map = new HashMap<>();

	    	
	    	if (num != null) { // 아이디 일치
	    		if (num.equals(number)) { // 아이디, 인증번호 둘다 일치
		    		map.put("emailnumber", true);
		    		emailService.deleteByEmail(email);
	    			return map;
		    	} else { // 인증번호 다름
					map.put("emailnumber", false);
					return map;
				}
	    	} else { // 중간에 아이디 다른놈으로 바꾸거나 했을경우
	    		map.put("emailnumber", false);
				return map;
	    	}
	    }
	    
	    
	    @PostMapping("/findId")
	    @ResponseBody
	    public Map<String, Object> findId(String email) {
	    	
	    	log.info("Testing.findId() - Post 호출");
	    	Map<String, Object> isSuccessCheck = new HashMap<>();
	    	List<String> resultIdList = emailService.getIdByEmail(email);
	    	String htmlContent="";
	    	try {
	            MailHandler mailHandler = new MailHandler(mailSender);
	                
	            // 받는 사람
	            mailHandler.setTo(email);
	            // 보내는 사람
	            mailHandler.setFrom("ruitest20@gmail.com");
	            // 제목
	            mailHandler.setSubject("회원정보 찾기 응답 메일입니다.");
	            // HTML Layout
	            for(String resultId : resultIdList)
	            htmlContent += "회원님의 아이디는\" <h1>" +  resultId + "</h1> \"입니다.<br><br>";
	            mailHandler.setText(htmlContent, true);
	
	            mailHandler.send();
	            isSuccessCheck.put("isSuccess", true);
            }
            catch(Exception e){
	            	isSuccessCheck.put("isSuccess", false);
	                e.printStackTrace();
            }
	    	
	    	return isSuccessCheck;
//	    	return "redirect:/user/login";
	    }
	    
	    @PostMapping("/findPass")
	    @ResponseBody
	    public Map<String, Object> findPass(String id ,String email) {
	    	
	    	log.info("Testing.findPass() - Post 호출");
	    	Map<String, Object> isSuccessCheck = new HashMap<>();
	    	
	    	String htmlContent = "";
	    	try {
		            MailHandler mailHandler = new MailHandler(mailSender);
		                
		            // 받는 사람
		            mailHandler.setTo(email);
		            // 보내는 사람
		            mailHandler.setFrom("ruitest20@gmail.com");
		            // 제목
		            mailHandler.setSubject("회원정보 찾기 응답 메일입니다.");
		            // HTML Layout
		          
		    		String newPwd = userService.getMemberByIdAndUpdatePass(id);
		            if(newPwd.equals("false"))
		            	htmlContent = "비밀번호 찾기를 다시 시도해주세요.";
		            else
		            	htmlContent = "회원님의 임시 비밀번호는\"<h1>" +  newPwd +"</h1>\" 입니다.";
		            mailHandler.setText(htmlContent, true);
		
		            mailHandler.send();
		            isSuccessCheck.put("isSuccess", true);
	            }
	            catch(Exception e){
	            	isSuccessCheck.put("isSuccess", false);
	                e.printStackTrace();
	            }
	    	
	    	return isSuccessCheck;
	    }
	    
	    
}
