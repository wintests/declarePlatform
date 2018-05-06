package com.qjz.declarePlatform.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatform.dao.UserDao;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.UserService;


@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userManageDao;
	
	@Override
	public List<User> listExpert() {
		List<User> list = userManageDao.listExpert();
		return list;
	}

	@Override
	public Map<String, Object> findUserByType(String str, User user, int currentPage,
			int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到总记录数
		Long total = userManageDao.count(str, user);
		//得到该用户类型下的所有数据
		List<User> list = userManageDao.findUserByType(str, user, pageBean.getStart(),pageBean.getPageSize());
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
	public void updateUserById(User user) {
		int i = userManageDao.updateUserById(user);
		int j = userManageDao.updateSignln(user);
		if(i == 0 || j == 0) {
			throw new RuntimeException("更新信息失败，请重新操作！");
		}
	}
	
	@Override
	@Transactional
	public void modifyPassword(String user_name, String user_pass) {
		int i = userManageDao.modifyPassword(user_name,user_pass);
		int j = userManageDao.modifySignlnPassword(user_name,user_pass);
		if(i == 0 || j == 0) {
			throw new RuntimeException("密码修改失败，请重新操作！");
		}
		
	}

	@Override
	@Transactional
	public void addUser(User user) {
		int i = userManageDao.addUser(user);
		int j = userManageDao.addSignln(user);
		if(i == 0 || j == 0) {
			throw new RuntimeException("添加用户失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void deleteUserById(Integer user_id) {
		String user_name = userManageDao.findNameById(user_id);
		int i = userManageDao.deleteUserById(user_id);
		int j = userManageDao.deleteSignlnByName(user_name);
		if(i == 0 || j == 0 || user_name == null) {
			throw new RuntimeException("删除用户失败，请重新操作！");
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
			throw new RuntimeException("批量删除用户失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void changeUserStatus(Integer user_id, String signln_valid) {
		String user_name = userManageDao.findNameById(user_id);
		int i = userManageDao.changeUserStatus(user_id, signln_valid);
		int j = userManageDao.changeSignlnStatus(user_name, signln_valid);
		if(i == 0 || j == 0) {
			throw new RuntimeException("更改用户状态失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void changeUserStatusBatchs(String idsStr, String signln_valid) {
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
		int i = userManageDao.changeUserStatusBatchs(ids, signln_valid);
		int j = userManageDao.changeSignlnStatusBatchs(list, signln_valid);
		if(i == 0 || j == 0) {
			throw new RuntimeException("批量更改用户状态失败，请重新操作！");
		}
	}

}
