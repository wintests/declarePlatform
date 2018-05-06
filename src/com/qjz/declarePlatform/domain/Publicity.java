package com.qjz.declarePlatform.domain;

import java.io.Serializable;
import java.util.Date;

public class Publicity implements Serializable {

	/**
	 * 项目立项信息
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer publicity_id;// 立项序号
	private Integer item_id;// 项目编号
	private String item_user;// 项目申报人
	private String review1_user;// 推荐单位
	private String review2_user;// 评审专家
	private String review2_score;// 评审得分
	private String publicity_status;// 立项状态
	private String publicity_grade;// 项目立项等级
	private Date publicity_time;// 项目立项时间
	private String publicity_remark;// 备注

	public Integer getPublicity_id() {
		return publicity_id;
	}

	public void setPublicity_id(Integer publicity_id) {
		this.publicity_id = publicity_id;
	}

	public Integer getItem_id() {
		return item_id;
	}

	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
	}

	public String getItem_user() {
		return item_user;
	}

	public void setItem_user(String item_user) {
		this.item_user = item_user;
	}

	public String getReview1_user() {
		return review1_user;
	}

	public void setReview1_user(String review1_user) {
		this.review1_user = review1_user;
	}

	public String getReview2_user() {
		return review2_user;
	}

	public void setReview2_user(String review2_user) {
		this.review2_user = review2_user;
	}

	public String getReview2_score() {
		return review2_score;
	}

	public void setReview2_score(String review2_score) {
		this.review2_score = review2_score;
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
		return "Publicity [publicity_id=" + publicity_id + ", item_id="
				+ item_id + ", item_user=" + item_user + ", review1_user="
				+ review1_user + ", review2_user=" + review2_user
				+ ", review2_score=" + review2_score + ", publicity_status="
				+ publicity_status + ", publicity_grade=" + publicity_grade
				+ ", publicity_time=" + publicity_time + ", publicity_remark="
				+ publicity_remark + "]";
	}

}
