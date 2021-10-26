package com.example.mapper;

import java.util.List;

import com.example.domain.LocationVo;

public interface LocationMapper {
	
	public List<LocationVo> getLocationList();
	
	public LocationVo getLocationListByAd(String address);
}
