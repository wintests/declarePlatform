<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
	<%@include file="../head.jspf" %>
	<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/default/easyui.css"> --%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/main.js"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'header',split:true,noheader:true," style="height:60px;background:#2D3E50;">
		<div class="logo">后台管理</div>
		<div class="timeDiv" id="timeDiv"></div>
		<div class="logout">您好，<font color="#95B8E7">${user.user_name }</font><font color="yellow">${user.real_name }</font> &nbsp;| &nbsp;<a href="javascript:logout();"><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/logout.png'/>&nbsp;退出用户</a></div>
	</div>   
    <div data-options="region:'south',title:'footer',split:true,noheader:true," style="height:40px;line-height:30px;text-align:center;background:#2D3E50;"><font color="#fff">Copyright&nbsp;&copy;2018  计算机与信息安全学院</font></div>   
    <div data-options="region:'west',title:'导航菜单',split:true,iconCls:'icon-world'," style="width:175px;padding:0px;">
    	<!-- <ul id="nav"></ul> -->
    	<div class="easyui-accordion" data-options="fit:false,border:false,animate:true">
    		<div title="个人信息中心" data-options="selected:true,iconCls:'icon-user_control'" style="padding:10px;">
	            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-person'" style="width: 125px;padding:2px 8px 2px 5px;">个人信息</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 125px;padding:2px 8px 2px 5px;">修改密码</a>
	        </div>
    		<div title="用户信息管理" data-options="iconCls:'icon-user_manager'" style="padding:10px">
	            <a href="javascript:openTab('全部用户列表','${pageContext.request.contextPath }/user/admin/userManage.do','icon-list_all')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_all'" style="width: 125px;padding:2px 8px 2px 5px;">全部用户列表</a>
	            <a href="javascript:openTab('申报人员列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=5','icon-user_list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list'" style="width: 125px;padding:2px 8px 2px 5px;">申报人员列表</a>
	            <a href="javascript:openTab('系部管理员列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=3','icon-list_success')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_success'" style="width: 125px;padding:2px 8px 2px 5px;">系部管理员列表</a>
	            <a href="javascript:openTab('评审专家列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=4','icon-list_failure')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_failure'" style="width: 125px;padding:2px 8px 2px 5px;">评审专家列表</a>
	            <a href="javascript:openTab('项目管理员列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=2','icon-user_list3')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list3'" style="width: 125px;padding:2px 8px 2px 5px;">项目管理员列表</a>
	        </div>
	        <div title="申报控制开关" data-options="iconCls:'icon-item_control'" style="padding: 10px">
	            <a href="javascript:openTab('申报控制管理','${pageContext.request.contextPath }/configSwitch.do','icon-switch')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">申报控制管理</a>
	        </div>
	        <div title="项目信息管理" data-options="iconCls:'icon-item'" style="padding:10px;">
	            <a href="javascript:openTab('项目类别管理','${pageContext.request.contextPath }/user/admin/itemType.do','icon-type')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-type'" style="width: 125px;padding:2px 8px 2px 5px;">项目类型管理</a>
	               <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-find'" style="width: 125px;padding:2px 8px 2px 5px;">当前申报查询</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-history'" style="width: 125px;padding:2px 8px 2px 5px;">历史申报查询</a>
	        </div>
	        <div title="申报流程管理" data-options="iconCls:'icon-itemprocess'" style="padding:10px">
	        	<a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_all'" style="width: 125px;padding:2px 8px 2px 5px;">已申报项目列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list1'" style="width: 125px;padding:2px 8px 2px 5px;">待审核推荐列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list2'" style="width: 125px;padding:2px 8px 2px 5px;">待专家评审列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list4'" style="width: 125px;padding:2px 8px 2px 5px;">待终审立项列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list3'" style="width: 125px;padding:2px 8px 2px 5px;">已公示立项列表</a>
	        </div>
	        <div title="系统设置管理" data-options="iconCls:'icon-sys'" style="padding:10px">
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-link'" style="width: 125px;padding:2px 8px 2px 5px;">更改皮肤</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 125px;padding:2px 8px 2px 5px;">修改密码</a>
	            <a href="javascript:logout();" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'"
	               style="width: 125px;padding:2px 8px 2px 5px;">安全退出</a>
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
		data-options="iconCls:'icon-modifyPassword',closed:true,buttons:'#dlg-buttons'">
		<form id="fm" method="post">
			<input type="hidden" name="user_name" value="${user.user_name }"/>
			<table cellspacing="8px">
				<tr>
					<td>用户名</td>
					<td>
						<%-- <input type="text" id="user_name" name="user_name" value="${user.user_name }" readonly="readonly"> --%>
						<span>${user.user_name }</span>
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