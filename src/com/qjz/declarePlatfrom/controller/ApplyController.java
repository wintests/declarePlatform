package com.qjz.declarePlatfrom.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.Apply;
import com.qjz.declarePlatfrom.service.ApplyService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
@RequestMapping("/apply")
public class ApplyController {
	
	@Resource
	private ApplyService applyService;
	
	@RequestMapping("/list")
	@ResponseBody
	public JsonResult list() {
		List<Apply> list = applyService.listApply();
		return new JsonResult(list);
	}

}
