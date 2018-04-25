<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
	<%@include file="../head.jspf" %>
	<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/default/easyui.css"> --%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main1.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/main1.js"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'header',split:true,noheader:true," style="height:60px;background:#666;">
		<div class="logo">后台管理</div>
		<div class="timeDiv" id="timeDiv"></div>
		<div class="logout">您好，<font color="#95B8E7">${si.user_name }</font> | <a href="javascript:logout();">退出用户</a></div>
	</div>   
    <div data-options="region:'south',title:'footer',split:true,noheader:true," style="height:35px;line-height:30px;text-align:center;">&copy;2018  Powered by JAVA and EasyUI.</div>   
    <div data-options="region:'west',title:'导航菜单',split:true,iconCls:'icon-world'," style="width:160px;padding:10px;">
    	<!-- <ul id="nav"></ul> -->
    	<div class="easyui-accordion" data-options="fit:false,border:false,animate:true">
    		<div title="个人信息中心" data-options="selected:true,iconCls:'icon-user'" style="padding:10px;">
	            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-person'" style="width: 150px;">个人信息</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
	        </div>
    		<div title="用户信息管理" data-options="iconCls:'icon-manager'" style="padding:10px">
	            <a href="javascript:openTab('全部用户列表','${pageContext.request.contextPath }/user/admin/userManage.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">全部用户列表</a>
	            <a href="javascript:openTab('申报人员列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=5','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">申报人员列表</a>
	            <a href="javascript:openTab('系部管理员列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=3','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">系部管理员列表</a>
	            <a href="javascript:openTab('评审专家列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=4','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">评审专家列表</a>
	            <a href="javascript:openTab('项目管理员列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=2','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">项目管理员列表</a>
	        </div>
	        <div title="申报控制开关" data-options="iconCls:'icon-control'" style="padding: 10px">
	            <a href="javascript:openTab('申报控制管理','${pageContext.request.contextPath }/configSwitch.do','icon-switch')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-switch'" style="width: 150px">申报控制管理</a>
	        </div>
	        <div title="项目信息管理" data-options="iconCls:'icon-item'" style="padding:10px;">
	            <a href="javascript:openTab('项目类别管理','${pageContext.request.contextPath }/user/admin/itemType.do','icon-type')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-type'" style="width: 150px;">项目类型管理</a>
	               <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-find'" style="width: 150px;">当前申报查询</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-history'" style="width: 150px;">历史申报查询</a>
	        </div>
	        <div title="申报流程管理" data-options="iconCls:'icon-itemprocess'" style="padding:10px">
	        	<a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">已申报项目列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">待审核推荐列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">待专家评审列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">待终审立项列表</a>
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">已公示立项列表</a>
	        </div>
	        <div title="系统设置管理" data-options="iconCls:'icon-sys'" style="padding:10px">
	            <a href="#" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-link'" style="width: 150px">更改皮肤</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
	            <a href="javascript:logout();" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'"
	               style="width: 150px;">安全退出</a>
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
    
    <script type="text/javascript">
    	function calender() {
			var time = new Date();
			var year = time.getFullYear();
			var month = toPair(time.getMonth() + 1);
			var day = toPair(time.getDate());
			var hour = toPair(time.getHours());
			var minute = toPair(time.getMinutes());
			var second = toPair(time.getSeconds());
			var dateweek;
		
			switch (time.getDay()) {
			case 0:
				dateweek = "星期日";
				break;
			case 1:
				dateweek = "星期一";
				break;
			case 2:
				dateweek = "星期二";
				break;
			case 3:
				dateweek = "星期三";
				break;
			case 4:
				dateweek = "星期四";
				break;
			case 5:
				dateweek = "星期五";
				break;
			case 6:
				dateweek = "星期六";
				break;
			}
		
			var timeDiv = document.getElementById('timeDiv');
			timeDiv.innerHTML = "今天是：" + year + "年" + month + "月" + day + "日　" + hour
					+ ":" + minute + ":" + second + "　" + dateweek;
			var mytime = setTimeout("calender()", 1000);
		}

		calender();
		
		function toPair(str) {
			if (Number(str) < 10) {
				return "0" + str;
			} else {
				return str;
			}
		}
    </script>
    
</body>
</html>