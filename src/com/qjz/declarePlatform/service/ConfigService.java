package com.qjz.declarePlatform.service;

import java.util.Map;

import com.qjz.declarePlatform.domain.Config;

public interface ConfigService {
	
	
	/**
	 * 系统控制开关
	 * @param config_flag
	 */
	public void updateConfig(Config config);

	/**
	 * 显示信息
	 * @return
	 */
	public Map<String, Object> show();

}
