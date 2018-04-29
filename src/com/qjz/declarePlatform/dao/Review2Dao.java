package com.qjz.declarePlatform.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatform.domain.Review2;

public interface Review2Dao {
	
	/**
	 * 显示专家评审列表
	 * @param review2_user
	 * @param review2_status
	 * @param start
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> listReview2(@Param("review2_user")String review2_user, @Param("review2_status")String review2_status, @Param("start")int start, @Param("pageSize")int pageSize);

	
	/**
	 * 得到总记录数
	 * @param review2_user 
	 * @param review2_status 
	 * @return
	 */
	public Long count(@Param("review2_user")String review2_user, @Param("review2_status")String review2_status);


	/**
	 * 添加专家评审项目
	 * @param item_id
	 * @param review2_user
	 * @return
	 */
	public int addReview2(@Param("item_id")Integer item_id, @Param("review2_user")String review2_user);

	/**
	 * 更新专家评审项目信息
	 * @param review2
	 * @return
	 */
	public int updateReview2(Review2 review2); 

}
