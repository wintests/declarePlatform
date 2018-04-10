package com.qjz.declarePlatfrom.service;

import java.util.List;

import com.qjz.declarePlatfrom.domain.Signln;

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

}
