package com.qjz.declarePlatfrom.service;

import java.util.List;

import com.qjz.declarePlatfrom.domain.Apply;

public interface ApplyService {
	
	/**
	 * 显示所有申报项目列表
	 * @return
	 */
	public List<Apply> listApply();

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
	 */
	public void submitApply(Integer item_id, String item_submit);

	/**
	 * 批量提交
	 * @param idsStr
	 * @param item_submit
	 */
	public void submitApplyBatchs(String idsStr, String item_submit);

}
