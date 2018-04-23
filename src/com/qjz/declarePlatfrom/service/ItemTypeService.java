package com.qjz.declarePlatfrom.service;

import java.util.Map;

import com.qjz.declarePlatfrom.domain.ItemType;

public interface ItemTypeService {
	
	public Map<String, Object> listItemType(String itemType_name, int currentPage, int pageSize);

	public void updateItemType(ItemType itemType);

	public void addItemType(ItemType itemType);

	public void deleteItemType(Integer itemType_id);

}
