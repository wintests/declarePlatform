package com.qjz.declarePlatfrom.domain;

import java.io.Serializable;
import java.util.Date;

public class Review2 implements Serializable {

	/**
	 * 专家评审信息
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer review2_id;// 评审序号
	private Integer item_id; // 项目编号
	private String review2_user;// 评审专家
	private String review2_status;// 评审状态
	private Date review2_time;// 评审时间
	private Integer review2_score;// 评审分数
	private String review2_opinion;// 评审意见
	private String review2_remark;// 备注

	public Integer getReview2_id() {
		return review2_id;
	}

	public void setReview2_id(Integer review2_id) {
		this.review2_id = review2_id;
	}

	public Integer getItem_id() {
		return item_id;
	}

	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
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

	public Integer getReview2_score() {
		return review2_score;
	}

	public void setReview2_score(Integer review2_score) {
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

	@Override
	public String toString() {
		return "Review2 [review2_id=" + review2_id + ", item_id=" + item_id
				+ ", review2_user=" + review2_user + ", review2_status="
				+ review2_status + ", review2_time=" + review2_time
				+ ", review2_score=" + review2_score + ", review2_opinion="
				+ review2_opinion + ", review2_remark=" + review2_remark + "]";
	}

}
