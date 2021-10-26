package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.EmailMapper;

@Service
@Transactional
public class EmailService {

	private EmailMapper emailMapper;
	
	@Autowired
	public void setEmailMapper(EmailMapper emailMapper) {
		this.emailMapper = emailMapper;
	}
	
	public void addNumber(String email, String number) {
		emailMapper.addNumber(email, number);
	}
	
	public String getNumberByEmail(String email) {
		String strNum = emailMapper.getNumberByEmail(email);
		return strNum;
	}
	
	public void deleteByEmail(String email) {
		emailMapper.deleteByEmail(email);
	}
	
	public List<String> getIdByEmail(String email) {
		List<String> strId = emailMapper.getIdByEmail(email);
		return strId;
	}
	
	public String getPassByInfo(String id ,String email) {
		String strPass = emailMapper.getPassByInfo(id, email);
		return strPass;
	}
	
}
