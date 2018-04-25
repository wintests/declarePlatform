package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatform.dao.ApplyDao;
import com.qjz.declarePlatform.dao.Review1Dao;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.Review1;
import com.qjz.declarePlatform.service.Review1Service;

@Service
public class Review1ServiceImpl implements Review1Service{
	
	@Resource(name="review1Dao")
	private Review1Dao review1Dao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;

	@Override
	public Map<String, Object> listReview1(int currentPage, int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//总记录数
		Long total = review1Dao.count();
		//得到查询的数据
		List<Review1> list = review1Dao.listReview1(pageBean.getStart(), pageBean.getPageSize());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	public void addReview1(Integer item_id) {
		int i = review1Dao.addReview1(item_id);
		if(i == 0) {
			throw new RuntimeException("添加系部审核项目失败！");
		}
	}
	
	@Override
	public void addReview1Batchs(String idsStr) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = review1Dao.addReview1Batchs(ids);
		if(i == 0) {
			throw new RuntimeException("批量添加系部审核项目失败！");
		}
	}

	@Override
	public void updateReview1(Review1 review1) {
		String review1_status = review1.getReview1_status();
		int i = review1Dao.updateReview1(review1);
		String item_status = "1";
		if(review1_status == "2") {		//审核通过
			item_status = "2";
		} else if(review1_status == "3") {
			item_status = "5";
		}
		int j = applyDao.changeStatus(review1.getItem_id(), item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("系部审核项目失败！");
		}
	}


}
