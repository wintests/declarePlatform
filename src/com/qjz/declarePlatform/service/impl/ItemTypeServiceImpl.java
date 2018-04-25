package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qjz.declarePlatform.dao.ItemTypeDao;
import com.qjz.declarePlatform.domain.ItemType;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.service.ItemTypeService;

@Service
public class ItemTypeServiceImpl implements ItemTypeService {
	
	@Resource
	private ItemTypeDao itemTypeDao;

	@Override
	public Map<String, Object> listItemType(String itemType_name, int currentPage, int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到总记录数
		Long total = itemTypeDao.count(itemType_name);
		//得到该用户类型下的所有数据
		List<ItemType> list = itemTypeDao.listItemType(itemType_name, pageBean.getStart(), pageBean.getPageSize());
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
	public void updateItemType(ItemType itemType) {
		int i = itemTypeDao.updateItemType(itemType);
		if(i == 0) {
			throw new RuntimeException("更新分类信息失败！");
		}
	}

	@Override
	public void addItemType(ItemType itemType) {
		int i = itemTypeDao.addItemType(itemType);
		if(i == 0) {
			throw new RuntimeException("新增分类失败！");
		}
	}

	@Override
	public void deleteItemType(Integer itemType_id) {
		int i = itemTypeDao.deleteItemType(itemType_id);
		if(i == 0) {
			throw new RuntimeException("删除分类失败！");
		}
	}

}
