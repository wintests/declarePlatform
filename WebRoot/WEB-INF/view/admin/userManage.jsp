<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理界面</title>
	<%@include file="../head.jspf"%>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/userManage.js"></script> --%>
	<style type="text/css">
		a{text-decoration:none;}
	</style>
</head>
	<script type="text/javascript">
		$(function() {
			//datagrid初始化
			$('#dg').datagrid(
			{
				//请求数据的url
				url : '../../user/findUserByType.do?user_type='
						+ '${user_type}',
				title : '当前列表',
				rownumbers : true,
				height : 805,
				//singleSelect : true,
				//载入提示信息
				loadMsg : 'loading...',
				//水平自动展开，如果设置此属性，则不会有水平滚动条，演示冻结列时，该参数不要设置
				fitColumns : true,
				//数据多的时候不换行
				nowrap : true,
				//设置分页
				pagination : true,
				//设置每页显示的记录数，默认是10个
				pageSize : 15,
				//每页显示记录数项目
				pageList : [ 3, 5, 10, 15, 20 ],
				//指定id为标识字段，在删除，更新的时候有用，如果配置此字段，在翻页时，换页不会影响选中的项
				idField : 'user_name',
				striped : true,	//隔行换色
				/* rowStyler:function(index,row){
		 	        if (index%2 == 0){
		 	            return 'background-color:#EAF2FF;';
		 	        } else {
		                return 'background-color:#F3F3F3;';
		 	        }
		 	    }, */
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : [
				{
					iconCls : 'icon-add', //图标
					text : '添加', //名称
					handler : function() { //回调函数
						document.getElementById("user_name").disabled = false;
						$("#fm").form("reset");
						//打开对话框并且设置标题
						$("#dlg").dialog("open").dialog("setTitle", "添加用户");
						//将url设置为添加
						url = "${pageContext.request.contextPath }/user/addUser.do";
					}
				},
				'-',
				{
					iconCls : 'icon-edit',
					text : '修改',
					handler : function() {
						//获取选中要修改的行
						var selectedRows = $("#dg").datagrid("getSelections");
						//console.log(selectedRows)
						//确保被选中行只能为一行
						if (selectedRows.length != 1) {
							$.messager.alert("系统提示","请选择一个要修改的用户");
							return;
						}
						//获取选中行user_name
						var row = selectedRows[0];
						console.log(row);
						//打开对话框并且设置标题
						//$("input[type='text']:first").prop('disabled','disabled');
						$("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
						//将数组回显对话框中
						$("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
						document.getElementById("user_name").disabled = true;
						url = "${pageContext.request.contextPath }/user/updateUser.do";
					}
				},
				'-',
				{
					iconCls : 'icon-remove',
					text : '删除',
					handler : function() {
						var selectedRows = $("#dg").datagrid("getSelections");
						//console.log(selectedRows);
						//判断是否有选择的行
						if (selectedRows.length == 0) {
							$.messager.alert("系统提示","请选择要删除的数据");
							return;
						}
						//定义选中 选中user_name数组
						var ids = [];
						//循环遍历将选中行的id push进入数组
						for ( var i = 0; i < selectedRows.length; i++) {
							ids.push(selectedRows[i].user_id);
						}
						//console.log(ids)
						//提示是否确认删除
						$.messager.confirm("系统提示","您确定要删除选中的<font color=red>" + selectedRows.length + "</font>条数据么？",
						function(flag) {
							if (flag) {
								$.post("${pageContext.request.contextPath }/user/deleteUserBatchs.do",
								{
									idsStr : ids.join(","),
								},
								function(data) {
									//console.log(data);
									if (data) {
										$.messager.alert("系统提示","数据删除成功！");
										$("#dg").datagrid("reload");
									} else {
										$.messager.alert("系统提示","数据删除失败！");
									}
								},"json");
							} else {
								$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
							}
						});
					}
				}, '-', {
					iconCls : 'icon-reload',
					text : '刷新',
					handler : function() {
						$("#dg").datagrid("reload");
					}
				} ],
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				columns : [ [ 
					{field : 'user_id',title : 'id编号',align : 'center',width : 100,hidden:true}, 
					{field : 'user_name',title : '用户名',align : 'center',width : 100}, 
					{field : 'user_pass',title : '密码',align : 'center',width : 100},
					{field : 'real_name',title : '姓名',align : 'center',width : 100}, 
					{field : 'user_sex',title : '性别',align : 'center',width : 100,formatter : user_sexFormatter}, 
					{field : 'user_department',title : '所属系部',align : 'center',width : 100}, 
					{field : 'user_title',title : '职称',align : 'center',width : 100}, 
					{field : 'user_mailbox',title : '电子邮箱',align : 'center',width : 100}, 
					{field : 'user_telphone',title : '联系电话',align : 'center',width : 100}, 
					{field : 'reg_date',title : '添加时间',align : 'center',width : 100}, 
					{field : 'user_type',title : '用户类型',align : 'center',width : 100,formatter : user_typeFormatter}, 
					{field : 'signln_valid',title : '状态',align : 'center',width : 100,formatter : signln_validFormatter}, 
					{field : 'user_remark',title : '备注',align : 'center',width : 100}, 
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
	
		//定义全局url，用于修改和添加操作
		var url;
		// 添加或者修改用户
		function saveUser() {
			$("#fm").form("submit", {
				url : url,
				onSubmit : function() {
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					//var data = eval("(" + data + ")"); //将json格式的data转换成js对象
					var data = JSON.parse(data);
					if (data.state) {
						$.messager.alert("系统提示", "保存成功");
						$("#fm").form("reset");
						$("#dlg").dialog("close"); //关闭对话框
						$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
						$("#dg").datagrid("reload"); //刷新一下
					} else {
						$.messager.alert("系统提示", "保存失败");
						return;
					}
				}
			});
		}
	
		function closeUserDialog() {
			$("#fm").form("reset");
			$("#dlg").dialog("close"); //关闭对话框
			$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
		}
		
		function user_sexFormatter(value,row,index) {
			if(value == 1) {
				return "男";
			} else {
				return "女";
			}
		}
		
		function user_typeFormatter(value,row,index) {
			if(value == 2) {
				return "项目管理员";
			} else if(value == 3) {
				return "系部管理员";
			} else if(value == 4){
				return "评审专家";
			} else if(value == 5){
				return "项目申报者";
			} else {
				return "系统管理员";
			}
		}
		
		function signln_validFormatter(value,row,index) {
			if(value == 1) {
				return "<a href='#'><font color='red'>禁用</font></a>";
			} else {
				return "<a href='#'><font color='green'>正常</font></a>";
			}
		}
		
		function optionFormatter(value, row, index) {
			return [
	            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.5/themes/icons/pencil.png' title='修改'/>修改</a>&nbsp;&nbsp;&nbsp;",  
	            "<a href='javascript:void(0);' onclick='destory(" + row.user_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.5/themes/icons/cancel.png' title='删除'/>删除</a>",
	        ].join("");
		}
		
		 function modify(index){
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//console.log(row);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
				$("#fm").form("load", row);
				document.getElementById("user_name").disabled = true;
				url = "${pageContext.request.contextPath }/user/updateUser.do";
			}
		};
		
		 function destory(user_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//提示是否确认删除
			$.messager.confirm("系统提示","您是否确定要删除用户：<font color=red>" + row.user_name + "</font>？",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/user/deleteUserById.do",
					{
						user_id : user_id,
					},
					function(data) {
						if (data) {
							$.messager.alert("系统提示","删除成功！");
							$("#dg").datagrid("reload");
						} else {
							$.messager.alert("系统提示","删除失败！");
						}
					},"json");
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		};
		
	</script>
	<body>
		<table id="dg"></table>
		<div id="dlg" class="easyui-dialog"
			style="width:500px; height:480px; padding:10px 20px"
			data-options="closed:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="user_id" name="user_id"/>
				<input type="hidden" name="user_name"/>
				<table cellspacing="8px">
					<tr>
						<td>用户名</td>
						<td>
							<input type="text" id="user_name" name="user_name" class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>密码</td>
						<td>
							<input type="text" id="user_pass" name="user_pass" class="easyui-numberbox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>姓名</td>
						<td>
							<input type="text" id="real_name" name="real_name" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>性别</td>
						<td>
							<input type="radio" name="user_sex" value="1" checked="checked" />男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="user_sex" value="2" />女
						</td>
					</tr>
					<tr>
						<td>所属系部</td>
						<td>
							<select id="user_department" name="user_department" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="计算机系">计算机系</option>
								<option value="软件工程系">软件工程系</option>
								<option value="信息安全系">信息安全系</option>
								<option value="网络工程系">网络工程系</option>
							</select> &nbsp;
						</td>
					</tr>
					<tr>
						<td>职称</td>
						<td>
							<select id="user_title" name="user_title" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="教授">教授</option>
								<option value="副教授">副教授</option>
								<option value="研究员">研究员</option>
								<option value="副研究员">副研究员</option>
								<option value="讲师">讲师</option>
								<option value="助教">助教</option>
							</select> &nbsp;
					</td>
					</tr>
					<tr>
						<td>电子邮箱</td>
						<td>
							<input type="text" id="user_mailbox" name="user_mailbox">&nbsp;
						</td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td>
							<input type="text" id="user_telphone" name="user_telphone">&nbsp;
						</td>
					</tr>
					<tr>
						<td>添加时间</td>
						<td>
							<input type="text" id="reg_date" name="reg_date" class="easyui-datebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>用户类型</td>
						<td>
							<select id="user_type" name="user_type" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="2">项目管理员</option>
								<option value="3">系部管理员</option>
								<option value="4">评审专家</option>
								<option value="5">项目申报者</option>
							</select> &nbsp;
						</td>
					</tr>
					<tr>
						<td>状态</td>
						<td>
							<input type="radio" name="signln_valid" value="1" checked="checked" />禁用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="signln_valid" value="2" />正常
						</td>
					</tr>
					<tr>
						<td>备注</td>
						<td>
							<input type="text" id="user_remark" name="user_remark" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	
		<div id="dlg-buttons">
			<div align="center">
				<a href="javascript:saveUser()" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:closeUserDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel',plain:true">关闭</a>
			</div>
		</div>
	</body>
</html>