package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Publicity;
import com.qjz.declarePlatform.service.PublicityService;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/publicity")
public class PublicityController {
	
	@Resource
	private PublicityService publicityService;
	
	@RequestMapping("/itemManager/assignExpert")
	public String assignExpert() {
		return "itemManager/assignExpert";
	}
	
	@RequestMapping("/itemManager/publicityManage")
	public String publicityManage(Model model,
			@RequestParam(value = "publicity_status", required = false) String publicity_status) {
		model.addAttribute("publicity_status", publicity_status);
		return "itemManager/publicityManage";
	}
	
	@RequestMapping("/listPublicity")
	@ResponseBody
	public Map<String, Object> listPublicity(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "publicity_status", required = false) String publicity_status) {
		
		if(publicity_status == null) {
			publicity_status ="";
		}
		
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = publicityService.listPublicity(publicity_status, currentPage, pageSize);
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
		//System.out.println(publicity);
		publicityService.updatePublicity(publicity);
		return new JsonResult();
	}

}
