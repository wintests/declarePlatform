package com.qjz.declarePlatfrom.dao;

public interface ConfigDao {
	
	/**
	 * 系统控制开关
	 * @param config_flag
	 */
	public void updateConfig(String config_flag);

}
