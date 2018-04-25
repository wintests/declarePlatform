package com.qjz.declarePlatform.domain;

import java.io.Serializable;

public class Signln implements Serializable {

	/**
	 * 登录信息
	 */
	private static final long serialVersionUID = 1L;

	private String user_name;// 用户名
	private String user_pass;// 密码
	private String user_type;// 用户类型
	private String signln_valid;// 状态

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_pass() {
		return user_pass;
	}

	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getSignln_valid() {
		return signln_valid;
	}

	public void setSignln_valid(String signln_valid) {
		this.signln_valid = signln_valid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Signln [user_name=" + user_name + ", user_pass=" + user_pass
				+ ", user_type=" + user_type + ", signln_valid=" + signln_valid
				+ "]";
	}

}
