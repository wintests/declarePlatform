package com.qjz.declarePlatfrom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatfrom.dao.ApplyDao;
import com.qjz.declarePlatfrom.dao.PublicityDao;
import com.qjz.declarePlatfrom.domain.PageBean;
import com.qjz.declarePlatfrom.domain.Publicity;
import com.qjz.declarePlatfrom.service.PublicityService;

@Service
public class PublicityServiceImpl implements PublicityService {
	
	@Resource(name="publicityDao")
	private PublicityDao publicityDao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;

	@Override
	public Map<String, Object> listPublicity(int currentPage, int pageSize) {
		//定义分页PageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//总记录数
		Long total = publicityDao.count();
		//得到查询的数据
		List<Publicity> list = publicityDao.listPublicity(pageBean.getStart(), pageBean.getPageSize());
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
	public void addPublicity(Integer item_id) {
		Publicity publicity = publicityDao.getPublicity(item_id);
		int i = publicityDao.addPublicity(publicity.getItem_id(), publicity.getItem_user(), publicity.getReview1_user(), publicity.getReview2_user(), publicity.getReview2_score());
		if(i == 0) {
			throw new RuntimeException("添加到立项列表失败");
		}
	}

	@Override
	public void updatePublicity(Publicity publicity) {
		String publicity_status = publicity.getPublicity_status();
		int i = publicityDao.updatePublicity(publicity);
		String item_status = "3";
		if(publicity_status == "2") {	//立项通过
			item_status = "4";
		} else if(publicity_status == "3") {
			item_status = "5";
		}
		int j = applyDao.changeStatus(publicity.getItem_id(), item_status);
		if(i == 0 || j == 0) {
			throw new RuntimeException("更新立项项目信息失败");
		}
	}

}
