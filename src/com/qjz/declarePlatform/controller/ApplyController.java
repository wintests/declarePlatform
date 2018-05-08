package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.ApplyService;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/apply")
public class ApplyController {
	
	@Resource
	private ApplyService applyService;
	
	//跳转到页面
	@RequestMapping("/reporter/applyManage")
	public String applyManage(HttpServletRequest request, Apply apply) {
		/**
		 * 传入的apply对象主要包括以下字段：
		 * 		history_flag、item_status、item_submit 
		 */
		User user = (User) request.getSession().getAttribute("user");
		if(user != null) {
			if("5".equals(user.getUser_type())) {
				String item_user = user.getReal_name();
				apply.setItem_user(item_user);
			}
		}
		request.setAttribute("apply", apply);
		return "reporter/applyManage";
	}
	
	//显示所有申报项目
	@RequestMapping("/listApply")
	@ResponseBody
	public Map<String, Object> listApply(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "str", required = false) String str,
			@RequestParam(value = "item_user", required = false) String item_user,
			Apply apply) {
		/**
		 * 传入的apply对象主要包括以下字段：
		 * 		history_flag、item_status、item_submit、item_user、item_type、apply_year 
		 */
		//easyui datagrid可以设置默认的page和rows，所以可以直接进行字符串转整数处理
		/*int currentPage = 1;	//默认当前页，即刚进入系统时默认第一页
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int pageSize = 5;	//默认每页显示条数，即刚进入系统时每页显示10条记录
		if(rows != null) {
			pageSize = Integer.parseInt(rows);
		}*/
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = applyService.listApply(apply, str, currentPage, pageSize);
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
	
	//标记为历史记录
	@RequestMapping("/setHistory")
	@ResponseBody
	public JsonResult setHistory() {
		applyService.setHistory();
		return new JsonResult();
	}

}
