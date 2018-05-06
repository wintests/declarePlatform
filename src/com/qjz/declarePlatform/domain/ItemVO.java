package com.qjz.declarePlatform.domain;

import java.io.Serializable;
import java.util.Date;

public class ItemVO implements Serializable{

	/**
	 * 封装数据信息
	 */
	private static final long serialVersionUID = 1L;
	
	// 用户信息
	private String user_department; // 所属系部
	private String user_title; // 职称
	// 申报信息
	private String item_name; // 项目名称
	private String item_type; // 项目类别
	private String item_user; // 项目申报人
	private String apply_year; // 申报年份
	private Date item_starttime; // 项目开始时间
	private Date item_deadline; // 项目截止时间
	// 系部审核信息
	private String review1_user;// 审核(推荐)单位
	private String review1_operator; // 操作人员
	private Date review1_time;// 审核时间
	private String review1_remark;// 系部审核备注
	// 专家评审信息
	private String review2_user;// 评审专家
	private String review2_status;// 评审状态
	private Date review2_time;// 评审时间
	private String review2_score;// 评审分数
	private String review2_opinion;// 评审意见
	private String review2_remark;// 备注
	// 立项审批信息
	private String publicity_status;// 立项状态
	private String publicity_grade;// 项目立项等级
	private Date publicity_time;// 项目立项时间
	private String publicity_remark;// 立项审批备注

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

	public String getApply_year() {
		return apply_year;
	}

	public void setApply_year(String apply_year) {
		this.apply_year = apply_year;
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

	public String getReview1_user() {
		return review1_user;
	}

	public void setReview1_user(String review1_user) {
		this.review1_user = review1_user;
	}

	public String getReview1_operator() {
		return review1_operator;
	}

	public void setReview1_operator(String review1_operator) {
		this.review1_operator = review1_operator;
	}

	public Date getReview1_time() {
		return review1_time;
	}

	public void setReview1_time(Date review1_time) {
		this.review1_time = review1_time;
	}

	public String getReview1_remark() {
		return review1_remark;
	}

	public void setReview1_remark(String review1_remark) {
		this.review1_remark = review1_remark;
	}

	public String getReview2_user() {
		return review2_user;
	}

	public void setReview2_user(String review2_user) {
		this.review2_user = review2_user;
	}

	public String getReview2_status() {
		return review2_status;
	}

	public void setReview2_status(String review2_status) {
		this.review2_status = review2_status;
	}

	public Date getReview2_time() {
		return review2_time;
	}

	public void setReview2_time(Date review2_time) {
		this.review2_time = review2_time;
	}

	public String getReview2_score() {
		return review2_score;
	}

	public void setReview2_score(String review2_score) {
		this.review2_score = review2_score;
	}

	public String getReview2_opinion() {
		return review2_opinion;
	}

	public void setReview2_opinion(String review2_opinion) {
		this.review2_opinion = review2_opinion;
	}

	public String getReview2_remark() {
		return review2_remark;
	}

	public void setReview2_remark(String review2_remark) {
		this.review2_remark = review2_remark;
	}

	public String getPublicity_status() {
		return publicity_status;
	}

	public void setPublicity_status(String publicity_status) {
		this.publicity_status = publicity_status;
	}

	public String getPublicity_grade() {
		return publicity_grade;
	}

	public void setPublicity_grade(String publicity_grade) {
		this.publicity_grade = publicity_grade;
	}

	public Date getPublicity_time() {
		return publicity_time;
	}

	public void setPublicity_time(Date publicity_time) {
		this.publicity_time = publicity_time;
	}

	public String getPublicity_remark() {
		return publicity_remark;
	}

	public void setPublicity_remark(String publicity_remark) {
		this.publicity_remark = publicity_remark;
	}

	@Override
	public String toString() {
		return "ItemVO [user_department=" + user_department + ", user_title="
				+ user_title + ", item_name=" + item_name + ", item_type="
				+ item_type + ", item_user=" + item_user + ", apply_year="
				+ apply_year + ", item_starttime=" + item_starttime
				+ ", item_deadline=" + item_deadline + ", review1_user="
				+ review1_user + ", review1_operator=" + review1_operator
				+ ", review1_time=" + review1_time + ", review1_remark="
				+ review1_remark + ", review2_user=" + review2_user
				+ ", review2_status=" + review2_status + ", review2_time="
				+ review2_time + ", review2_score=" + review2_score
				+ ", review2_opinion=" + review2_opinion + ", review2_remark="
				+ review2_remark + ", publicity_status=" + publicity_status
				+ ", publicity_grade=" + publicity_grade + ", publicity_time="
				+ publicity_time + ", publicity_remark=" + publicity_remark
				+ "]";
	}

}
