package com.qjz.declarePlatfrom.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatfrom.domain.Apply;
import com.qjz.declarePlatfrom.service.ApplyService;
import com.qjz.declarePlatfrom.util.JsonResult;

@Controller
@RequestMapping("/apply")
public class ApplyController {
	
	@Resource
	private ApplyService applyService;
	
	//显示所有申报项目
	@RequestMapping("/listApply")
	@ResponseBody
	public Map<String, Object> listApply(
			//page第几页，rows每页多少行，item_name申报项目名称
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "item_name", required = false) String item_name) {
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = applyService.listApply(item_name, currentPage, pageSize);
		return map;
	}
	
	//更新申报信息
	@RequestMapping("/updateApply")
	@ResponseBody
	public JsonResult updateApply(Apply apply) {
		applyService.updateApply(apply);
		return new JsonResult();
	}
	
	//新增申报信息
	@RequestMapping("/addApply")
	@ResponseBody
	public JsonResult addApply(Apply apply) {
		applyService.addApply(apply);
		return new JsonResult();
	}
	
	//根据id删除申报信息
	@RequestMapping("/deleteApplyById")
	@ResponseBody
	public JsonResult deleteApplyById(Integer item_id) {
		applyService.deleteApplyById(item_id);
		return new JsonResult();
	}
	
	//批量删除
	@RequestMapping("/deleteApplyBatchs")
	@ResponseBody
	public JsonResult deleteApplyBatchs(String idsStr) {
		applyService.deleteApplyBatchs(idsStr);
		return new JsonResult();
	}
	
	//更改提交状态（未提交->已提交）
	@RequestMapping("/submitApply")
	@ResponseBody
	public JsonResult submitApply(Integer item_id, String item_submit) {
		applyService.submitApply(item_id, item_submit);
		return new JsonResult();
	}
	
	//批量提交
	@RequestMapping("/submitApplyBatchs")
	@ResponseBody
	public JsonResult submitApplyBatchs(String idsStr, String item_submit) {
		applyService.submitApplyBatchs(idsStr, item_submit);
		return new JsonResult();
	}

}
