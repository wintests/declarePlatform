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
	<style type="text/css">
		a:hover{
			text-decoration:underline;
			font-weight:bold;
			font-size: 14px;
			color: #E96129;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			//1 分组可以点击，控制下面的列表项的显示或隐藏
			//2 当前分组的列表项显示时，其他分组隐藏(只有一个是显示状态)
			//3 所有的分组列表项默认都是隐藏的
			$("#aa").children("a").hide().parent().prev("a").click(function(){
				//$("#aa1").css("background-color","#FBEC88");
				$(this).nextAll("div").children("a").toggle().parent().siblings("#aa").find("a").hide();
			});
			
		});
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'header',split:true,noheader:true," style="height:60px;background:#2D3E50;">
		<div class="logo">后台管理</div>
		<div class="timeDiv" id="timeDiv"></div>
		<div class="logout">您好，<font color="#95B8E7">${user.user_name }</font><font color="yellow">${user.real_name }</font> &nbsp;| &nbsp;<a href="javascript:logout();"><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/logout.png'/>&nbsp;退出用户</a></div>
	</div>   
    <div data-options="region:'south',title:'footer',split:true,noheader:true," style="height:40px;line-height:30px;text-align:center;background:#2D3E50;"><font color="#fff">Copyright&nbsp;&copy;2018  计算机与信息安全学院</font></div>   
    <div data-options="region:'west',title:'导航菜单',split:true,iconCls:'icon-world'," style="width:175px;padding:0px;">
    	<div class="easyui-accordion" data-options="fit:false,border:false,animate:true">
    		<div title="个人信息中心" data-options="selected:true,iconCls:'icon-user_control'" style="padding:10px;">
	            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-person'" style="width: 125px;padding:2px 8px 2px 5px;">个人信息</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 125px;padding:2px 8px 2px 5px;">修改密码</a>
	        </div>
    		<div title="申报评审管理" data-options="iconCls:'icon-report_manage'" style="padding:10px">
	            <a href="javascript:openTab('修改申报指南','${pageContext.request.contextPath }/apply/reporter/guide.do','icon-guide_edit')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-guide_edit'" style="width: 125px;padding:2px 8px 2px 5px;">修改申报指南</a>
	           <%--  <a href="javascript:openTab('本次申报列表','${pageContext.request.contextPath }/apply/reporter/add.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 125px;padding:2px 8px 2px 5px;">本次申报列表</a> --%>
	            <div>
				    <a id="aa1" class="easyui-linkbutton" 
				    	data-options="plain:true,iconCls:'icon-list'" style="width: 125px;padding:2px 8px 2px 5px;">系部推荐名单</a>
	            	<div id="aa" style="padding:0px 0px 0px 17px">
			            <a href="javascript:openTab('分配评审专家','${pageContext.request.contextPath }/publicity/itemManager/assignExpert.do','icon-assign_result')" class="easyui-linkbutton"
			               data-options="plain:true,iconCls:'icon-assign_result'" style="width: 125px;padding:2px 8px 2px 5px;">分配评审专家</a>
			            <a href="javascript:openTab('查看分配情况','${pageContext.request.contextPath }/publicity/itemManager/assignResult.do','icon-link')" class="easyui-linkbutton"
			               data-options="plain:true,iconCls:'icon-link'" style="width: 125px;padding:2px 8px 2px 5px;">查看分配情况</a>
	            	</div>
	            </div>   
	            <a href="javascript:openTab('本次评审结果','${pageContext.request.contextPath }/review2/expert/review2Manage.do?review2_status=2&history_flag=1','icon-user_list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-user_list'" style="width: 125px;padding:2px 8px 2px 5px;">本次评审结果</a>
	            <a href="javascript:openTab('历史评审查询','${pageContext.request.contextPath }/review2/expert/review2Manage.do?review2_status=2&history_flag=2','icon-history')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-history'" style="width: 125px;padding:2px 8px 2px 5px;">历史评审查询</a>
	        </div>
	        <div title="当前审批管理" data-options="iconCls:'icon-manager'" style="padding:10px;">
	            <a href="javascript:openTab('待审批的项目','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?publicity_status=1&history_flag=1','icon-review1_wait')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-review1_wait'" style="width: 125px;padding:2px 8px 2px 5px;">待审批的项目</a>
	            <a href="javascript:openTab('本次审批结果','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?publicity_status=2&publicity_status=3&history_flag=1','icon-find')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-find'" style="width: 125px;padding:2px 8px 2px 5px;">本次审批结果</a>
	        </div>
	        <div title="历史审批查询" data-options="iconCls:'icon-item_history'" style="padding:10px;">
	            <a href="javascript:openTab('历史审批列表','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?history_flag=2','icon-list_all')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_all'" style="width: 125px;padding:2px 8px 2px 5px;">历史审批列表</a>
	            <a href="javascript:openTab('成功立项记录','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?publicity_status=2&history_flag=2','icon-list_success')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_success'" style="width: 125px;padding:2px 8px 2px 5px;">成功立项记录</a>
	            <a href="javascript:openTab('立项失败记录','${pageContext.request.contextPath }/publicity/itemManager/publicityManage.do?publicity_status=3&history_flag=2','icon-list_failure')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list_failure'" style="width: 125px;padding:2px 8px 2px 5px;">立项失败记录</a>
	        </div>
	        <div title="申报控制开关" data-options="iconCls:'icon-item_control'" style="padding: 10px">
	            <a href="javascript:openTab('申报流程控制','${pageContext.request.contextPath }/configSwitch.do','icon-switch')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">申报流程控制</a>
	        </div>
	        <div title="项目申报统计" data-options="iconCls:'icon-pie-chart'" style="padding:10px;">
	            <a href="javascript:openTab('项目申报统计','${pageContext.request.contextPath }/review1/department/review1Manage.do?history_flag=2','icon-large_chart')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-large_chart'" style="width: 125px;padding:2px 8px 2px 5px;">项目申报统计</a>
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