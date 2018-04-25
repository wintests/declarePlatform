package com.qjz.declarePlatform.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Signln;
import com.qjz.declarePlatform.service.SignlnService;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
public class SignlnController {

	@Resource
	private SignlnService signlnService;
	
	@RequestMapping("/checklogin")
	@ResponseBody
	public JsonResult login(HttpServletRequest request, Signln signln) {
		Signln si = signlnService.login(signln);
		//将user对象保存到session中，session默认保存时间为30min
		request.getSession().setAttribute("si", si);
		return new JsonResult(si);
	}
	
	@RequestMapping("/show")
	@ResponseBody
	public JsonResult showAll() {
		List<Signln> list = signlnService.show();
		return new JsonResult(list);
	}
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		if(request.getSession().getAttribute("si") != null) {
			return "redirect:home.do";
		}
		return "login";
	}
	
	@RequestMapping("/home")
	public String home(HttpServletRequest request) {
		Signln signln = (Signln) request.getSession().getAttribute("si");
		request.getSession().setAttribute("si", signln);
		if(signln != null) {
			int user_type = Integer.parseInt(signln.getUser_type());
			switch (user_type) {
			case 1:
				return "admin/main1";
			case 2:
				return "manager/main2";
			case 3:
				return "department/main3";
			case 4:
				return "expert/main4";
			case 5:
				return "user/main5";
			default:
				return "redirect:login.do";
			}
		}
		return "redirect:login.do";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		//Session销毁用户对象，实现注销功能
		request.getSession().invalidate();
		return "redirect:login.do";
	}
	
}
