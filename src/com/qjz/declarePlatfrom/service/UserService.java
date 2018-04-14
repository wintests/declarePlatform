package com.qjz.declarePlatfrom.service;

import java.util.Map;

import com.qjz.declarePlatfrom.domain.User;

public interface UserService {
	
	/**
	 * 根据用户类型查找(分页显示)
	 * @param user_type
	 * @param page
	 * @param rows
	 * @return
	 */
	public Map<String, Object> findUserByType(String user_type, int currentPage,
			int pageSize);

	/**
	 * 根据id更新用户信息
	 * @param user
	 */
	public void updateUserById(User user);
	
	/**
	 * 修改用户密码
	 * @param user_name
	 * @param user_pass
	 */
	public void modifyPassword(String user_name, String user_pass);

	/**
	 * 新增用户
	 * @param user
	 */
	public void addUser(User user);

	/**
	 * 根据id删除用户
	 * @param user_name
	 */
	public void deleteUserById(Integer user_id);

	/**
	 * 批量删除
	 * @param names
	 */
	public void deleteUserBatchs(String idsStr);

	

}
