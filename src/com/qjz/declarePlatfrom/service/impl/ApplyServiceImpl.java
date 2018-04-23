package com.qjz.declarePlatfrom.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	@Transactional
	public void updateApply(Apply apply) {
		int i = applyDao.updateApply(apply);
		if(i == 0) {
			throw new RuntimeException("更新失败！");
		}
	}

	@Override
	@Transactional
	public void addApply(Apply apply) {
		int i = applyDao.addApply(apply);
		if(i == 0) {
			throw new RuntimeException("添加失败！");
		}
	}

	@Override
	@Transactional
	public void deleteApplyById(Integer item_id) {
		int i = applyDao.deleteApplyById(item_id);
		if(i == 0) {
			throw new RuntimeException("删除失败！");
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
			throw new RuntimeException("批量删除失败！");
		}
	}

	@Override
	public void submitApply(Integer item_id, String item_submit) {
		int i = applyDao.submitApply(item_id,item_submit);
		if(i == 0) {
			throw new RuntimeException("提交失败！");
		}
	}

	@Override
	public void submitApplyBatchs(String idsStr, String item_submit) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = applyDao.submitApplyBatchs(ids, item_submit);
		if(i == 0) {
			throw new RuntimeException("批量提交失败！");
		}
	}

}
