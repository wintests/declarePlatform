<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>申报控制开关管理</title>
	<%@include file="../head.jspf"%>
	<style type="text/css">
		a{
			text-decoration:none;
		}
		
		.datagrid-header-row td{
			font-weight:bold;
			height : 25px;
		}
		
		.datagrid-btable tr{
			height:35px; /*修改行高*/
		},
	</style>
</head>
	<script type="text/javascript">
		$(function() {
			//datagrid初始化
			$('#dg').datagrid(
			{
				//请求数据的url
				url : './configShow.do',
				title : '申报开关管理',
				height : 800,
				//载入提示信息
				loadMsg : 'loading...',
				//水平自动展开，如果设置此属性，则不会有水平滚动条，演示冻结列时，该参数不要设置
				fitColumns : true,
				//数据多的时候不换行
				nowrap : true,
				idField : 'config_id',
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : '#toolbar',
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				onLoadSuccess: function (data) {
		            if (data.total == 0) {
		            	$.messager.alert("提示框","<font size='2'>不存在申报控制开关管理！</font>", "info");
		            }
		        },
				columns : [ [ 
					{field : 'config_id',title : 'id编号',align : 'center',width : 100, height : 40, hidden:true}, 
					{field : 'config_flag',title : '系统当前状态',align : 'center',width : 100, height : 40, formatter : config_flagFormatter}, 
					{field : 'option',title : '操作',align : 'center',width : 100, height : 40, formatter : optionFormatter}, 
				] ],
			});
		});
		
		function config_flagFormatter(value, row ,index) {
			if(value == 1) {
				return "<font color='green'><b>可申报阶段</b></font>";
			} else if(value == 2) {
				return "<font color='green'><b>系部审核阶段</b></font>";
			} else if(value == 3) {
				return "<font color='green'><b>专家评审阶段</b></font>";
			} else if(value == 4) {
				return "<font color='green'><b>项目立项阶段</b></font>";
			} else {
				return "<font color='red'><b>系统关闭，已结束本次项目申报工作！</b></font>";
			}
		}
		
		function optionFormatter(value, row, index) {
			return [
	            "<a href='javascript:void(0);' onclick='change(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/guide_edit.png'/>编辑状态</a>&nbsp;&nbsp;&nbsp;",  
	        ];
		}
		
		
		function change(index){
			//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			//$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
				$("#fm").form("load", row);
				url = "${pageContext.request.contextPath }/updateConfig.do";
			}
		};
		
		//定义全局url，用于编辑操作
		var url;
		//保存编辑状态
		function save() {
			$("#fm").form("submit", {
				url : url,
				onSubmit : function() {
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					//将json格式的data转换成js对象
					var data = JSON.parse(data);
					if (data.state) {
						//console.log(data.state);
						$.messager.alert("系统提示", "<font size='2'>恭喜您，更新状态成功！</font>", "info");
						$("#fm").form("reset");
						$("#dlg").dialog("close"); //关闭对话框
						$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
						$("#dg").datagrid("reload"); //刷新一下
					} else {
						$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
						return;
					}
				}
			});
		}
		
		function closeDialog() {
			$("#fm").form("reset");
			$("#dlg").dialog("close"); //关闭对话框
			$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
		}
		
	</script>
	<body>
		
		<table id="dg"></table>
		
		<div id="dlg" class="easyui-dialog" style="width:350px; height:150px; padding:10px 20px" data-options="iconCls:'icon-save',closed:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id=config_id name="config_id"/>
				<table cellspacing="8px">
					<tr>
						<td>修改当前状态</td>
						<td>
							<select id="config_flag" name="config_flag" class="easyui-combobox" style="width:120px;">
								<option value="1">可申报阶段</option>
								<option value="2">系部审核阶段</option>
								<option value="3">专家评审阶段</option>
								<option value="4">项目立项阶段</option>
								<option value="5">结束本次工作</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
		</div>
	
		<div id="dlg-buttons">
			<div align="center">
				<a href="javascript:save()" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:closeDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel',plain:true">关闭</a>
			</div>
		</div>
	</body>
</html>