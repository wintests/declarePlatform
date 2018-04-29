package com.qjz.declarePlatform.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatform.domain.Publicity;

public interface PublicityDao {
	
	/**
	 * 显示立项列表
	 * @param status 
	 * @param pageSize 
	 * @param start 
	 * @return
	 */
	public List<Map<String, Object>> listPublicity(@Param("status")String[] status, @Param("start")int start, @Param("pageSize")int pageSize);
	
	/**
	 * 总记录数
	 * @param status 
	 * @return
	 */
	public Long count(@Param("status")String[] status);

	/**
	 * 添加立项列表时，根据id得到其他表的基本信息
	 * @param item_id
	 * @return
	 */
	public Publicity getPublicity(Integer item_id);

	/**
	 * 添加立项项目
	 * @param item_id
	 * @param item_user
	 * @param review1_user
	 * @param review2_user
	 * @param review2_score
	 * @return
	 */
	public int addPublicity(@Param("item_id")Integer item_id, @Param("item_user")String item_user,
			@Param("review1_user")String review1_user, @Param("review2_user")String review2_user, @Param("review2_score")Integer review2_score);

	/**
	 * 更新立项项目信息
	 * @param publicity
	 * @return
	 */
	public int updatePublicity(Publicity publicity);

}
