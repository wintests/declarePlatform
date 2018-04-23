package com.qjz.declarePlatfrom.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public JsonResult listReview1() {
		List<Review1> list = review1Service.listReview1();
		return new JsonResult(list);
	}
	
	//新增审核项目
	@RequestMapping("/addReview1")
	@ResponseBody
	public JsonResult addReview1(Integer item_id) {
		review1Service.addReview1(item_id);
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
