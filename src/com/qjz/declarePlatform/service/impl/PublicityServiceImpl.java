package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatform.dao.ApplyDao;
import com.qjz.declarePlatform.dao.PublicityDao;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.Publicity;
import com.qjz.declarePlatform.service.PublicityService;

@Service
public class PublicityServiceImpl implements PublicityService {
	
	@Resource(name="publicityDao")
	private PublicityDao publicityDao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;

	@Override
	public Map<String, Object> listPublicity(String publicity_status, int currentPage, int pageSize) {
		//review1_status可能为1(未审核)，也可能是"2,3"(已审核，包括审核通过和审核不通过)
		String[] status = publicity_status.split(",");
		if(publicity_status == "")
			status = null;
		//定义分页PageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//总记录数
		Long total = publicityDao.count(status);
		//得到查询的数据
		List<Map<String, Object>> list = publicityDao.listPublicity(status, pageBean.getStart(), pageBean.getPageSize());
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
	public void addPublicity(Integer item_id) {
		Publicity publicity = publicityDao.getPublicity(item_id);
		int i = publicityDao.addPublicity(publicity.getItem_id(), publicity.getItem_user(), publicity.getReview1_user(), publicity.getReview2_user(), publicity.getReview2_score());
		if(i == 0) {
			throw new RuntimeException("添加到立项列表失败");
		}
	}

	@Override
	@Transactional
	public void updatePublicity(Publicity publicity) {
		String publicity_status = publicity.getPublicity_status();
		String item_status = "4";
		if("2".equals(publicity_status)) {	//立项通过
			int i = publicityDao.updatePublicity(publicity);
			if(i == 0) {
				throw new RuntimeException("立项失败");
			}
			item_status = "5";
		} else if("3".equals(publicity_status)) {
			item_status = "6";
		}
		int j = applyDao.changeStatus(publicity.getItem_id(), item_status);
		if(j == 0) {
			throw new RuntimeException("更新项目状态失败");
		}
	}

}
