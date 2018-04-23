package com.qjz.declarePlatfrom.domain;

import java.io.Serializable;
import java.util.Date;

public class ItemType implements Serializable {

	/**
	 * 项目类别信息
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer itemType_id;// 类型编号
	private String itemType_name;// 类型名称
	private Date itemType_createTime;// 该类别的创建时间
	private String item_description;// 该类别的描述
	private Integer item_count;// 该类别下的项目数量

	public Integer getItemType_id() {
		return itemType_id;
	}

	public void setItemType_id(Integer itemType_id) {
		this.itemType_id = itemType_id;
	}

	public String getItemType_name() {
		return itemType_name;
	}

	public void setItemType_name(String itemType_name) {
		this.itemType_name = itemType_name;
	}

	public Date getItemType_createTime() {
		return itemType_createTime;
	}

	public void setItemType_createTime(Date itemType_createTime) {
		this.itemType_createTime = itemType_createTime;
	}

	public String getItem_description() {
		return item_description;
	}

	public void setItem_description(String item_description) {
		this.item_description = item_description;
	}

	public Integer getItem_count() {
		return item_count;
	}

	public void setItem_count(Integer item_count) {
		this.item_count = item_count;
	}

	@Override
	public String toString() {
		return "ItemType [itemType_id=" + itemType_id + ", itemType_name="
				+ itemType_name + ", itemType_createTime="
				+ itemType_createTime + ", item_description="
				+ item_description + ", item_count=" + item_count + "]";
	}

}
