package com.qjz.declarePlatform.service;

import java.util.Map;

import com.qjz.declarePlatform.domain.Apply;

public interface ApplyService {
	
	/**
	 * 显示所有申报项目列表
	 * @param pageSize 
	 * @param currentPage 
	 * @param item_name 
	 * @return
	 */
	public Map<String, Object> listApply(String item_name, int currentPage, int pageSize);

	/**
	 * 更新申报项目信息
	 * @param apply
	 */
	public void updateApply(Apply apply);

	/**
	 * 新增申报信息
	 * @param apply
	 */
	public void addApply(Apply apply);

	/**
	 * 根据id删除申报信息
	 * @param item_id
	 */
	public void deleteApplyById(Integer item_id);

	/**
	 * 批量删除申报信息
	 * @param idsStr
	 */
	public void deleteApplyBatchs(String idsStr);

	/**
	 * 更改提交状态（未提交->已提交）
	 * @param item_id
	 * @param item_submit
	 * @param item_status 
	 */
	public void submitApply(Integer item_id, String item_submit);

	/**
	 * 批量提交
	 * @param idsStr
	 * @param item_submit
	 * @param item_status 
	 */
	public void submitApplyBatchs(String idsStr, String item_submit);

}
