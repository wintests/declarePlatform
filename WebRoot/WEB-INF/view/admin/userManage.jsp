<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理界面</title>
<%@include file="../head.jspf"%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/userManage.js"></script> --%>
</head>
<script type="text/javascript">
	$(function() {
		//datagrid初始化
		$('#dg').datagrid({
			//请求数据的url
			url : '../../user/findUserByType.do?user_type=' + '${user_type}',
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
			pageSize : 5,
			//每页显示记录数项目
			pageList : [ 5, 10, 15, 20 ],
			//指定id为标识字段，在删除，更新的时候有用，如果配置此字段，在翻页时，换页不会影响选中的项
			idField : 'user_name',
			//上方工具条 添加 修改 删除 刷新按钮
			toolbar : [ {
				iconCls : 'icon-add', //图标
				text : '添加', //名称
				handler : function() { //回调函数
					//alert("添加");
					$("#fm").form("reset");
					//打开对话框并且设置标题
					$("#dlg").dialog("open").dialog("setTitle","添加用户");
					//将url设置为添加
					url = "${pageContext.request.contextPath }/user/addUser.do";
				}
			}, '-', {
				iconCls : 'icon-edit',
				text : '修改',
				handler : function() {
					//alert("修改");
					//获取选中要修改的行
					var selectedRows = $("#dg").datagrid("getSelections");
					//console.log(selectedRows)
					//确保被选中行只能为一行
					if(selectedRows.length != 1) {
						$.messager.alert("系统提示", "请选择一个要修改的用户");
            			return;
					}
					//获取选中行user_name
			        var row = selectedRows[0];
			        //打开对话框并且设置标题
			        $("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
			        //将数组回显对话框中
			        $("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
			        url = "${pageContext.request.contextPath }/user/updateUser.do";
				}
			}, '-', {
				iconCls : 'icon-remove',
				text : '删除',
				handler : function() {
					//alert("删除");
					var selectedRows = $("#dg").datagrid("getSelections");
					console.log(selectedRows);
			        //判断是否有选择的行
			        if(selectedRows.length == 0) {
			            $.messager.alert("系统提示", "请选择要删除的数据");
			            return;
			        }
			        //定义选中 选中user_name数组
			        var ids = [];
			        //循环遍历将选中行的id push进入数组
			        for(var i = 0; i < selectedRows.length; i++) {
			            ids.push(selectedRows[i].user_name);
			        }
			        //console.log(ids)
			        //提示是否确认删除
			        $.messager.confirm("系统提示", "您确定要删除选中的<font color=red>"+selectedRows.length+"</font>条数据么？", function(flag) {
			            if(flag) {
			                $.post(
			                "${pageContext.request.contextPath }/user/deleteUserByName.do",
			                    {
			                    	user_name: ids.join(","),
			                    }, 
			                    function(data){
			                    	console.log(data)
			                        if(data) {
			                            $.messager.alert("系统提示", "数据删除成功！");
			                            $("#dg").datagrid("reload");
			                        } else {
			                            $.messager.alert("系统提示", "数据删除失败！");
			                        }
			                    }, "json");
			            }
			        });
				}
			}, '-', {
				iconCls : 'icon-reload',
				text : '刷新',
				handler : function() {
					//alert("刷新");
					$("#dg").datagrid("reload");
				}
			} ],
			//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, //复选框
			] ],
			columns : [ [ {
				field : 'user_name',
				title : '用户名',
				width : 100
			}, {
				field : 'user_pass',
				title : '密码',
				width : 100
			}, {
				field : 'real_name',
				title : '姓名',
				width : 100
			}, {
				field : 'user_sex',
				title : '性别',
				width : 100
			}, {
				field : 'user_department',
				title : '所属系部',
				width : 100
			}, {
				field : 'user_title',
				title : '职称',
				width : 100
			}, {
				field : 'user_mailbox',
				title : '电子邮箱',
				width : 100
			}, {
				field : 'user_telphone',
				title : '联系电话',
				width : 100
			}, {
				field : 'reg_date',
				title : '添加时间',
				width : 100
			}, {
				field : 'user_type',
				title : '用户类型',
				width : 100
			}, {
				field : 'user_remark',
				title : '备注',
				width : 100
			}, ] ],
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
				//alert(data)
				var data = eval("(" + data + ")"); //将json格式的result转换成js对象
				//alert(data.state)
				if (data.state) {
					$.messager.alert("系统提示", "保存成功");
					$("user_name").val(""); //保存成功后将内容置空
					$("user_pass").val("");
					$("#dlg").dialog("close"); //关闭对话框
					$("#dg").datagrid("reload"); //刷新一下
				} else {
					$.messager.alert("系统提示", "保存失败");
					return;
				}
			}
		});
	}
	
	function closeUserDialog() {
        $("user_name").val(""); //保存成功后将内容置空
        $("user_pass").val("");
        $("#dlg").dialog("close"); //关闭对话框
    }

</script>
<body>
	<table id="dg"></table>
	<div id="dlg" class="easyui-dialog"
		style="width:500px; height:180px; padding:10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="POST">
			<table cellspacing="8px">
				<tr>
					<td>用户名</td>
					<td><input type="text" id="user_name" name="user_name"
						class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td>密码</td>
					<td><input type="text" id="user_pass" name="user_pass"
						class="easyui-numberbox" required="true" >&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="dlg-buttons">
		<div>
			<a href="javascript:saveUser()" class="easyui-linkbutton"
				iconCls="icon-ok" plain="true">保存</a> <a
				href="javascript:closeUserDialog()" class="easyui-linkbutton"
				iconCls="icon-cancel" plain="true">关闭</a>
		</div>
	</div>
</body>
</html>