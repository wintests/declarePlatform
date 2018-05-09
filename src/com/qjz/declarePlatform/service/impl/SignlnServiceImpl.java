package com.qjz.declarePlatform.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatform.dao.ConfigDao;
import com.qjz.declarePlatform.dao.SignlnDao;
import com.qjz.declarePlatform.domain.Signln;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.SignlnService;

@Service
public class SignlnServiceImpl implements SignlnService {
	
	@Resource(name="signlnDao")
	private SignlnDao signlnDao;
	
	@Resource(name="configDao")
	private ConfigDao configDao;

	@Override
	public Signln login(Signln signln) {
		Signln si = signlnDao.login(signln);
		return si;
	}

	@Override
	public List<Signln> show() {
		List<Signln> list = signlnDao.show();
		return list;
	}

	@Override
	public User getUserByName(String user_name) {
		User user = signlnDao.getUserByName(user_name);
		return user;
	}

	@Override
	public String getConfigStatus() {
		String config_flag = configDao.getConfigStatus();
		return config_flag;
	}

}
