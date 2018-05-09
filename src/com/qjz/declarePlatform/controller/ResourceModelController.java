package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.ResourceModel;
import com.qjz.declarePlatform.service.ResourceModelService;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/resourceModel")
public class ResourceModelController {
	
	@Resource
	private ResourceModelService resourceModelService;
	
	@RequestMapping("/resourceModel")
	public String configSwitch(String config_flag) {
		return "admin/model";
	}
	
	@RequestMapping("/listResourceModel")
	@ResponseBody
	public Map<String, Object> listResourceModel() {
		Map<String, Object> map = resourceModelService.listResourceModel();
		return map;
	}
	
	@RequestMapping("/addResourceModel")
	@ResponseBody
	public JsonResult addResourceModel(ResourceModel resourceModel) {
		resourceModelService.addResourceModel(resourceModel);
		return new JsonResult();
	}
	
}
