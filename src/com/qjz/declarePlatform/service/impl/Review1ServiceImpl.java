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
import com.qjz.declarePlatform.dao.Review1Dao;
import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.Config;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.Review1;
import com.qjz.declarePlatform.service.Review1Service;

@Service
public class Review1ServiceImpl implements Review1Service{
	
	@Resource(name="review1Dao")
	private Review1Dao review1Dao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;
	
	@Resource(name="configDao")
	private ConfigDao configDao;

	@Override
	public Map<String, Object> listReview1(String review1_status, Apply apply, String str, int currentPage, int pageSize) {
		//apply.review1_status可能为1(未审核)，也可能是"2,3"(已审核，包括审核通过和审核不通过)
		String[] status = review1_status.split(",");
//		List<String> status = new ArrayList<String>();
//		for (String s : array) {
//			status.add(s);
//		}
		if(review1_status == "")
			status = null;
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
			 * 1 判断config_flag项目进度是否为系部审核阶段，如果不是则无法获取到数据
			 * 2 如果history_flag为"2"，则表示为历史记录，可以获取到数据
			 */
			if("2".equals(config_flag) || "2".equals(history_flag)) {
				//总记录数
				total = review1Dao.count(status, apply, str);
				//得到查询的数据(多表查询)
				list = review1Dao.listReview1(status, apply, str, pageBean.getStart(), pageBean.getPageSize());
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
		//System.out.println("状态：" + map);
		return map;
	}

	@Override
	@Transactional
	public void addReview1(Integer item_id) {
		int i = review1Dao.addReview1(item_id);
		if(i == 0) {
			throw new RuntimeException("添加系部审核项目失败！");
		}
	}
	
	@Override
	@Transactional
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
	@Transactional
	public void updateReview1(Review1 review1) {
		String review1_status = review1.getReview1_status();
		int i = review1Dao.updateReview1(review1);
		String item_status = "1";
		/**
		 * 这里用equals来做比较，equals仅要求内容相同，不管是否是同一引用对象
		 * 如果用  == 的话，不仅要求内容相同，并且引用对象也要相同，而String为引用数据类型，
		 * 如review1_status的内容为"2"，但review1_status=="2"返回的是false
		 */
		if("2".equals(review1_status)) {		//审核通过
			item_status = "2";
		} else if("3".equals(review1_status)) {
			item_status = "6";
		}
		int j = applyDao.changeStatus(review1.getItem_id(), item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("系部审核项目失败！");
		}
	}


}
