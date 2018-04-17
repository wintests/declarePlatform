package com.qjz.declarePlatfrom.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.ApplyDao;
import com.qjz.declarePlatfrom.domain.Apply;
import com.qjz.declarePlatfrom.service.ApplyService;

@Service
public class ApplyServiceImpl implements ApplyService {
	
	@Resource
	private ApplyDao applyDao;

	@Override
	public List<Apply> listApply() {
		List<Apply> list = applyDao.listApply();
		return list;
	}


}
