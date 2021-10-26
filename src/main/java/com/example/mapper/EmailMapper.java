package com.example.mapper;

import java.util.List;

public interface EmailMapper {

	//@Insert("INSERT INTO emailnum (email, number) VALUES (#{email}, #{number}) ")
	void addNumber(String email, String number);
	
	//@Select("SELECT number FROM emailnum WHERE email = #{email}")
	String getNumberByEmail(String email);

	//@Delete("DELETE FROM emailnum WHERE email = #{email}")
	void deleteByEmail(String email);
	
	//@Select("SELECT id FROM user WHERE email = #{email}")
	List<String> getIdByEmail(String email);
	
	//@Select("SELECT password FROM user WHERE id = #{id} AND email = #{email}")
	String getPassByInfo(String id, String email);
}
