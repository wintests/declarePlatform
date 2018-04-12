package com.qjz.declarePlatfrom.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatfrom.domain.User;

public interface UserDao {
	/**
	 * 根据用户类型查找用户
	 */
	public List<User> findUserByType(@Param("user_type")String user_type, @Param("start")int start, @Param("pageSize")int pageSize);
	
	/**
	 * 该用户类型下的总记录数
	 */
	public Long count(String user_type);

	/**
	 * 更新用户信息
	 * @param user
	 * @return 
	 */
	public int updateUser(User user);
	
	/**
	 * 更新登录账号信息
	 * @param user
	 * @return
	 */
	public int updateSignln(User user);

	/**
	 * 新增用户
	 * @param user
	 * @return 
	 */
	public int addUser(User user);
	
	/**
	 * 新增用户登录账号
	 * @param user
	 * @return 
	 */
	public int addSignln(User user);

	/**
	 * 根据用户名删除
	 * @param user_name
	 * @return 
	 */
	public int deleteUserByName(String user_name);
	
	/**
	 * 根据用户名查找登录表id
	 * @param user_name
	 * @return
	 */
	public int findIdByName(String user_name);
	
	/**
	 * 根据登录表id删除
	 * @param id
	 * @return 
	 */
	public int deleteSignlnById(int id);

	/**
	 * 批量删除(user表)
	 * @param names
	 * @return 
	 */
	public int deleteUserBatchs(String[] names);
	
	/**
	 * 批量删除(signln表)
	 * @param list
	 * @return 
	 */
	public int deleteSignlnBatchs(List<Integer> list);

	


}
