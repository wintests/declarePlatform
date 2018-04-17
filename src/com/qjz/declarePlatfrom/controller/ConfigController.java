package com.qjz.declarePlatfrom.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.Config;
import com.qjz.declarePlatfrom.service.ConfigService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
public class ConfigController {
	
	@Resource
	private ConfigService configService;
	
	@RequestMapping("/configSwitch")
	public String configSwitch(String config_flag) {
		return "admin/configSwitch";
	}
	
	@RequestMapping("/configShow")
	@ResponseBody
	public Map<String, Object> configShow() {
		Map<String, Object> map = configService.show();
		return map;
	}
	
	@RequestMapping("/updateConfig")
	@ResponseBody
	public JsonResult updateConfig(Config config) {
		configService.updateConfig(config);
		return new JsonResult();
	}
	
}
