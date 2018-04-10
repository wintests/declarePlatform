package com.qjz.declarePlatfrom.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.service.ConfigService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
public class ConfigController {
	
	@Resource
	private ConfigService configService;
	
	@RequestMapping("/config")
	@ResponseBody
	public JsonResult config(String config_flag) {
		configService.updateConfig(config_flag);
		return new JsonResult();
	}

}
