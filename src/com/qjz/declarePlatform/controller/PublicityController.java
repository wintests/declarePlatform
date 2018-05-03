package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.Publicity;
import com.qjz.declarePlatform.domain.User;
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
	public String publicityManage(Model model, Apply apply,
			@RequestParam(value = "publicity_status", required = false) String publicity_status) {
		/**
		 * 传入的apply对象指history_flag字段，而传入的publicity_status可能为“1”(未审批状态)，也可能为“2,3”(已审批状态)
		 */
		model.addAttribute("publicity_status", publicity_status);
		model.addAttribute("apply", apply);
		return "itemManager/publicityManage";
	}
	
	@RequestMapping("/listPublicity")
	@ResponseBody
	public Map<String, Object> listPublicity(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "publicity_status", required = false) String publicity_status,
			@RequestParam(value = "str", required = false) String str,
			Apply apply, User user) {
		
		System.out.println("apply状态1：" + apply);
		System.out.println("user状态1：" + user);
		System.out.println("publicity_status状态1：" + publicity_status);
		System.out.println("str状态1：" + str);
		
		if(publicity_status == null) {
			publicity_status ="";
		}
		
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = publicityService.listPublicity(publicity_status, apply, user, str, currentPage, pageSize);
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
