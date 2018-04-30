package com.qjz.declarePlatform.domain;

import java.io.Serializable;
import java.util.Date;

public class Review1 implements Serializable{

	/**
	 * 审核推荐信息
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer review1_id;// 审核序号
	private Integer item_id;// 项目编号
	private String review1_status;// 审核状态
	private String review1_user;// 审核单位
	private String review1_operator; //操作人员
	private Date review1_time;// 审核时间
	private String review1_remark;// 备注

	public Integer getReview1_id() {
		return review1_id;
	}

	public void setReview1_id(Integer review1_id) {
		this.review1_id = review1_id;
	}

	public Integer getItem_id() {
		return item_id;
	}

	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
	}

	public String getReview1_status() {
		return review1_status;
	}

	public void setReview1_status(String review1_status) {
		this.review1_status = review1_status;
	}

	public String getReview1_user() {
		return review1_user;
	}

	public void setReview1_user(String review1_user) {
		this.review1_user = review1_user;
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

	public String getReview1_operator() {
		return review1_operator;
	}

	public void setReview1_operator(String review1_operator) {
		this.review1_operator = review1_operator;
	}

	@Override
	public String toString() {
		return "Review1 [review1_id=" + review1_id + ", item_id=" + item_id
				+ ", review1_status=" + review1_status + ", review1_user="
				+ review1_user + ", review1_operator=" + review1_operator
				+ ", review1_time=" + review1_time + ", review1_remark="
				+ review1_remark + "]";
	}

}
