package com.qjz.declarePlatfrom.service;

import java.util.List;

import com.qjz.declarePlatfrom.domain.Review1;

public interface Review1Service {
	
	/**
	 * 显示系部审核列表
	 * @return
	 */
	public List<Review1> listReview1();

	/**
	 * 新增审核项目
	 * @param item_id
	 */
	public void addReview1(Integer item_id);

	/**
	 * 更新审核项目
	 * @param review1
	 */
	public void updateReview1(Review1 review1);

}
