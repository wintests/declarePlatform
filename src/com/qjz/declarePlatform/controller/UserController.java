package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.UserService;
import com.qjz.declarePlatform.util.JsonResult;

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
	public String userManage(Model model,
			@RequestParam(value = "user_type", required = false) String user_type) {
		model.addAttribute("user_type",user_type);
		return "admin/userManage";
	}
	
	//分页查询用户
	@RequestMapping("/findUserByType")
	@ResponseBody
	public Map<String, Object> findUserByType(
			//page第几页，rows每页多少行，user_type用户类型
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "user_type", required = false) String user_type,
			@RequestParam(value = "str", required = false) String str,
			@RequestParam(value = "user_department", required = false) String user_department,
			@RequestParam(value = "user_title", required = false) String user_title,
			@RequestParam(value = "signln_valid", required = false) String signln_valid) {
		User user = new User();
		user.setUser_department(user_department);
		user.setUser_title(user_title);
		user.setSignln_valid(signln_valid);
		if(user_type == null) {
			user_type = "";
		}
		int currentPage = 1;	//默认当前页，即刚进入系统时默认第一页
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int pageSize = 5;	//默认每页显示条数，即刚进入系统时每页显示10条记录
		if(rows != null) {
			pageSize = Integer.parseInt(rows);
		}
		Map<String, Object> map = userManagerService.findUserByType(user_type, str, user, currentPage, pageSize);
		return map;
	}
	
	//更新用户
	@RequestMapping("/updateUser")
	@ResponseBody
	public JsonResult updateUser(User user) {
		System.out.println("更新：" + user);
		userManagerService.updateUserById(user);
		return new JsonResult();
	}
	
	//修改用户密码
	@RequestMapping("/modifyPassword")
	@ResponseBody
	public JsonResult modifyPassword(String user_name, String user_pass) {
		userManagerService.modifyPassword(user_name,user_pass);
		return new JsonResult();
	}
	
	//新增用户
	@RequestMapping("/addUser")
	@ResponseBody
	public JsonResult addUser(User user) {
		/*因前台有两个相同name的input(用户名)，所以将会以数组形式组成新的user_name传到后台
		 * 其中一个用户名为hidden，另一个为文本框，在添加用户时一个为空，另一个为输入的用户名
		 * 传到后台的形式为：,XXX，因此需要对其进行处理*/
		//System.out.println(user.getUser_name().substring(1));
		user.setUser_name(user.getUser_name().substring(1));
		userManagerService.addUser(user);
		return new JsonResult();
	}
	
	//根据id删除用户
	@RequestMapping("deleteUserById")
	@ResponseBody
	public JsonResult deleteUserById(Integer user_id) {
		userManagerService.deleteUserById(user_id);
		return new JsonResult();
	}
	
	//批量删除
	@RequestMapping("deleteUserBatchs")
	@ResponseBody
	public JsonResult deleteUserBatchs(String idsStr) {
		userManagerService.deleteUserBatchs(idsStr);
		return new JsonResult();
	}
	
	//更改用户状态
	@RequestMapping("/changeUserStatus")
	@ResponseBody
	public JsonResult changeUserStatus(Integer user_id, String signln_valid) {
		userManagerService.changeUserStatus(user_id, signln_valid);
		return new JsonResult();
	}
	
	//批量更改用户状态
	@RequestMapping("/changeUserStatusBatchs")
	@ResponseBody
	public JsonResult changeUserStatusBatchs(String idsStr, String signln_valid) {
		userManagerService.changeUserStatusBatchs(idsStr, signln_valid);
		return new JsonResult();
	}
	
}
