package com.qjz.declarePlatform.service;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.User;

public interface ExcelService {

	public void importUserExcel(MultipartFile file);

	public XSSFWorkbook exportUserExcel(User user, String str, int currentPage,
			int pageSize) throws Exception;

	public XSSFWorkbook exportPublicityExcel(String publicity_status,
			Apply apply, User user, String str, int currentPage, int pageSize)
			throws Exception;

}
