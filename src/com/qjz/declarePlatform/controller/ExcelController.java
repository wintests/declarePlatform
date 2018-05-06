package com.qjz.declarePlatform.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.ExcelService;
import com.qjz.declarePlatform.util.JsonResult;

@Controller
@RequestMapping("/resource")
public class ExcelController {

	@Resource
	private ExcelService excelService;

	@RequestMapping(value = "/userExcelImport", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult userExcelImport(HttpServletRequest request) {
//		System.out.println("测试1");
		MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
//		System.out.println("测试2");
		MultipartFile file = multipart.getFile("file");
//		System.out.println("测试3");
//		System.out.println("文件：" + file);
		excelService.importUserExcel(file);
		return new JsonResult();
	}

	@RequestMapping("/userExcelExport")
	@ResponseBody
	public JsonResult userExcelExport(HttpServletResponse response,
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "str", required = false) String str,
			User user) throws Exception {

		response.reset(); // 清除buffer缓存
		// 指定下载的文件名
		Date date = new Date(System.currentTimeMillis());
//		System.out.println("date" + date);
		// 将时间格式化
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date);
//		System.out.println("today:" + today);
		String filename = new String(("用户表-" + today + ".xlsx").getBytes(),"iso-8859-1");// 中文文件名必须使用此句话
		response.setHeader("Content-Disposition", "attachment;filename=" + filename);
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		XSSFWorkbook workbook = null;
		// 导出Excel对象
		int currentPage = 1;	//默认当前页，即刚进入系统时默认第一页
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int pageSize = 15;	//默认每页显示条数，即刚进入系统时每页显示15条记录
		if(rows != null) {
			pageSize = Integer.parseInt(rows);
		}
		workbook = excelService.exportUserExcel(user, str, currentPage, pageSize);
		OutputStream output;
		try {
			output = response.getOutputStream();
			BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
			bufferedOutPut.flush();
			workbook.write(bufferedOutPut);
			bufferedOutPut.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new JsonResult();
	}
	
	@RequestMapping("/publicityExcelExport")
	@ResponseBody
	public JsonResult publicityExcelExport(HttpServletResponse response,
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "publicity_status", required = false) String publicity_status,
			@RequestParam(value = "str", required = false) String str,
			Apply apply, User user) throws Exception {

		response.reset(); // 清除buffer缓存
		// 指定下载的文件名
		Date date = new Date(System.currentTimeMillis());
		// 将时间格式化
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date);
		String filename = new String(("审批结果表-" + today + ".xls").getBytes(),"iso-8859-1");// 中文文件名必须使用此句话
		response.setHeader("Content-Disposition", "attachment;filename=" + filename);
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		XSSFWorkbook workbook = null;
		// 导出Excel对象
		int currentPage = 1;	//默认当前页，即刚进入系统时默认第一页
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int pageSize = 15;	//默认每页显示条数，即刚进入系统时每页显示15条记录
		if(rows != null) {
			pageSize = Integer.parseInt(rows);
		}
		workbook = excelService.exportPublicityExcel(publicity_status, apply, user, str, currentPage, pageSize);
		OutputStream output;
		try {
			output = response.getOutputStream();
			BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
			bufferedOutPut.flush();
			workbook.write(bufferedOutPut);
			bufferedOutPut.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new JsonResult();
	}

}
