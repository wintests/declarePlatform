package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Review1;
import com.qjz.declarePlatform.service.Review1Service;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/review1")
public class Review1Controller {
	
	@Resource
	private Review1Service review1Service;
	
	@RequestMapping("/department/review1Manage")
	public String review1Manage(Model model,
			@RequestParam(value = "review1_status", required = false) String review1_status) {
		//System.out.println("状态1为：" + review1_status);
//		String[] status = review1_status.split(",");
//		List<String> list = new ArrayList<String>();
//		for (String string : status) {
//			list.add(string);
//		}
//		System.out.println("状态1为：" + list);
		model.addAttribute("review1_status", review1_status);
		return "department/review1Manage";
	}
	
	//显示系部审核列表
	@RequestMapping("/listReview1")
	@ResponseBody
	public Map<String, Object> listReview1(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "review1_status", required = false) String review1_status,
			@RequestParam(value = "item_type", required = false) String item_type,
			@RequestParam(value = "str", required = false) String str) {
		
		if(review1_status == null) {
			review1_status ="";
		}
		
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = review1Service.listReview1(review1_status, item_type, str, currentPage, pageSize);
		return map;
	}
	
	//新增审核项目
	@RequestMapping("/addReview1")
	@ResponseBody
	public JsonResult addReview1(Integer item_id) {
		review1Service.addReview1(item_id);
		return new JsonResult();
	}
	
	//批量新增审核项目
	@RequestMapping("/addReview1Batchs")
	@ResponseBody
	public JsonResult addReview1Batchs(String idsStr) {
		review1Service.addReview1Batchs(idsStr);
		return new JsonResult();
	}
	
	//更新审核项目
	@RequestMapping("/updateReview1")
	@ResponseBody
	public JsonResult updateReview1(Review1 review1) {
		//System.out.println(review1);
		review1Service.updateReview1(review1);
		return new JsonResult();
	}

}
