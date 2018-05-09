package com.qjz.declarePlatform.domain;

import java.io.Serializable;

public class ResourceModel implements Serializable{

	/**
	 * 模板资源表
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer resourceModel_id;
	private String resourceModel_name;
	private String resourceModel_path;

	public Integer getResourceModel_id() {
		return resourceModel_id;
	}

	public void setResourceModel_id(Integer resourceModel_id) {
		this.resourceModel_id = resourceModel_id;
	}

	public String getResourceModel_name() {
		return resourceModel_name;
	}

	public void setResourceModel_name(String resourceModel_name) {
		this.resourceModel_name = resourceModel_name;
	}

	public String getResourceModel_path() {
		return resourceModel_path;
	}

	public void setResourceModel_path(String resourceModel_path) {
		this.resourceModel_path = resourceModel_path;
	}

	@Override
	public String toString() {
		return "ResourceModel [resourceModel_id=" + resourceModel_id
				+ ", resourceModel_name=" + resourceModel_name
				+ ", resourceModel_path=" + resourceModel_path + "]";
	}

}
