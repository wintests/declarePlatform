package com.qjz.declarePlatform.domain;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {

	/**
	 * 用户信息
	 */
	private static final long serialVersionUID = 1L;

	private Integer user_id; // id编号
	private String user_name; // 用户名
	private String user_pass; // 密码
	private String real_name; // 姓名
	private String user_sex; // 性别
	private String user_department; // 所属系部
	private String user_title; // 职称
	private String user_mailbox; // 电子邮箱
	private String user_telphone; // 联系电话
	private Date reg_date; // 添加时间
	private String user_type; // 用户类型
	private String signln_valid; // 状态
	private String user_remark; // 备注

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
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

	public String getReal_name() {
		return real_name;
	}

	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}

	public String getUser_sex() {
		return user_sex;
	}

	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}

	public String getUser_department() {
		return user_department;
	}

	public void setUser_department(String user_department) {
		this.user_department = user_department;
	}

	public String getUser_title() {
		return user_title;
	}

	public void setUser_title(String user_title) {
		this.user_title = user_title;
	}

	public String getUser_mailbox() {
		return user_mailbox;
	}

	public void setUser_mailbox(String user_mailbox) {
		this.user_mailbox = user_mailbox;
	}

	public String getUser_telphone() {
		return user_telphone;
	}

	public void setUser_telphone(String user_telphone) {
		this.user_telphone = user_telphone;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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

	public String getUser_remark() {
		return user_remark;
	}

	public void setUser_remark(String user_remark) {
		this.user_remark = user_remark;
	}

	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", user_name=" + user_name
				+ ", user_pass=" + user_pass + ", real_name=" + real_name
				+ ", user_sex=" + user_sex + ", user_department="
				+ user_department + ", user_title=" + user_title
				+ ", user_mailbox=" + user_mailbox + ", user_telphone="
				+ user_telphone + ", reg_date=" + reg_date + ", user_type="
				+ user_type + ", signln_valid=" + signln_valid
				+ ", user_remark=" + user_remark + "]";
	}

}
