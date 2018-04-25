package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatform.dao.ApplyDao;
import com.qjz.declarePlatform.dao.PublicityDao;
import com.qjz.declarePlatform.dao.Review2Dao;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.Publicity;
import com.qjz.declarePlatform.domain.Review2;
import com.qjz.declarePlatform.service.Review2Service;

@Service
public class Review2ServiceImpl implements Review2Service {
	
	@Resource(name="review2Dao")
	private Review2Dao review2Dao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;
	
	@Resource(name="publicityDao")
	private PublicityDao publicityDao;

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
	@Transactional
	public void addReview2(Integer item_id, String review2_user) {
		int i = review2Dao.addReview2(item_id, review2_user);
		if(i == 0) {
			throw new RuntimeException("添加专家评审项目失败");
		}
	}

	@Override
	@Transactional
	public void updateReview2(Review2 review2) {
		int i = review2Dao.updateReview2(review2);
		String review2_status = review2.getReview2_status();
		String item_status = "2";
		if("2".equals(review2_status)) {
			item_status = "3";
			Publicity publicity = publicityDao.getPublicity(review2.getItem_id());
			int k = publicityDao.addPublicity(review2.getItem_id(), publicity.getItem_user(), 
					publicity.getReview1_user(), publicity.getReview2_user(), publicity.getReview2_score());
			if(k == 0) {
				throw new RuntimeException("添加到项目立项列表失败");
			}
		}
		int j = applyDao.changeStatus(review2.getItem_id(), item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("专家评审项目信息失败");
		}
	}

}
