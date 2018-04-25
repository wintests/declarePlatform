package com.qjz.declarePlatform.service;

import java.util.Map;

import com.qjz.declarePlatform.domain.Review1;

public interface Review1Service {
	
	/**
	 * 显示系部审核列表
	 * @param pageSize 
	 * @param currentPage 
	 * @return
	 */
	public Map<String, Object> listReview1(int currentPage, int pageSize);

	/**
	 * 新增审核项目
	 * @param item_id
	 */
	public void addReview1(Integer item_id);

	/**
	 * 批量新增审核项目
	 * @param idsStr
	 */
	public void addReview1Batchs(String idsStr);
	
	/**
	 * 更新审核项目
	 * @param review1
	 */
	public void updateReview1(Review1 review1);


}
