package com.qjz.declarePlatform.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.domain.ItemType;
import com.qjz.declarePlatform.service.ItemTypeService;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/itemType")
public class ItemTypeController {
	
	@Resource
	private ItemTypeService itemTypeService;
	
	//显示所有分类
	@RequestMapping("/listItemType")
	@ResponseBody
	public Map<String, Object> listItemType(
			//page第几页，rows每页多少行，itemType_name类型名称
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "itemType_name", required = false) String itemType_name) {
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = itemTypeService.listItemType(itemType_name, currentPage, pageSize);
		return map;
	}
	
	//更新已有分类基本信息
	@RequestMapping("/updateItemType")
	@ResponseBody
	public JsonResult updateItemType(ItemType itemType) {
		itemTypeService.updateItemType(itemType);
		return new JsonResult();
	}
	
	//新增分类
	@RequestMapping("/addItemType")
	@ResponseBody
	public JsonResult addItemType(ItemType itemType) {
		itemTypeService.addItemType(itemType);
		return new JsonResult();
	}
	
	//删除分类
	@RequestMapping("/deleteItemType")
	@ResponseBody
	public JsonResult deleteItemType(Integer itemType_id) {
		itemTypeService.deleteItemType(itemType_id);
		return new JsonResult();
	}
	
	//批量删除分类
	@RequestMapping("/deleteItemTypeBatchs")
	@ResponseBody
	public JsonResult deleteItemTypeBatchs(String idsStr) {
		itemTypeService.deleteItemTypeBatchs(idsStr);
		return new JsonResult();
	}

}
