package com.qjz.declarePlatform.service;

import java.util.Map;

import com.qjz.declarePlatform.domain.ResourceModel;

public interface ResourceModelService {
	
	public Map<String, Object> listResourceModel();

	public void addResourceModel(ResourceModel resourceModel);

}
