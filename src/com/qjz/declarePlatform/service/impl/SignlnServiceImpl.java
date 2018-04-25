package com.qjz.declarePlatform.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatform.dao.SignlnDao;
import com.qjz.declarePlatform.domain.Signln;
import com.qjz.declarePlatform.service.SignlnService;

@Service
public class SignlnServiceImpl implements SignlnService {
	
	@Resource
	private SignlnDao signlnDao;

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

}
