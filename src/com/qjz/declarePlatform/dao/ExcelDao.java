package com.qjz.declarePlatform.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.ItemVO;
import com.qjz.declarePlatform.domain.User;

public interface ExcelDao {
	
	public List<User> exportUserExcel(@Param("user")User user, @Param("str")String str, @Param("start")int start, @Param("pageSize")int pageSize);

	public int importUserExcel(User user);

	public List<ItemVO> exportPublicityExcel(@Param("status")String[] status, @Param("apply")Apply apply, @Param("user")User user, @Param("str")String str, @Param("start")int start, @Param("pageSize")int pageSize);

}
