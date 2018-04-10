package com.qjz.declarePlatfrom.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.ConfigDao;
import com.qjz.declarePlatfrom.service.ConfigService;

@Service
public class ConfigServiceImpl implements ConfigService {
	
	@Resource
	private ConfigDao configMapper;

	@Override
	public void updateConfig(String config_flag) {
		configMapper.updateConfig(config_flag);
	}

}
