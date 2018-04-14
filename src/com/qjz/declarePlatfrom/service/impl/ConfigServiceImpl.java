package com.qjz.declarePlatfrom.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.ConfigDao;
import com.qjz.declarePlatfrom.service.ConfigService;

@Service
public class ConfigServiceImpl implements ConfigService {
	
	@Resource
	private ConfigDao configDao;

	@Override
	public void updateConfig(String config_flag) {
		configDao.updateConfig(config_flag);
	}

}
