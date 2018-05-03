package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.Review1;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.Review1Service;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/review1")
public class Review1Controller {
	
	@Resource
	private Review1Service review1Service;
	
	@RequestMapping("/department/review1Manage")
	public String review1Manage(HttpServletRequest request, Apply apply,
			@RequestParam(value = "review1_status", required = false) String review1_status) {
		/**
		 * 传入的apply对象指history_flag字段，而传入的review1_status可能为“1”(未审核状态)，也可能为“2,3”(已审核状态)
		 */
//		String[] status = review1_status.split(",");
//		List<String> list = new ArrayList<String>();
//		for (String string : status) {
//			list.add(string);
//		}
		request.setAttribute("review1_status", review1_status);
		User user = (User) request.getSession().getAttribute("user");
		if(user != null) {
			if("3".equals(user.getUser_type())) {
				String user_department = user.getUser_department();
				apply.setUser_department(user_department);
			}
		}
		request.setAttribute("apply", apply);
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
			@RequestParam(value = "str", required = false) String str,
			Apply apply, User user) {
		
		/**
		 * 传入的apply对象主要包括以下字段：
		 * 		user_department、item_type、history_flag
		 * 而传入的review1_status可能为“1”(未审核状态)，也可能为“2,3”(已审核状态)
		 */
		
		System.out.println(apply);
		System.out.println(user);
		
		if(review1_status == null) {
			review1_status = "";
		}
		
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = review1Service.listReview1(review1_status, apply, user, str, currentPage, pageSize);
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
