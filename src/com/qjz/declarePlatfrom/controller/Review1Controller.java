package com.qjz.declarePlatfrom.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.Review1;
import com.qjz.declarePlatfrom.service.Review1Service;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
@RequestMapping("/review1")
public class Review1Controller {
	
	@Resource
	private Review1Service review1Service;
	
	//显示系部审核列表
	@RequestMapping("/listReview1")
	@ResponseBody
	public Map<String, Object> listReview1(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows) {
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = review1Service.listReview1(currentPage, pageSize);
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
		review1Service.updateReview1(review1);
		return new JsonResult();
	}

}
