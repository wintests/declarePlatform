package com.qjz.declarePlatfrom.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.Signln;
import com.qjz.declarePlatfrom.service.SignlnService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
public class SignlnController {

	@Resource
	private SignlnService signlnService;
	
	@RequestMapping("/login")
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
	
	@RequestMapping("/hello")
	public String hello() {
		return "login";
	}
	
	@RequestMapping("/admin")
	public String admin(HttpServletRequest request) {
		Signln signln = (Signln) request.getSession().getAttribute("si");
		request.getSession().setAttribute("si", signln);
		int user_type = Integer.parseInt(signln.getUser_type());
		switch (user_type) {
		case 1:
			return "home";
		case 2:
			return "manager";
		case 3:
			return "department";
		case 4:
			return "expert";
		case 5:
			return "user";
		default:
			return "login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		//Session销毁用户对象，实现注销功能
		request.getSession().invalidate();
		return "redirect:hello.do";
	}
	
}
