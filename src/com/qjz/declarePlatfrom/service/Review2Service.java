package com.qjz.declarePlatfrom.service;

import java.util.Map;

import com.qjz.declarePlatfrom.domain.Review2;

public interface Review2Service {
	
	/**
	 * 显示专家评审列表
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> listReview2(int currentPage, int pageSize);

	/**
	 * 新增专家评审项目
	 * @param item_id
	 * @param review2_user
	 */
	public void addReview2(Integer item_id, String review2_user);

	/**
	 * 更新专家评审项目信息
	 * @param review2
	 */
	public void updateReview2(Review2 review2);

}
