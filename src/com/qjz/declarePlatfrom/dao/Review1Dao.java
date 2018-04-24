package com.qjz.declarePlatfrom.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatfrom.domain.Review1;

public interface Review1Dao {
	
	/**
	 * 显示系部审核列表
	 * @param pageSize 
	 * @param start 
	 * @return
	 */
	public List<Review1> listReview1(@Param("start")int start, @Param("pageSize")int pageSize);
	
	/**
	 * 得到总记录数
	 * @return
	 */
	public Long count();

	/**
	 * 新增审核项目
	 * @param item_id
	 * @return
	 */
	public int addReview1(Integer item_id);
	
	/**
	 * 批量添加审核项目
	 * @param ids
	 * @return
	 */
	public int addReview1Batchs(Integer[] ids);

	/**
	 * 更新审核项目
	 * @param review1
	 * @return
	 */
	public int updateReview1(Review1 review1);

	

}
