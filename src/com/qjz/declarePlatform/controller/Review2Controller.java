package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Review2;
import com.qjz.declarePlatform.domain.Signln;
import com.qjz.declarePlatform.service.Review2Service;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/review2")
public class Review2Controller {
	
	@Resource
	private Review2Service review2Service;
	
	@RequestMapping("/expert/review2Manage")
	public String review2Manage(HttpServletRequest request,
			@RequestParam(value = "review2_status", required = false) String review2_status) {
		request.setAttribute("review2_status", review2_status);
		Signln si = (Signln)request.getSession().getAttribute("si");
		if("4".equals(si.getUser_type())) {
			String review2_user = si.getUser_name();
			request.setAttribute("review2_user", review2_user);
		}
		return "expert/review2Manage";
	}
	
	@RequestMapping("/listReview2")
	@ResponseBody
	public Map<String, Object> listReview2(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "review2_status", required = false) String review2_status,
			@RequestParam(value = "review2_user", required = false) String review2_user) {
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = review2Service.listReview2(review2_user, review2_status, currentPage, pageSize);
		return map;
	}
	
	@RequestMapping("/addReview2")
	@ResponseBody
	public JsonResult addReview2(Integer item_id, String review2_user) {
		//System.out.println("1:" + item_id);
		//System.out.println("2:" + review2_user);
		review2Service.addReview2(item_id, review2_user);
		return new JsonResult();
	}
	
	@RequestMapping("/updateReview2")
	@ResponseBody
	public JsonResult updateReview2(Review2 review2) {
		//System.out.println(review2);
		review2Service.updateReview2(review2);
		return new JsonResult();
	}

}
