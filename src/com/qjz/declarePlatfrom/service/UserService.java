package com.qjz.declarePlatfrom.service;

import java.util.List;

import com.qjz.declarePlatfrom.domain.User;

public interface UserService {
	
	/**
	 * 根据用户类型查找
	 * @param user_type
	 * @return
	 */
	public List<User> findUserByType(String user_type);

	/**
	 * 更新用户信息
	 * @param user
	 */
	public void updateUser(User user);

	/**
	 * 新增用户
	 * @param user
	 */
	public void addUser(User user);

	/**
	 * 根据用户名删除用户
	 * @param user_name
	 */
	public void deleteUserByName(String user_name);

	/**
	 * 批量删除
	 * @param names
	 */
	public void deleteUserBatchs(String names);

}
