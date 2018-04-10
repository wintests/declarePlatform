package com.qjz.declarePlatfrom.domain;

import java.io.Serializable;

public class Signln implements Serializable {

	/**
	 * 登录信息
	 */
	private static final long serialVersionUID = 1L;

	private int signln_id;
	private String user_name;
	private String user_pass;
	private String user_type;
	private String signln_valid;

	public int getSignln_id() {
		return signln_id;
	}

	public void setSignln_id(int signln_id) {
		this.signln_id = signln_id;
	}

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
		return "Signln [signln_id=" + signln_id + ", user_name=" + user_name
				+ ", user_pass=" + user_pass + ", user_type=" + user_type
				+ ", signln_valid=" + signln_valid + "]";
	}
}
