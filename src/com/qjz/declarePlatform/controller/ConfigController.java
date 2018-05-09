package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Config;
import com.qjz.declarePlatform.service.ConfigService;
import com.qjz.declarePlatform.util.JsonResult;

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
	
	@RequestMapping("/getConfigStatus")
	@ResponseBody
	public JsonResult getConfigStatus(Model model) {
		String config_flag = configService.getConfigStatus();
		model.addAttribute("config_flag", config_flag);
		return new JsonResult();
	}
	
}
