package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatform.dao.ResourceModelDao;
import com.qjz.declarePlatform.domain.ResourceModel;
import com.qjz.declarePlatform.service.ResourceModelService;

@Service
public class ResourceModelServiceImpl implements ResourceModelService {
	
	@Resource
	private ResourceModelDao resourceModelDao;

	@Override
	public Map<String, Object> listResourceModel() {
		Long total = resourceModelDao.count();
		List<ResourceModel> list = resourceModelDao.listResourceModel();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	public void addResourceModel(ResourceModel resourceModel) {
		int i = resourceModelDao.addResourceModel(resourceModel);
		if(i == 0) {
			throw new RuntimeException("上传模板失败，请重新操作！");
		}

	}

}
