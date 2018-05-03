package com.qjz.declarePlatform.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.Review1;
import com.qjz.declarePlatform.domain.User;

public interface Review1Dao {
	
	/**
	 * 显示系部审核列表
	 * @param status
	 * @param apply
	 * @param user
	 * @param str
	 * @param start
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> listReview1(@Param("status")String[] status, @Param("apply")Apply apply, @Param("user")User user, @Param("str")String str, @Param("start")int start, @Param("pageSize")int pageSize);
	
	/**
	 * 得到总记录数
	 * @param status
	 * @param apply
	 * @param user
	 * @param str
	 * @return
	 */
	public Long count(@Param("status")String[] status, @Param("apply")Apply apply, @Param("user")User user, @Param("str")String str);

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
