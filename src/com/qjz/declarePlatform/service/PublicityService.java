package com.qjz.declarePlatform.service;

import java.util.Map;

import com.qjz.declarePlatform.domain.Publicity;

public interface PublicityService {
	
	/**
	 * 显示立项列表
	 * @param pageSize 
	 * @param currentPage 
	 * @return
	 */
	public Map<String, Object> listPublicity(int currentPage, int pageSize);

	/**
	 * 添加立项项目
	 * @param item_id
	 */
	public void addPublicity(Integer item_id);

	/**
	 * 更新立项项目信息
	 * @param publicity
	 */
	public void updatePublicity(Publicity publicity);

}
