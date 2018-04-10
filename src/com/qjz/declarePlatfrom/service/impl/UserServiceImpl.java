package com.qjz.declarePlatfrom.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatfrom.dao.UserDao;
import com.qjz.declarePlatfrom.domain.User;
import com.qjz.declarePlatfrom.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userManagerMapper;

	@Override
	public List<User> findUserByType(String user_type) {
		List<User> list = userManagerMapper.findUserByType(user_type);
		if(list.size() == 0) {
			throw new RuntimeException("未查询到相关数据");
		}
		return list;
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
		String id = userManagerMapper.findIdByName(user_name);
		int j = userManagerMapper.deleteSignlnById(Integer.parseInt(id));
		if(i == 0 || j == 0 || id == null) {
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
			String id = userManagerMapper.findIdByName(s);
			list.add(Integer.parseInt(id));
		}
		int j = userManagerMapper.deleteSignlnBatchs(list);
		if(i == 0 || j == 0) {
			throw new RuntimeException("删除失败！");
		}
	}

}
