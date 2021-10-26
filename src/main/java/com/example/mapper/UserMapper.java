package com.example.mapper;

import java.util.List;

import com.example.domain.UserVo;

public interface UserMapper {

	//@Select("SELECT * FROM member WHERE id = #{id}")
	UserVo getMemberById(String id);
	
	//@Select("SELECT * FROM member ORDER BY id")
	List<UserVo> getAllMembers();
	
	
	int addMember(UserVo userVo);
	
	//@Select("SELECT passwd FROM member WHERE id = #{id}")
	String userCheck(String id);
	
	//@Select("SELECT COUNT(*) FROM member WHERE id = #{id}")
	int getCountById(String id);
	
	
	int update(UserVo userVo);
	
	//@Delete("DELETE FROM member WHERE id = #{id} ")
	int deleteById(String id);
	
	//@Delete("DELETE FROM member")
	void deleteAll();
	
}






