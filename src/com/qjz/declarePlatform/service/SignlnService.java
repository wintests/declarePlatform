package com.qjz.declarePlatform.service;

import java.util.List;

import com.qjz.declarePlatform.domain.Signln;
import com.qjz.declarePlatform.domain.User;

public interface SignlnService {
	
	/**
	 * 用户登录
	 * @param signln
	 * @return
	 */
	public Signln login(Signln signln);

	/**
	 * 显示所有登录账户
	 * @return
	 */
	public List<Signln> show();

	/**
	 * 通过用户名获取对应User对象
	 * @param user_name
	 * @return
	 */
	public User getUserByName(String user_name);

}
