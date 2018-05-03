package com.qjz.declarePlatform.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qjz.declarePlatform.util.JsonResult;

//全局异常捕获机制
@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	@ResponseBody
	public JsonResult handlerException(Exception e){
		return new JsonResult(e);
	}
	
}
