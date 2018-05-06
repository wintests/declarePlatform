package com.qjz.declarePlatform.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatform.dao.ApplyDao;
import com.qjz.declarePlatform.dao.ConfigDao;
import com.qjz.declarePlatform.dao.PublicityDao;
import com.qjz.declarePlatform.dao.Review2Dao;
import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.Config;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.Publicity;
import com.qjz.declarePlatform.domain.Review2;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.Review2Service;

@Service
public class Review2ServiceImpl implements Review2Service {
	
	@Resource(name="review2Dao")
	private Review2Dao review2Dao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;
	
	@Resource(name="publicityDao")
	private PublicityDao publicityDao;
	
	@Resource(name="configDao")
	private ConfigDao configDao;

	@Override
	public Map<String, Object> listReview2(Review2 review2, Apply apply, User user, String str, int currentPage, int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		
		//new一个map，用来存储total和rows，以返回到前台
		Map<String, Object> map = new HashMap<String, Object>();
		Long total = 0L;
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		List<Config> lConfigs = configDao.show();
		if(lConfigs != null && apply != null) {
			String config_flag = lConfigs.get(0).getConfig_flag();
			String history_flag = apply.getHistory_flag();
			/**
			 * 1 判断config_flag项目进度是否为专家评审阶段，如果不是则无法获取到数据
			 * 2 如果history_flag为"2"，则表示为历史记录，可以获取到数据
			 */
			if("3".equals(config_flag) || "4".equals(config_flag) || "5".equals(config_flag) || "2".equals(history_flag)) {
				//总记录数
				total = review2Dao.count(review2, apply, user, str);
				//得到查询的数据
				list = review2Dao.listReview2(review2, apply, user, str, pageBean.getStart(), pageBean.getPageSize());
				try {
					if(list.size() == 0) {
						throw new RuntimeException("未查询到相关数据");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		map.put("total", total);
		map.put("rows", list);
		System.out.println(map);
		return map;
	}

	@Override
	@Transactional
	public void addReview2(Integer item_id, String review2_user) {
		int i = review2Dao.addReview2(item_id, review2_user);
		String item_status = "3";
		int j = applyDao.changeStatus(item_id, item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("分配专家评审项目失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void updateReview2(Review2 review2) {
		review2.setReview2_status("2");
		//System.out.println("状态：" + review2);
		int i = review2Dao.updateReview2(review2);
		String review2_status = review2.getReview2_status();
		String item_status = "3";
		if("2".equals(review2_status)) {
			item_status = "4";
			Publicity publicity = publicityDao.getPublicity(review2.getItem_id());
			int k = publicityDao.addPublicity(review2.getItem_id(), publicity.getItem_user(), 
					publicity.getReview1_user(), publicity.getReview2_user(), publicity.getReview2_score());
			if(k == 0) {
				throw new RuntimeException("添加到项目立项列表失败，请重新操作！");
			}
		}
		int j = applyDao.changeStatus(review2.getItem_id(), item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("专家评审项目信息失败，请重新操作！");
		}
	}

}
