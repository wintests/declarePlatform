package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatform.dao.ApplyDao;
import com.qjz.declarePlatform.dao.Review1Dao;
import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.service.ApplyService;

@Service
public class ApplyServiceImpl implements ApplyService {
	
	/**
	 * 这里需要写两个@Resource注解，因为一个注解只对应一个变量
	 */
	@Resource(name="applyDao")
	private ApplyDao applyDao;
	
	@Resource(name="review1Dao")
	private Review1Dao review1Dao;

	@Override
	public Map<String, Object> listApply(String item_name, int currentPage,
			int pageSize) {
		//定义分页PageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//总记录数
		Long total = applyDao.count(item_name);
		//得到查询出来的数据
		List<Apply> list = applyDao.listApply(item_name, pageBean.getStart(), pageBean.getPageSize());
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
	public void updateApply(Apply apply) {
		int i = applyDao.updateApply(apply);
		if(i == 0) {
			throw new RuntimeException("更新项目申报书失败！");
		}
	}

	@Override
	@Transactional
	public void addApply(Apply apply) {
		int i = applyDao.addApply(apply);
		if(i == 0) {
			throw new RuntimeException("添加项目申请失败！");
		}
	}

	@Override
	@Transactional
	public void deleteApplyById(Integer item_id) {
		int i = applyDao.deleteApplyById(item_id);
		if(i == 0) {
			throw new RuntimeException("删除项目申请失败！");
		}
	}

	@Override
	@Transactional
	public void deleteApplyBatchs(String idsStr) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = applyDao.deleteApplyBatchs(ids);
		if(i == 0) {
			throw new RuntimeException("批量删除项目申请失败！");
		}
	}

	@Override
	@Transactional
	public void submitApply(Integer item_id, String item_submit) {
		int i = applyDao.submitApply(item_id, item_submit);
		if(i != 0) {
			int j = review1Dao.addReview1(item_id);
			String item_status = "1";
			int k = applyDao.changeStatus(item_id, item_status);
			if(j == 0 || k == 0) {
				throw new RuntimeException("添加到系部审核列表失败！");
			}
		} else {
			throw new RuntimeException("提交项目申报书失败！");
		}
	}

	@Override
	@Transactional
	public void submitApplyBatchs(String idsStr, String item_submit) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = applyDao.submitApplyBatchs(ids, item_submit);
		if(i != 0) {
			int j = review1Dao.addReview1Batchs(ids);
			String item_status = "1";
			for (Integer item_id : ids) {
				applyDao.changeStatus(item_id, item_status);
			}
			if(j == 0) {
				throw new RuntimeException("批量添加到系部审核列表失败！");
			}
		} else {
			throw new RuntimeException("批量提交项目申报书失败！");
		}
	}

}
