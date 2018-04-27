<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理界面</title>
	<%@include file="../head.jspf"%>
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
			//datagrid初始化
			$('#dg').datagrid(
			{
				//请求数据的url
				url : '../../itemType/listItemType.do',
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
				sortName : 'itemType_createTime',
				sortOrder : 'asc',
				remoteSort : false,
				//multiSort : true,
				//指定id为标识字段，在删除，更新的时候有用，如果配置此字段，在翻页时，换页不会影响选中的项
				idField : 'itemType_id',
				striped : true,	//隔行换色
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : '#toolbar',
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
					{field : 'itemType_id',title : '类型编号',align : 'center',width : 100,hidden:true}, 
					{field : 'itemType_name',title : '类型名称',align : 'center', sortable : true, width : 100}, 
					{field : 'item_description',title : '类别描述',align : 'center',width : 100}, 
					{field : 'item_count',title : '该分类下申报的项目数量',align : 'center', sortable : true, width : 50}, 
					{field : 'itemType_createTime',title : '分类创建时间',align : 'center', sortable : true, width : 50, formatter : itemType_createTimeFormatter}, 
					{field : 'option',title : '操作',align : 'center',width : 50,formatter : optionFormatter}, 
				] ],
			});
		});
		
		function addItemType() { //回调函数
			$("#fm").form("reset");
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "添加项目类型");
			//将url设置为添加
			url = "${pageContext.request.contextPath }/itemType/addItemType.do";
		}
		
		function editItemType() {
			//获取选中要修改的行
			var selectedRows = $("#dg").datagrid("getSelections");
			//确保被选中行只能为一行
			if (selectedRows.length != 1) {
				$.messager.alert("系统提示","请选择一条数据进行修改","warning");
				return;
			}
			//获取选中行
			var row = selectedRows[0];
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "修改项目类型");
			//将数组回显对话框中
			$("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
			url = "${pageContext.request.contextPath }/itemType/updateItemType.do";
		}
		
		function removeItemType() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","请选择要删除的分类");
				return;
			}
			var ids = [];
			var counts = [];
			var item_count;
			//循环遍历将选中行的id,item_count push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].itemType_id);
				item_count = selectedRows[i].item_count;
				if(item_count != 0)
					counts.push(item_count);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","您确定要删除选中的<font color=red>" + selectedRows.length + "</font>个类别么？",
			function(flag) {
				if (flag) {
					if(counts.length === 0) {
						$.post("${pageContext.request.contextPath }/itemType/deleteItemTypeBatchs.do",
						{
							idsStr : ids.join(","),
						},
						function(data) {
							if (data) {
								$.messager.alert("系统提示","批量删除分类成功！","info");
								$("#dg").datagrid("unselectAll");
								$("#dg").datagrid("reload");
							} else {
								$.messager.alert("系统提示","批量删除分类失败！","error");
							}
						},"json");
					} else {
						$.messager.alert("系统提示","所选分类下存在申报项目，不允许批量删除，请重新选择！","warning");
					}
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		}
		
		function reload() {
			$("#dg").datagrid("reload");
		}
		
		function searchItemType() {
			var itemType_name = $("#searchBox").val();
			$("#dg").datagrid("load",{
				itemType_name : itemType_name,
			});
		}

		//定义全局url，用于修改和添加操作
		var url;
		// 添加或修改
		function saveDialog() {
			$("#fm").form("submit", {
				url : url,
				onSubmit : function() {
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					var data = JSON.parse(data);	//将json格式的data转换成js对象
					if (data.state) {
						$.messager.alert("系统提示", "保存成功","info");
						$("#fm").form("reset");
						$("#dlg").dialog("close"); //关闭对话框
						$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
						$("#dg").datagrid("reload"); //刷新一下
					} else {
						$.messager.alert("系统提示", "保存失败","error");
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
		
		function itemType_createTimeFormatter(value){
			if(value != null) {
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
	            var hour = date.getHours();
	            if(hour < 10) {
	            	hour = "0" + hour;
	            }
	            var minute = date.getMinutes();
	            if(minute < 10) {
	            	minute = "0" + minute;
	            }
	            var second = date.getSeconds();
	            if(second < 10) {
	            	second = "0" + second;
	            }
	            return year + '-' + month + '-' + day + " " + hour + ":" + minute + ":" + second;
			}
        }
        
		function optionFormatter(value, row, index) {
			return [
	            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png' title='修改'/>修改</a>&nbsp;&nbsp;&nbsp;",  
	            "<a href='javascript:void(0);' onclick='destory(" + row.itemType_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/cancel.png' title='删除'/>删除</a>",
	        ].join("");
		}
		
		 function modify(index){
		 	//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "修改项目类型");
				$("#fm").form("load", row);
				url = "${pageContext.request.contextPath }/itemType/updateItemType.do";
			}
		};
		
		 function destory(itemType_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//提示是否确认删除
			$.messager.confirm("系统提示","您是否要删除项目类型：<font color=red>" + row.itemType_name + "</font>？",
			function(flag) {
				if (flag) {
					if(row.item_count == 0) {
						$.post("${pageContext.request.contextPath }/itemType/deleteItemType.do",
						{
							itemType_id : itemType_id,
						},
						function(data) {
							if (data) {
								$.messager.alert("系统提示","项目类型删除成功！","info");
								$("#dg").datagrid("reload");
							} else {
								$.messager.alert("系统提示","项目类型删除失败！","error");
							}
						},"json");
					} else {
						$.messager.alert("系统提示","该分类下存在申报项目，不允许删除！","warning");
					}
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		};
		
	</script>
	
	<body>
		<div id="toolbar" style="padding:5px;">
			<!-- 工具栏 -->
			<div>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-category_add',plain:true" href="javascript:addItemType();">添加分类</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-category_edit',plain:true" href="javascript:editItemType();">修改分类</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-category_delete',plain:true" href="javascript:removeItemType();">批量删除</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span>按条件查询：</span>&nbsp;&nbsp;
				<input type="text" id="searchBox" name="itemType_name" placeholder="请输入类型名称关键字" size="20" onkeydown="if(event.keyCode==13) searchItemType()"/>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:searchItemType();">查询</a>
			</div>
		</div>
		
		<table id="dg"></table>
		
		<div id="dlg" class="easyui-dialog"
			style="width:350px; height:170px; padding:10px 20px"
			data-options="closed:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="itemType_id" name="itemType_id"/>
				<table cellspacing="8px">
					<tr>
						<td>类型名称</td>
						<td>
							<input type="text" id="itemType_name" name="itemType_name" class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>类别描述</td>
						<td>
							<input type="text" id="item_description" name="item_description" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	
		<div id="dlg-buttons">
			<div align="center">
				<a href="javascript:saveDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:closeDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel',plain:true">关闭</a>
			</div>
		</div>
	</body>
</html>