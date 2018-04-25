package com.qjz.declarePlatform.domain;

import java.io.Serializable;

public class Config implements Serializable {

	/**
	 * 系统进度控制开关
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer config_id; // 编号
	private String config_flag; // 项目进度状态

	public Integer getConfig_id() {
		return config_id;
	}

	public void setConfig_id(Integer config_id) {
		this.config_id = config_id;
	}

	public String getConfig_flag() {
		return config_flag;
	}

	public void setConfig_flag(String config_flag) {
		this.config_flag = config_flag;
	}

	@Override
	public String toString() {
		return "Config [config_id=" + config_id + ", config_flag="
				+ config_flag + "]";
	}

}
