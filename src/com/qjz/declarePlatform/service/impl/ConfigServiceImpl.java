package com.qjz.declarePlatform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qjz.declarePlatform.dao.ApplyDao;
import com.qjz.declarePlatform.dao.ConfigDao;
import com.qjz.declarePlatform.domain.Config;
import com.qjz.declarePlatform.service.ConfigService;

@Service
public class ConfigServiceImpl implements ConfigService {
	
	@Resource(name="configDao")
	private ConfigDao configDao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;

	@Override
	@Transactional
	public void updateConfig(Config config) {
		int i = configDao.updateConfig(config);
		if(i != 0) {
			int j = applyDao.setHistory();
			if(j == 0) {
				throw new RuntimeException("设置时间标志失败！");
			}
		} else {
			throw new RuntimeException("更改项目阶段失败！");
		}
	}

	@Override
	public Map<String, Object> show() {
		Long total = configDao.count();
		List<Config> list = configDao.show();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

}
