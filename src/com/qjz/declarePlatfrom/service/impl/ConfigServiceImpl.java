package com.qjz.declarePlatfrom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.ConfigDao;
import com.qjz.declarePlatfrom.domain.Config;
import com.qjz.declarePlatfrom.service.ConfigService;

@Service
public class ConfigServiceImpl implements ConfigService {
	
	@Resource
	private ConfigDao configDao;

	@Override
	public void updateConfig(Config config) {
		configDao.updateConfig(config);
	}

	@Override
	public Map<String, Object> show() {
		Long total = configDao.count();
		List<Config> list = configDao.show();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		System.out.println(list);
		return map;
	}

}
