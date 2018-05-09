package com.qjz.declarePlatform.dao;

import java.util.List;

import com.qjz.declarePlatform.domain.ResourceModel;

public interface ResourceModelDao {
	
	public List<ResourceModel> listResourceModel();
	
	public Long count();
	
	public int addResourceModel(ResourceModel ResourceModel);


}
