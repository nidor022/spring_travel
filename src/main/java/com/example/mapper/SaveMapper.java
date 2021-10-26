package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.SaveVo;

public interface SaveMapper {
	
	public int addSave(SaveVo saveVo);
	
	public List<SaveVo> getSaveInfo(String id);
	
	public int isExistSaveInfo(@Param("hostNum") int hostNum, @Param("id") String id);
	
	public int getSaveNum(@Param("hostNum") int hostNum, @Param("id") String id);
	
	public int countSaveById(String id);
	
	public void updateSaveInfo(SaveVo saveVo);
	
	public int deleteSaveInfo(int num);
	
	public int deleteSaveById(String id);
}
