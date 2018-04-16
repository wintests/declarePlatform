package com.qjz.declarePlatfrom.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatfrom.domain.User;

public interface UserDao {
	/**
	 * 根据用户类型查找用户
	 */
	public List<User> findUserByType(@Param("user_type")String user_type, @Param("str")String str, @Param("user")User user, @Param("start")int start, @Param("pageSize")int pageSize);
	
	/**
	 * 该用户类型下的总记录数
	 */
	public Long count(@Param("user_type")String user_type, @Param("str")String str, @Param("user")User user);

	/**
	 * 根据id更新用户信息
	 * @param user
	 * @return 
	 */
	public int updateUserById(User user);
	
	/**
	 * 更新登录账号信息
	 * @param user
	 * @return
	 */
	public int updateSignln(User user);
	
	/**
	 * 修改用户密码
	 * @param user_name
	 * @param user_pass
	 * @return
	 */
	public int modifyPassword(@Param("user_name")String user_name, @Param("user_pass")String user_pass);

	/**
	 * 修改登录表密码
	 * @param user_name
	 * @param user_pass
	 * @return
	 */
	public int modifySignlnPassword(@Param("user_name")String user_name, @Param("user_pass")String user_pass);


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
	 * 根据id删除用户
	 * @param user_name
	 * @return 
	 */
	public int deleteUserById(Integer id);
	
	/**
	 * 根据id查找用户名
	 * @param user_name
	 * @return
	 */
	public String findNameById(Integer id);
	
	/**
	 * 根据登录表id删除
	 * @param id
	 * @return 
	 */
	public int deleteSignlnByName(String user_name);

	/**
	 * 批量删除(user表)
	 * @param names
	 * @return 
	 */
	public int deleteUserBatchs(Integer[] ids);
	
	/**
	 * 批量删除(signln表)
	 * @param list
	 * @return 
	 */
	public int deleteSignlnBatchs(List<String> list);

	/**
	 * 更改用户状态
	 * @param user_id
	 * @param signln_valid
	 * @return
	 */
	public int changeUserStatus(@Param("user_id")Integer user_id, @Param("signln_valid")String signln_valid);

	/**
	 * 更改用户状态(登录表)
	 * @param user_name
	 * @param signln_valid
	 * @return
	 */
	public int changeSignlnStatus(@Param("user_name")String user_name, @Param("signln_valid")String signln_valid);

	/**
	 * 批量更改用户状态
	 * @param ids
	 * @param signln_valid
	 * @return
	 */
	public int changeUserStatusBatchs(@Param("array")Integer[] array, @Param("signln_valid")String signln_valid);

	/**
	 * 批量更改用户状态(登录表)
	 * @param list
	 * @param signln_valid
	 * @return
	 */
	public int changeSignlnStatusBatchs(@Param("list")List<String> list, @Param("signln_valid")String signln_valid);

}
