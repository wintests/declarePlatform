package com.qjz.declarePlatfrom.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.User;
import com.qjz.declarePlatfrom.service.UserService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Resource
	private UserService userManagerService;
	
	@RequestMapping("/admin/modifyInfo")
	public String modifyInfo() {
		return "admin/modifyInfo";
	}
	
	@RequestMapping("/admin/TypeManage")
	public String TypeManage() {
		return "admin/TypeManage";
	}
	
	@RequestMapping("/admin/userManage")
	public String userManage(
			Model model,
			@RequestParam(value = "user_type", required = false) String user_type) {
		model.addAttribute("user_type",user_type);
		System.out.println(user_type);
		return "admin/userManage";
	}
	
	//分页查询用户
	@RequestMapping("/findUserByType")
	@ResponseBody
	public Map<String, Object> findUserByType(
			//page第几页，rows每页多少行，user_type用户类型
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "user_type", required = false) String user_type) {
		if(user_type == null) {
			user_type = "2";
		}
		int currentPage = 1;	//默认当前页，即刚进入系统时默认第一页
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int pageSize = 5;	//默认每页显示条数，即刚进入系统时每页显示10条记录
		if(rows != null) {
			pageSize = Integer.parseInt(rows);
		}
		Map<String, Object> map = userManagerService.findUserByType(user_type, currentPage, pageSize);
//		List<User> list = userManagerService.findUserByType(user_type);
		return map;
	}
	
	//更新用户
	@RequestMapping("/updateUser")
	@ResponseBody
	public JsonResult updateUser(User user) {
		userManagerService.updateUser(user);
		return new JsonResult();
	}
	
	//新增用户
	@RequestMapping("/addUser")
	@ResponseBody
	public JsonResult addUser(User user) {
		userManagerService.addUser(user);
		return new JsonResult();
	}
	
	//根据用户名删除
	@RequestMapping("deleteUserByName")
	@ResponseBody
	public JsonResult deleteUserByName(String user_name) {
		//System.out.println(user_name);
		userManagerService.deleteUserByName(user_name);
		return new JsonResult();
	}
	
	//批量删除
	@RequestMapping("deleteUserBatchs")
	@ResponseBody
	public JsonResult deleteUserBatchs(String names) {
		//System.out.println(names);
		userManagerService.deleteUserBatchs(names);
		return new JsonResult();
	}
	
}
