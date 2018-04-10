package com.qjz.declarePlatfrom.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.User;
import com.qjz.declarePlatfrom.service.UserService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Resource
	private UserService userManagerService;
	
	@RequestMapping("/findUserByType")
	@ResponseBody
	public JsonResult findUserByType(String user_type) {
		List<User> list = userManagerService.findUserByType(user_type);
		return new JsonResult(list);
	}
	
	@RequestMapping("/updateUser")
	@ResponseBody
	public JsonResult updateUser(User user) {
		userManagerService.updateUser(user);
		return new JsonResult();
	}
	
	@RequestMapping("/addUser")
	@ResponseBody
	public JsonResult addUser(User user) {
		userManagerService.addUser(user);
		return new JsonResult();
	}
	
	@RequestMapping("deleteUserByName")
	@ResponseBody
	public JsonResult deleteUserByName(String user_name) {
		userManagerService.deleteUserByName(user_name);
		return new JsonResult();
	}
	
	@RequestMapping("deleteUserBatchs")
	@ResponseBody
	public JsonResult deleteUserBatchs(String names) {
		System.out.println(names);
		userManagerService.deleteUserBatchs(names);
		return new JsonResult();
	}
	

}
