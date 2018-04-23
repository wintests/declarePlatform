<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理界面</title>
	<%@include file="../head.jspf"%>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/userManage.js"></script> --%>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/Combobox.js"></script> --%>
	<style type="text/css">
		a{
			text-decoration:none;
		}
		
		#searchBox{
		    background: #fff8f8;
		    font-size: 12px;
		    width: 180px;
		}
		
	</style>
</head>
	<script type="text/javascript">
		$(function() {
		
			//扩展 dateBox
			$.extend(  
			    $.fn.datagrid.defaults.editors, {  
			        datebox: {  
			            init: function (container, options) {  
			                var input = $('<input type="text">').appendTo(container);  
			                input.datebox(options);
			                return input;  
			            },  
			            destroy: function (target) {  
			                $(target).datebox('destroy');  
			            },  
			            getValue: function (target) {  
			                return $(target).datebox('getValue');  
			            },  
			            setValue: function (target, value) {  
			                $(target).datebox('setValue', formatDatebox(value));  
			            },  
			            resize: function (target, width) {  
			                $(target).datebox('resize', width);  
			            }  
			        }
			    });
		
			//datagrid初始化
			$('#dg').datagrid(
			{
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
				toolbar : '#toolbar',
				/* [
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
				} ], */
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				onLoadSuccess: function (data) {
		            if (data.total == 0) {
		            	$.messager.alert("提示框","未查询到相关数据！", "info");
		            }
		        },
				
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
					{field : 'reg_date',title : '添加时间',align : 'center',width : 100, formatter : reg_dateFormatter, parser : reg_dateParser, editor : "datebox"}, 
					{field : 'user_type',title : '用户类型',align : 'center',width : 100,formatter : user_typeFormatter}, 
					{field : 'signln_valid',title : '状态',align : 'center',width : 100,formatter : signln_validFormatter}, 
					{field : 'user_remark',title : '备注',align : 'center',width : 100}, 
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
		
		function addUser() { //回调函数
			document.getElementById("user_name").disabled = false;
			$("#fm").form("reset");
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "添加用户");
			//将url设置为添加
			url = "${pageContext.request.contextPath }/user/addUser.do";
		}
		
		function editUser() {
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
			row.reg_date = reg_dateFormatter(row.reg_date);
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
			//将数组回显对话框中
			$("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
			document.getElementById("user_name").disabled = true;
			url = "${pageContext.request.contextPath }/user/updateUser.do";
		}
		
		function removeUser() {
			var selectedRows = $("#dg").datagrid("getSelections");
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
			//提示是否确认删除
			$.messager.confirm("系统提示","您确定要删除选中的<font color=red>" + selectedRows.length + "</font>条数据么？",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/user/deleteUserBatchs.do",
					{
						idsStr : ids.join(","),
					},
					function(data) {
						if (data) {
							$.messager.alert("系统提示","数据删除成功！");
							$("#dg").datagrid("unselectAll");
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
		
		function enabledBatchs() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","请选择需要启用的用户");
				return;
			}
			//定义选中 选中user_name数组
			var ids = [];
			//循环遍历将选中行的id push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].user_id);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","您确定要批量启用选中的<font color=red>" + selectedRows.length + "</font>个用户么？",
			function(flag) {
				var signln_valid = "2";
				changeStatusBatchs(flag, ids, signln_valid);
			});
		}
		
		function disabledBatchs() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","请选择需要禁用的用户");
				return;
			}
			//定义选中 选中user_name数组
			var ids = [];
			//循环遍历将选中行的id push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].user_id);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","您确定要批量禁用选中的<font color=red>" + selectedRows.length + "</font>个用户么？",
			function(flag) {
				var signln_valid = "1";
				changeStatusBatchs(flag, ids, signln_valid);
			});
		}
		
		function changeStatusBatchs(r, ids, signln_valid) {
			if (r) {
				$.post("${pageContext.request.contextPath }/user/changeUserStatusBatchs.do",
				{
					idsStr : ids.join(","),
					signln_valid : signln_valid
				},
				function(data) {
					if (data) {
						$.messager.alert("系统提示","更改状态成功！");
						$("#dg").datagrid("unselectAll");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示","更改状态失败！");
					}
				},"json");
			} else {
				$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
			}
		}
		
		function reload() {
			$("#dg").datagrid("reload");
		}
		
		function searchUser() {
			var str = $("#searchBox").val();
			var user_department = $("#department").combobox("getValue");
			var user_title = $("#title").combobox("getValue");
			var signln_valid = $("#valid").combobox("getValue");
    		
			$("#dg").datagrid("load",{
				str : str,
				user_department : user_department,
				user_title : user_title,
				signln_valid : signln_valid
			});
		}

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
		
		function reg_dateFormatter(value){
            var date = new Date(value);
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            if(month < 10) {
            	month =  "0" + month;
            }
            var day = date.getDate();
            if(day < 10) {
            	day =  "0" + day;
            }
            return year + '-' + month + '-' + day;
        }
        
        function reg_dateParser(s) {
        	if (!s) return new Date();  
            var ss = (s.split('-'));  
            var y = parseInt(ss[0],10);  
            var m = parseInt(ss[1],10);  
            var d = parseInt(ss[2],10);  
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
                return new Date(y,m-1,d);  
            } else {  
                return new Date();  
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
				return "<a href='javascript:void(0);' onclick='changeValid("+index+")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/mini_edit.png'/><font color='red'>禁用</font></a>";
			} else if(value == 2){
				return "<a href='javascript:void(0);' onclick='changeValid("+index+")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/mini_edit.png'/><font color='green'>正常</font></a>";
			} else {
				return "";
			}
		}
		
		function optionFormatter(value, row, index) {
			return [
	            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png' title='修改'/>修改</a>&nbsp;&nbsp;&nbsp;",  
	            "<a href='javascript:void(0);' onclick='destory(" + row.user_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/cancel.png' title='删除'/>删除</a>",
	        ].join("");
		}
		
		function changeValid(index) {
			//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			if(row.signln_valid == "1") {
				$.messager.confirm("更改用户状态", "是否启用用户：<font color=red>" + row.user_name + "</font>？", function(r){
					var signln_valid = "2";
					changeStatus(r, row.user_id, signln_valid);
				});
			} else {
				$.messager.confirm("更改用户状态", "是否禁用用户：<font color=red>" + row.user_name + "</font>？", function(r){
					var signln_valid = "1";
					changeStatus(r, row.user_id, signln_valid);
				});
			}
		}
		
		function changeStatus(r, user_id, signln_valid) {
			if (r) {
				$.post("${pageContext.request.contextPath }/user/changeUserStatus.do",
				{
					user_id : user_id,
					signln_valid : signln_valid
				},
				function(data) {
					if (data) {
						$.messager.alert("系统提示","更改状态成功！");
						$("#dg").datagrid("unselectAll");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示","更改状态失败！");
					}
				},"json");
			} else {
				$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
			}
		}
		
		 function modify(index){
		 	//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//将时间格式化，因为当前数据的实际格式为JSON序列化的形式，而并非"yyyy-MM-dd"，只有格式化之后，数据才能够正确回填到form表格
			row.reg_date = reg_dateFormatter(row.reg_date);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
				$("#fm").form("load", row);
				/* $("#fm").form("load", {
					user_id : row.user_id,
					user_name : row.user_name,
					user_pass : row.user_pass,
					real_name : row.real_name,
					user_sex : row.user_sex,
					user_department : row.user_department,
					user_title : row.user_title,
					user_mailbox : row.user_mailbox,
					user_department : row.user_department,
					user_telphone : row.user_telphone,
					reg_date : reg_dateFormatter(row.reg_date),
					user_type : row.user_type,
					user_remark : row.user_remark,
					signln_valid : row.signln_valid
				}); */
				document.getElementById("user_name").disabled = true;
				url = "${pageContext.request.contextPath }/user/updateUser.do";
			}
		};
		
		 function destory(user_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//row.reg_date = reg_dateFormatter(row.reg_date);
			console.log(row);
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
		
		/* function loadType() {
			//alert(1);
			$.ajax({
			    type: "POST",
			    url: '../../itemType/list.do',
			    dataType: "json",
			    success: function(data) {
			        $('#itemType_name').combobox({
			            data: data.data,
			            valueField: 'itemType_id',
			            textField: 'itemType_name',
			            onSelect : function(record) {
							alert("选择一个时触发");
							console.log(record);
						},
			        });
			    }
			});
		} */
		
	</script>
	<body>
		<div id="toolbar" style="padding:5px;">
			<!-- 工具栏 -->
			<div>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" href="javascript:addUser();">添加</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" href="javascript:editUser();">修改</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" href="javascript:removeUser();">批量删除</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-enabled',plain:true" href="javascript:enabledBatchs();">批量启用</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-disabled',plain:true" href="javascript:disabledBatchs();">批量禁用</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span>按条件查询：</span>&nbsp;&nbsp;
				<select id="department" name="user_department" class="easyui-combobox" style="width:150px;">
					<option value="">-----请选择所属系部-----</option>
					<option value="计算机系">计算机系</option>
					<option value="软件工程系">软件工程系</option>
					<option value="信息安全系">信息安全系</option>
					<option value="网络工程系">网络工程系</option>
				</select>
				<select id="title" name="user_title" class="easyui-combobox" style="width:150px;">
					<option value="">-----请选择教师职称-----</option>
					<option value="教授">教授</option>
					<option value="副教授">副教授</option>
					<option value="研究员">研究员</option>
					<option value="副研究员">副研究员</option>
					<option value="讲师">讲师</option>
					<option value="助教">助教</option>
				</select>
				<select id="valid" name="signln_valid" class="easyui-combobox" style="width:150px;">
					<option value="">-----请选择用户状态-----</option>
					<option value="2">正常</option>
					<option value="1">禁用</option>
				</select>
				<input type="text" id="searchBox" name="str" placeholder="按用户名或真实姓名查找" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:searchUser();">查询</a>
			</div>
		</div>
		
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
								<option value="1">系统管理员</option>
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