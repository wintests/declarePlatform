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
		#tt {
		  border-width: 0 0 1px;
		}
		
		/* #aa1.selected {
			background: #FBEC88;
		} */
		
		#div *{
			display:block;
			width:200px;
			text-align: center;
		}
		#div button{
			background-color : #FFE0C0;
		}
	</style>
	<script type="text/javascript">
		function change(node) {
			/* return '<font color="#B16D44" size="2">'+node.text+'</font>'; */
			return node.text;
		}
		$(document).ready(function(){
			//1 分组(span)可以点击，控制下面的列表项的显示或隐藏
			//2 当前分组的列表项显示时，其他分组隐藏(只有一个是显示状态)
			//3 所有的分组列表项默认都是隐藏的
			/* $("#aa").click(function() {
		  		$("#aa1").css("background-color","#ff0");
	  		}); */
	  		
			$("#aa").children("a").hide().parent().prev("a").click(function(){
				//$("#aa1").css("background-color","#FBEC88");
				//$("#aa1").toggleClass('selected');
				$(this).nextAll("div").children("a").toggle().parent().siblings("#aa").find("a").hide();
			});
			
		});
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'header',split:true,noheader:true," style="height:60px;background:#666;">
		<div class="logo">后台管理</div>
		<div class="timeDiv" id="timeDiv"></div>
		<div class="logout">您好，<font color="#95B8E7">${si.user_name }</font> &nbsp;| &nbsp;<a href="javascript:logout();"><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/logout.png'/>&nbsp;退出用户</a></div>
	</div>   
    <div data-options="region:'south',title:'footer',split:true,noheader:true," style="height:35px;line-height:30px;text-align:center;">&copy;2018  计算机与信息安全学院.</div>   
    <div data-options="region:'west',title:'导航菜单',split:true,iconCls:'icon-world'," style="width:180px;padding:10px;">
    	<div class="easyui-accordion" data-options="fit:false,border:false,animate:true">
    		<div title="个人信息中心" data-options="selected:true,iconCls:'icon-user_control'" style="padding:10px;">
	            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-person'" style="width: 150px;">个人信息</a>
	            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
	        </div>
	        <div title="系部人员管理" data-options="iconCls:'icon-item'" style="padding:10px;">
	            <a href="javascript:openTab('本系用户列表','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=5','icon-type')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-type'" style="width: 150px;">本系用户列表</a>
	        </div>
    		<div title="系部审核管理" data-options="iconCls:'icon-sys'" style="padding:10px">
	            <a href="javascript:openTab('本系当前申报','${pageContext.request.contextPath }/review1/department/review1Manage.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">本系当前申报</a>
	            <a href="javascript:openTab('待审核的项目','${pageContext.request.contextPath }/review1/department/review1Manage.do?review1_status=1','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">待审核的项目</a>
	            <a href="javascript:openTab('已审核的项目','${pageContext.request.contextPath }/review1/department/review1Manage.do?review1_status=2&review1_status=3','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">已审核的项目</a>
	            <a href="javascript:openTab('历史审核查询','${pageContext.request.contextPath }/review1/department/history.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">历史审核查询</a>
	        </div>
	        <div title="XXXX管理" class="easyui-accordion" data-options="fit:false,border:false,animate:true,iconCls:'icon-item'" style="padding:10px;">
	            <a href="javascript:openTab('审核','${pageContext.request.contextPath }/review1/department/review1Manage.do','icon-list')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">审核</a>
	            <!-- <ul id="tt" class="easyui-tree" data-options="animate:true, url : 'tree.json', formatter: change" style="padding:5px;">
				</ul> -->
				<ul class="easyui-tree" data-options="lines:true">
					<li>
						<span>系统管理</span>
						<ul>
							<li>
								<span>主机信息</span>
								<ul>
									<li><a href="javascript:openTab('审核','${pageContext.request.contextPath }/review1/department/review1Manage.do','icon-list')" class="easyui-linkbutton"
	               							data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">审核</a></li>
									<li>数据库信息</li>
								</ul>
							</li>
							<li>
								<a href="javascript:openTab('审核','${pageContext.request.contextPath }/review1/department/review1Manage.do','icon-list')" class="easyui-linkbutton"
	               					data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">审核</a>
							</li>
							<li>
								<span>会员管理</span>
								<ul>
									<li>新增会员</li>
									<li>审核会员</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<ul class="easyui-tree">
					<li>
						<span>系统管理</span>
						<ul>
							<li>
								<span>主机信息</span>
								<ul>
									<li><a href="javascript:openTab('审核','${pageContext.request.contextPath }/review1/department/review1Manage.do','icon-list')" class="easyui-linkbutton"
	               							data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">审核</a></li>
									<li>数据库信息</li>
								</ul>
							</li>
							<li>
								<a href="javascript:openTab('审核','${pageContext.request.contextPath }/review1/department/review1Manage.do','icon-list')" class="easyui-linkbutton"
	               					data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">审核</a>
							</li>
							<li>
								<span>会员管理</span>
								<ul>
									<li>新增会员</li>
									<li>审核会员</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
	        </div>
	        <div title="系部审核管理" data-options="iconCls:'icon-sys'" style="padding:10px">
	        	<a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
	            <div style="padding:5px 10px 5px 0px">
				    <a id="aa1" class="easyui-linkbutton" data-options="plain:true" style="background-color:transparent;">
				    	<img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/manager.png'/>&nbsp;本次申报项目</a>
	            	<div id="aa" style="padding:0px 0px 0px 17px">
			            <a href="javascript:openTab('待审核的项目','${pageContext.request.contextPath }/review1/department/review1Manage.do?review1_status=1','icon-list')" class="easyui-linkbutton"
			               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">待审核的项目</a>
			           <a href="javascript:openTab('已审核的项目','${pageContext.request.contextPath }/review1/department/review1Manage.do?review1_status=2&review1_status=3','icon-list')" class="easyui-linkbutton"
			               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">已审核的项目</a>
			            <a href="javascript:openTab('历史审核查询','${pageContext.request.contextPath }/review1/department/history.do','icon-list')" class="easyui-linkbutton"
			               data-options="plain:true,iconCls:'icon-list'" style="width: 150px;">历史审核查询</a>
	            	</div>
	            </div>
	            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')" class="easyui-linkbutton"
	               data-options="plain:true,iconCls:'icon-person'" style="width: 150px;">个人信息</a>
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