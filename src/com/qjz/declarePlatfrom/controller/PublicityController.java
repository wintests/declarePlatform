package com.qjz.declarePlatfrom.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.Publicity;
import com.qjz.declarePlatfrom.service.PublicityService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
@RequestMapping("/publicity")
public class PublicityController {
	
	@Resource
	private PublicityService publicityService;
	
	@RequestMapping("/listPublicity")
	@ResponseBody
	public Map<String, Object> listPublicity(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows) {
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = publicityService.listPublicity(currentPage, pageSize);
		return map;
	}
	
	@RequestMapping("/addPublicity")
	@ResponseBody
	public JsonResult addPublicity(Integer item_id) {
		publicityService.addPublicity(item_id);
		return new JsonResult();
	}
	
	@RequestMapping("/updatePublicity")
	@ResponseBody
	public JsonResult updatePublicity(Publicity publicity) {
		publicityService.updatePublicity(publicity);
		return new JsonResult();
	}

}
