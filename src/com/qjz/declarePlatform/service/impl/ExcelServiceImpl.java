package com.qjz.declarePlatform.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.qjz.declarePlatform.dao.ExcelDao;
import com.qjz.declarePlatform.domain.Apply;
import com.qjz.declarePlatform.domain.ItemVO;
import com.qjz.declarePlatform.domain.PageBean;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.ExcelService;
import com.qjz.declarePlatform.util.ExcelBean;
import com.qjz.declarePlatform.util.ExcelUtil;

@Service
public class ExcelServiceImpl implements ExcelService {
	
	@Resource
	private ExcelDao excelDao;

	@Override
	public void importUserExcel(MultipartFile file) {
		List<List<Object>> listob;
		try {
			InputStream in = file.getInputStream();
			listob = ExcelUtil.getBankListByExcel(in,file.getOriginalFilename());
		} catch (Exception e) {
			throw new RuntimeException("excel解析失败!请稍后再试!");
		}
		//遍历listob数据，把数据放到List中  
		for(int i = 0; i < listob.size(); i++){
			List<Object> ob = listob.get(i);
			User user = new User();
			//通过遍历实现把每一列封装成一个model中，再把所有的model用List集合装载  
			user.setUser_name(String.valueOf(ob.get(0)));
			user.setUser_pass(String.valueOf(ob.get(1)));
			user.setReal_name(String.valueOf(ob.get(2)));
			user.setUser_sex(String.valueOf(ob.get(3)));
			user.setUser_department(String.valueOf(ob.get(4)));
			user.setUser_title(String.valueOf(ob.get(5)));
			user.setUser_mailbox(String.valueOf(ob.get(6)));
			user.setUser_telphone(String.valueOf(ob.get(7)));
			//user.setReg_date(String.valueOf(ob.get(7)));
			user.setUser_type(String.valueOf(ob.get(8)));
			user.setSignln_valid(String.valueOf(ob.get(9)));
			user.setUser_remark(String.valueOf(ob.get(10)));
//			//答案选项
//			String []op =String.valueOf(ob.get(7)).split(","); 
//			user.setAnswerOption(JSONArray.toJSONString(op));
//			//正确答案
//			String[] an = String.valueOf(ob.get(8)).split(",");
//			int [] ans = new int[an.length];
//			for(int j = 0;j<an.length;j++){
//				ans[j]=Integer.parseInt(an[j]);
//			}
//			user.setRightanswer(JSONArray.toJSONString(ans));
//			user.setExerhelp(String.valueOf(ob.get(9)));
			int j = excelDao.importUserExcel(user);
			if(j==0){
				throw new RuntimeException("插入失败!");
			}
		}

	}

	@Override
	public XSSFWorkbook exportUserExcel(User user, String str,  int currentPage, int pageSize)
			throws Exception {
		
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到该用户类型下的所有数据
		List<User> list = excelDao.exportUserExcel(user, str, pageBean.getStart(),pageBean.getPageSize());
		//格式化数据
		if(list != null) {
			for (User u : list) {
				//需要判断是否为空，因为switch()中不能为空值
				if(u.getUser_sex() != null) {
					Integer user_sex = Integer.parseInt(u.getUser_sex());
					switch (user_sex) {
					case 1:
						u.setUser_sex("男");
						break;
					case 2:
						u.setUser_sex("女");
						break;
					default:
						u.setUser_sex("");
						break;
					}
				}
				if(u.getUser_type() != null) {
					Integer userType = Integer.parseInt(u.getUser_type());
					switch (userType) {
					case 1:
						u.setUser_type("系统管理员");
						break;
					case 2:
						u.setUser_type("项目管理员");
						break;
					case 3:
						u.setUser_type("系部管理员");
						break;
					case 4:
						u.setUser_type("评审专家");
						break;
					case 5:
						u.setUser_type("项目申报者");
						break;
					default:
						u.setUser_type("");
						break;
					}
				}
				if(u.getSignln_valid() != null) {
					Integer signln_valid = Integer.parseInt(u.getSignln_valid());
					switch (signln_valid) {
					case 1:
						u.setSignln_valid("禁用");
						break;
					case 2:
						u.setSignln_valid("正常");
						break;
					default:
						u.setSignln_valid("");
						break;
					}
				}
			}
		}
//		System.out.println("list:" + list);
		List<ExcelBean> excel=new ArrayList<ExcelBean>();  
	    Map<Integer,List<ExcelBean>> map=new LinkedHashMap<Integer, List<ExcelBean>>();  
	    XSSFWorkbook xssfWorkbook=null;  
	    excel.add(new ExcelBean("用户名","user_name",0));
	    excel.add(new ExcelBean("密码","user_pass",0));
	    excel.add(new ExcelBean("姓名","real_name",0));
	    excel.add(new ExcelBean("性别","user_sex",0));
	    excel.add(new ExcelBean("所属系部","user_department",0));
	    excel.add(new ExcelBean("职称","user_title",0));
	    excel.add(new ExcelBean("电子邮箱","user_mailbox",0));
	    excel.add(new ExcelBean("联系电话","user_telphone",0));
	    excel.add(new ExcelBean("添加时间","reg_date",0));
	    excel.add(new ExcelBean("用户类型","user_type",0));
	    excel.add(new ExcelBean("状态","signln_valid",0));
	    excel.add(new ExcelBean("备注","user_remark",0));
	    map.put(0, excel);
	    //调用ExcelUtil的方法  
	    xssfWorkbook = ExcelUtil.createExcelFile(User.class, list, map,"用户信息");  
	    return xssfWorkbook;
	}

	@Override
	public XSSFWorkbook exportPublicityExcel(String publicity_status,
			Apply apply, User user, String str, int currentPage, int pageSize) throws Exception {
		
		//publicity_status可能为1(未审批)，也可能是"2,3"(已审批，包括成功立项和立项失败)
		String[] status = publicity_status.split(",");
		if(publicity_status == "")
			status = null;
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到该用户类型下的所有数据
		List<ItemVO> list = excelDao.exportPublicityExcel(status, apply, user, str, pageBean.getStart(), pageBean.getPageSize());
		//格式化数据
		if(list != null) {
			for (ItemVO itemVO : list) {
				Integer review2_score = Integer.parseInt(itemVO.getReview2_score());
				if(review2_score >= 90 && review2_score <= 100) {
					itemVO.setReview2_score("A");
				} else if(review2_score >= 80 && review2_score < 90) {
					itemVO.setReview2_score("B");
				} else if(review2_score >= 70 && review2_score < 80) {
					itemVO.setReview2_score("C");
				} else if(review2_score >= 60 && review2_score < 70) {
					itemVO.setReview2_score("D");
				} else if(review2_score >= 0 && review2_score < 60){
					itemVO.setReview2_score("E");
				}
				if(itemVO.getPublicity_status() != null) {
					Integer publicityStatus = Integer.parseInt(itemVO.getPublicity_status());
					switch (publicityStatus) {
					case 1:
						itemVO.setPublicity_status("待审批");
						break;
					case 2:
						itemVO.setPublicity_status("已立项");
						break;
					case 3:
						itemVO.setPublicity_status("不允许立项");
						break;
					default:
						itemVO.setPublicity_status("");
						break;
					}
				}
				if(itemVO.getPublicity_grade() != null) {
					Integer publicity_grade = Integer.parseInt(itemVO.getPublicity_grade());
					switch (publicity_grade) {
					case 1:
						itemVO.setPublicity_grade("重点");
						break;
					case 2:
						itemVO.setPublicity_grade("一般");
						break;
					default:
						itemVO.setPublicity_grade("");
						break;
					}
				}
			}
		}
		List<ExcelBean> excel=new ArrayList<ExcelBean>();  
	    Map<Integer,List<ExcelBean>> map=new LinkedHashMap<Integer, List<ExcelBean>>();  
	    XSSFWorkbook xssfWorkbook=null;  
	    excel.add(new ExcelBean("项目名称","item_name",0));
	    excel.add(new ExcelBean("项目类别","item_type",0));
	    excel.add(new ExcelBean("申报人","item_user",0));
	    excel.add(new ExcelBean("职称","user_title",0));
	    excel.add(new ExcelBean("申报年份","apply_year",0));
	    excel.add(new ExcelBean("起始日期","item_starttime",0));
	    excel.add(new ExcelBean("截止日期","item_deadline",0));
	    excel.add(new ExcelBean("推荐单位","review1_user",0));
	    excel.add(new ExcelBean("评审专家","review2_user",0));
	    excel.add(new ExcelBean("评审得分","review2_score",0));
	    excel.add(new ExcelBean("审批状态","publicity_status",0));
	    excel.add(new ExcelBean("立项等级","publicity_grade",0));
	    excel.add(new ExcelBean("审批时间","publicity_time",0));
	    excel.add(new ExcelBean("备注","publicity_remark",0));
	    map.put(0, excel);
	    //调用ExcelUtil的方法  
	    xssfWorkbook = ExcelUtil.createExcelFile(ItemVO.class, list, map,"用户信息");  
	    return xssfWorkbook;
	}

}
