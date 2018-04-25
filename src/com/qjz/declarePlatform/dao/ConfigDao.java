package com.qjz.declarePlatform.dao;

import java.util.List;

import com.qjz.declarePlatform.domain.Config;

public interface ConfigDao {
	
	/**
	 * 系统控制开关
	 * @param config_flag
	 */
	public void updateConfig(Config config);

	/**
	 * 显示信息
	 * @return
	 */
	public List<Config> show();

	public Long count();

}
