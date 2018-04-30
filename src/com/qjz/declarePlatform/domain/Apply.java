package com.qjz.declarePlatform.domain;

import java.io.Serializable;
import java.util.Date;

public class Apply implements Serializable {

	/**
	 * 项目申报信息
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer item_id; // 项目编号
	private String item_name; // 项目名称
	private String item_type; // 项目类别
	private String item_user; // 项目申报人
	private String user_department; // 所属系部
	private String apply_year;	// 申报年份
	private Date item_starttime; // 项目开始时间
	private Date item_deadline; // 项目截止时间
	private String item_submit; // 提交状态
	private Date apply_time; // 提交时间
	private String item_status; // 当前状态
	private String item_description; // 项目描述
	public Integer getItem_id() {
		return item_id;
	}
	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getItem_user() {
		return item_user;
	}
	public void setItem_user(String item_user) {
		this.item_user = item_user;
	}
	public String getUser_department() {
		return user_department;
	}
	public void setUser_department(String user_department) {
		this.user_department = user_department;
	}
	public Date getItem_starttime() {
		return item_starttime;
	}
	public void setItem_starttime(Date item_starttime) {
		this.item_starttime = item_starttime;
	}
	public Date getItem_deadline() {
		return item_deadline;
	}
	public void setItem_deadline(Date item_deadline) {
		this.item_deadline = item_deadline;
	}
	public String getItem_submit() {
		return item_submit;
	}
	public void setItem_submit(String item_submit) {
		this.item_submit = item_submit;
	}
	public Date getApply_time() {
		return apply_time;
	}
	public void setApply_time(Date apply_time) {
		this.apply_time = apply_time;
	}
	public String getItem_status() {
		return item_status;
	}
	public void setItem_status(String item_status) {
		this.item_status = item_status;
	}
	public String getItem_description() {
		return item_description;
	}
	public void setItem_description(String item_description) {
		this.item_description = item_description;
	}
	public String getApply_year() {
		return apply_year;
	}
	public void setApply_year(String apply_year) {
		this.apply_year = apply_year;
	}
	@Override
	public String toString() {
		return "Apply [item_id=" + item_id + ", item_name=" + item_name
				+ ", item_type=" + item_type + ", item_user=" + item_user
				+ ", user_department=" + user_department + ", apply_year="
				+ apply_year + ", item_starttime=" + item_starttime
				+ ", item_deadline=" + item_deadline + ", item_submit="
				+ item_submit + ", apply_time=" + apply_time + ", item_status="
				+ item_status + ", item_description=" + item_description + "]";
	}
	

}
