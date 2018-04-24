package com.qjz.declarePlatfrom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.ApplyDao;
import com.qjz.declarePlatfrom.dao.Review2Dao;
import com.qjz.declarePlatfrom.domain.PageBean;
import com.qjz.declarePlatfrom.domain.Review2;
import com.qjz.declarePlatfrom.service.Review2Service;

@Service
public class Review2ServiceImpl implements Review2Service {
	
	@Resource(name="review2Dao")
	private Review2Dao review2Dao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;

	@Override
	public Map<String, Object> listReview2(int currentPage, int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//总记录数
		Long total = review2Dao.count();
		//得到查询的数据
		List<Review2> list = review2Dao.listReview2(pageBean.getStart(), pageBean.getPageSize());
		try {
			if(list.size() == 0) {
				throw new RuntimeException("未查询到相关数据");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	public void addReview2(Integer item_id, String review2_user) {
		int i = review2Dao.addReview2(item_id, review2_user);
		if(i == 0) {
			throw new RuntimeException("添加专家评审项目失败");
		}
	}

	@Override
	public void updateReview2(Review2 review2) {
		int i = review2Dao.updateReview2(review2);
		String item_status = "2";
		int j = applyDao.changeStatus(review2.getItem_id(), item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("专家评审项目信息失败");
		}
	}

}
