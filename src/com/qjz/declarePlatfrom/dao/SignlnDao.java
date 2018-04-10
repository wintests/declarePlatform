package com.qjz.declarePlatfrom.dao;

import java.util.List;

import com.qjz.declarePlatfrom.domain.Signln;

public interface SignlnDao {
	
	/**
	 * 用户登录
	 * @param signln
	 * @return
	 */
	public Signln login(Signln signln);

	/**
	 * 显示登录账户
	 * @return
	 */
	public List<Signln> show();

}
