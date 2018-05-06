package com.qjz.declarePlatform.service;

import java.util.List;
import java.util.Map;

import com.qjz.declarePlatform.domain.User;

public interface UserService {
	
	/**
	 * 显示评审专家信息
	 * @return
	 */
	public List<User> listExpert();
	
	/**
	 * 根据用户类型查找(分页显示)
	 * @param page
	 * @param rows
	 * @return
	 */
	public Map<String, Object> findUserByType(String str, User user, int currentPage, int pageSize);

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

	/**
	 * 更改用户状态
	 * @param user_id
	 * @param signln_valid
	 */
	public void changeUserStatus(Integer user_id, String signln_valid);

	/**
	 * 批量更改用户状态
	 * @param idsStr
	 * @param signln_valid
	 */
	public void changeUserStatusBatchs(String idsStr, String signln_valid);

}
