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
	private UserDao userManagerMapper;

	@Override
	public Map<String, Object> findUserByType(String user_type, int currentPage,
			int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到总记录数
		Long total = userManagerMapper.count(user_type);
		//得到该用户类型下的所有数据
		List<User> list = userManagerMapper.findUserByType(user_type,pageBean.getStart(),pageBean.getPageSize());
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
	public void updateUser(User user) {
		int i = userManagerMapper.updateUser(user);
		int j = userManagerMapper.updateSignln(user);
		if(i == 0 || j == 0) {
			throw new RuntimeException("更新失败！");
		}
	}

	@Override
	@Transactional
	public void addUser(User user) {
		int i = userManagerMapper.addUser(user);
		int j = userManagerMapper.addSignln(user);
		if(i == 0 || j == 0) {
			throw new RuntimeException("添加失败！");
		}
	}

	@Override
	@Transactional
	public void deleteUserByName(String user_name) {
		int i = userManagerMapper.deleteUserByName(user_name);
		int id = userManagerMapper.findIdByName(user_name);
		//System.out.println(id);
		int j = userManagerMapper.deleteSignlnById(id);
		if(i == 0 || j == 0 || id == -1) {
			throw new RuntimeException("删除失败！");
		}
	}

	@Override
	@Transactional
	public void deleteUserBatchs(String name) {
		String[] names = name.split(",");
		int i = userManagerMapper.deleteUserBatchs(names);
		List<Integer> list = new ArrayList<Integer>();
		for (String s : names) {
			int id = userManagerMapper.findIdByName(s);
			list.add(id);
		}
		int j = userManagerMapper.deleteSignlnBatchs(list);
		if(i == 0 || j == 0) {
			throw new RuntimeException("删除失败！");
		}
	}

}
