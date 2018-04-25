package com.qjz.declarePlatform.domain;


public class PageBean {

	private int start; // 起始记录
	private int currentPage; // 当前页
	private int pageSize; // 每页显示条数
	private long total; // 总记录数
//	private List<T> list; // 分页查询的结果

	public PageBean() {
		super();
	}

	public PageBean(int currentPage, int pageSize) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.start = (currentPage - 1) * pageSize;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	@Override
	public String toString() {
		return "PageBean [start=" + start + ", currentPage=" + currentPage
				+ ", pageSize=" + pageSize + ", total=" + total + "]";
	}

}
