package com.qjz.declarePlatfrom.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.Review1Dao;
import com.qjz.declarePlatfrom.domain.Review1;
import com.qjz.declarePlatfrom.service.Review1Service;

@Service
public class Review1ServiceImpl implements Review1Service{
	
	@Resource
	private Review1Dao review1Dao;

	@Override
	public List<Review1> listReview1() {
		List<Review1> list = review1Dao.listReview1();
		return list;
	}

	@Override
	public void addReview1(Integer item_id) {
		int i = review1Dao.addReview1(item_id);
		if(i == 0) {
			throw new RuntimeException("添加系部审核项目失败！");
		}
	}

	@Override
	public void updateReview1(Review1 review1) {
		int i = review1Dao.updateReview1(review1);
		if(i == 0) {
			throw new RuntimeException("更新审核项目失败！");
		}
	}


}
