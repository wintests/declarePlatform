<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
	<%@include file="../head.jspf" %>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/main.js"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'header',split:true,noheader:true," style="height:60px;background:#666;">
		<div class="logo">后台管理</div>
		<div class="timeDiv" id="timeDiv"></div>
		<div class="logout">您好，<font color="#95B8E7">${si.user_name }</font> &nbsp;| &nbsp;<a href="javascript:logout();"><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/logout.png'/>&nbsp;退出用户</a></div>
	</div>   
    <div data-options="region:'south',title:'footer',split:true,noheader:true," style="height:35px;line-height:30px;text-align:center;">&copy;2018  计算机与信息安全学院.</div>   
    <div data-options="region:'west',title:'导航菜单',split:true,iconCls:'icon-world'," style="width:160px;padding:10px;">
    	<div class="easyui-accordion" data-options="fit:false,border:false,animate:true">
    		<div title="个人信息中心" data-options="selected:true,iconCls:'icon-user_control'" style="padding:10px;">
	            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-person'" style="width: 150px;">个人信息</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
	        </div>
    		<div title="申报项目管理" data-options="iconCls:'icon-sys'" style="padding:10px">
	            <a href="javascript:openTab('查看申报指南','${pageContext.request.contextPath }/apply/reporter/guide.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">查看申报指南</a>
	            <a href="javascript:openTab('申报项目列表','${pageContext.request.contextPath }/apply/reporter/add.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">申报项目列表</a>
	            <a href="javascript:openTab('分配评审专家','${pageContext.request.contextPath }/publicity/itemManager/assignExpert.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">分配评审专家</a>
	            <a href="javascript:openTab('评审结果查询','${pageContext.request.contextPath }/review2/expert/review2Manage.do?review2_status=2','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">评审结果查询</a>
	        </div>
	        <div title="项目立项管理" data-options="iconCls:'icon-item'" style="padding:10px;">
	            <a href="javascript:openTab('待立项的项目','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?publicity_status=1','icon-type')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-type'" style="width: 150px;">待立项的项目</a>
	            <a href="javascript:openTab('立项结果查询','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?publicity_status=2&publicity_status=3','icon-type')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-find'" style="width: 150px;">立项结果查询</a>
	            <a href="javascript:openTab('历史立项查询','${pageContext.request.contextPath }/apply/reporter/applyManage.do?item_status=5','icon-type')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-find'" style="width: 150px;">历史立项查询</a>
	        </div>
	    </div>
    </div>   
    <div data-options="region:'center'," style="overflow:hidden;">
    	<div class="easyui-tabs" data-options="fit:'true',border:'false','id':'tabs'" id="tabs">
	        <div title="首页" data-options="iconCls:'icon-home'">
	            <div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
	        </div>
	    </div>
    </div>
    <div id="dlg" class="easyui-dialog" style="width:400px; height:200px; padding:10px 20px" 
		data-options="closed:true,buttons:'#dlg-buttons'">
		<form id="fm" method="post">
			<input type="hidden" name="user_name" value="${si.user_name }"/>
			<table cellspacing="8px">
				<tr>
					<td>用户名</td>
					<td>
						<%-- <input type="text" id="user_name" name="user_name" value="${si.user_name }" readonly="readonly"> --%>
						<span>${si.user_name }</span>
					</td>
				</tr>
				<tr>
					<td>新密码</td>
					<td>
						<input type="password" id="user_pass" name="user_pass" class="easyui-validatebox" 
							 required="true" style="width:200px">
					</td>
				</tr>
				<tr>
					<td>确认新密码</td>
					<td>
						<input type="password" id="user_pass2" name="user_pass2" class="easyui-validatebox" 
							required="true" style="width:200px">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<div align="center">
			<a href="javascript:modifyPassword()" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
			<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">关闭</a>
		</div>
	</div>
    
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/currentTime.js"></script>
    
</body>
</html>