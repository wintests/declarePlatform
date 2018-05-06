package com.qjz.declarePlatform.other;

import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qjz.declarePlatform.domain.Signln;
import com.qjz.declarePlatform.domain.User;
import com.qjz.declarePlatform.service.UserService;

@Controller
@RequestMapping(value = "/report")
public class ReportFormController{
	
	@Resource
	private UserService userService;

	@RequestMapping("/export")
    private void export(HttpServletResponse response,
    		//page第几页，rows每页多少行，user_type用户类型
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "user_type", required = false) String user_type,
			@RequestParam(value = "str", required = false) String str,
			@RequestParam(value = "user_department", required = false) String user_department,
			@RequestParam(value = "user_title", required = false) String user_title,
			@RequestParam(value = "signln_valid", required = false) String signln_valid) throws Exception {
		
		User user = new User();
		user.setUser_department(user_department);
		user.setUser_title(user_title);
		user.setSignln_valid(signln_valid);
		System.out.println("user:" + user);
		if(user_type == null) {
			user_type = "";
		}
		int currentPage = 1;	//默认当前页，即刚进入系统时默认第一页
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int pageSize = 20;	//默认每页显示条数，即刚进入系统时每页显示10条记录
		if(rows != null) {
			pageSize = Integer.parseInt(rows);
		}
		Map<String, Object> map = userService.findUserByType(str, user, currentPage, pageSize);
		System.out.println("total:" + map.get("total"));
		List list = (List) map.get("rows");
		
        String filename= new String("用户表.xls".getBytes(),"iso-8859-1");//中文文件名必须使用此句话

        response.setContentType("application/octet-stream");
        response.setContentType("application/OCTET-STREAM;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+filename );

        String[] headers = { "编号","用户名", "密码", "姓名","性别","所属系部", "职称", "电子邮箱","联系电话","添加时间", "用户类型", "状态","备注"};  //表格的标题栏

//        Map<String,Object> map = new HashMap<String, Object>();;  //组合查询条件，返回数据
//        map.put("group", group);
//        map.put("department", department);
//        map.put("type", type);
        //List<Signln> list = userService.userList();
        System.out.println("状态1:" + list);
        //WorkloadExport 为将要导出的类，也就是表格的一行记录，里面的所有字段都不能为空，必须生成set get方法
        //导出列顺序和类中成员顺序一致
        try {
            ExportExcel<Signln> ex = new ExportExcel<Signln>();  //构造导出类
            OutputStream out = new BufferedOutputStream(response.getOutputStream());
            System.out.println("状态2:" + list);

            //String title = list.get(0).getUser_name();  //title需要自己指定 比如写Sheet

            ex.exportExcel("账号信息",headers, list, out);  //title是excel表中底部显示的表格名，如Sheet
            System.out.println("状态3:" + list);
            out.close();
            System.out.println("状态4:" + list);
            //JOptionPane.showMessageDialog(null, "导出成功!");
            //System.out.println("excel导出成功！");
        } catch (FileNotFoundException e) {
        	System.out.println("状态5:" + list);
            e.printStackTrace();
        } catch (IOException e) {
        	System.out.println("状态6:" + list);
            e.printStackTrace();
        }
    }
	
}