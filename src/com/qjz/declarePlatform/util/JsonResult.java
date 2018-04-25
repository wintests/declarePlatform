package com.qjz.declarePlatform.util;

/**
 * json结果统一格式化
 */
public class JsonResult {
	
	public static final int SUCCESS=1;
    public static final int ERROR=0;
	/**服务端的响应状态*/
	private int state;
	/**信息(给用户的提示)*/
	private String message;
	/**具体业务数据*/
	private Object data;
	
	public JsonResult() {
		this.state=SUCCESS;
		this.message="ok";
	}
	public JsonResult(Object data) {
		this();			//调用自己的无参构造方法
		this.data=data;
	}

	public JsonResult(Throwable e){
		this.state=ERROR;
		this.message=e.getMessage();
	}
	
	public String getMessage() {
		return message;
	}
	public Object getData() {
		return data;
	}
	public int getState() {
		return state;
	}
	
}
