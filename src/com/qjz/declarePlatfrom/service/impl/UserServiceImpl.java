package com.qjz.declarePlatfrom.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatfrom.dao.UserDao;
import com.qjz.declarePlatfrom.domain.PageBean;
import com.qjz.declarePlatfrom.domain.User;
import com.qjz.declarePlatfrom.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userManageDao;

	@Override
	public Map<String, Object> findUserByType(String user_type, int currentPage,
			int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到总记录数
		Long total = userManageDao.count(user_type);
		//得到该用户类型下的所有数据
		List<User> list = userManageDao.findUserByType(user_type,pageBean.getStart(),pageBean.getPageSize());
		if(list.size() == 0) {
			throw new RuntimeException("未查询到相关数据");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	@Transactional
	public void updateUserById(User user) {
		int i = userManageDao.updateUserById(user);
		int j = userManageDao.updateSignln(user);
		if(i == 0 || j == 0) {
			throw new RuntimeException("更新失败！");
		}
	}
	
	@Override
	@Transactional
	public void modifyPassword(String user_name, String user_pass) {
		int i = userManageDao.modifyPassword(user_name,user_pass);
		int j = userManageDao.modifySignlnPassword(user_name,user_pass);
		if(i == 0 || j == 0) {
			throw new RuntimeException("密码修改失败！");
		}
		
	}

	@Override
	@Transactional
	public void addUser(User user) {
		int i = userManageDao.addUser(user);
		int j = userManageDao.addSignln(user);
		if(i == 0 || j == 0) {
			throw new RuntimeException("添加失败！");
		}
	}

	@Override
	@Transactional
	public void deleteUserById(Integer user_id) {
		String user_name = userManageDao.findNameById(user_id);
		int i = userManageDao.deleteUserById(user_id);
		int j = userManageDao.deleteSignlnByName(user_name);
		if(i == 0 || j == 0 || user_name == null) {
			throw new RuntimeException("删除失败！");
		}
	}

	@Override
	@Transactional
	public void deleteUserBatchs(String idsStr) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for(int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		List<String> list = new ArrayList<String>();
		for (Integer integer : ids) {
			String user_name = userManageDao.findNameById(integer);
			list.add(user_name);
		}
		int i = userManageDao.deleteUserBatchs(ids);
		int j = userManageDao.deleteSignlnBatchs(list);
		if(i == 0 || j == 0) {
			throw new RuntimeException("删除失败！");
		}
	}

}
