package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.HostVo;

public interface HostMapper {
	
	public void addContent(HostVo hostVo);
	
	public HostVo getContentInfo(int num);
	
	public HostVo getContentInfoForMain(String classification);
	
	public int getContentCount(@Param("location") String location, @Param("cntOfPerson") int cntOfPerson);
	
	public List<HostVo> getContentsByAddress(
			@Param("location") String location,
			@Param("cntOfPerson") int cntOfPerson,
			@Param("startRow") int startRow);
	
	public List<HostVo> getContentAllById(String id);
	
	public List<HostVo> getContentsById(@Param("id") String id, @Param("startRow") int startRow);
	
	public int countContentsById(String id);
	
	public int updateContentInfo(HostVo hostVo);
	
	public void deleteContentInfo(int num);
	
	public int deleteContentById(String id);
}
