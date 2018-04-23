package com.qjz.declarePlatfrom.dao;

import java.util.List;

import com.qjz.declarePlatfrom.domain.Review1;

public interface Review1Dao {
	
	/**
	 * 显示系部审核列表
	 * @return
	 */
	public List<Review1> listReview1();

	/**
	 * 新增审核项目
	 * @param item_id
	 * @return
	 */
	public int addReview1(Integer item_id);

	/**
	 * 更新审核项目
	 * @param review1
	 * @return
	 */
	public int updateReview1(Review1 review1);

}
