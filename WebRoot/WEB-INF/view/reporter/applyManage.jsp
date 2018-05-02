<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户申报管理</title>
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
		
		.datagrid-header-row td{
			background-color:#E0ECFF;
			font-weight:bold;
			height : 25px;
		}
		
		.datagrid-btable tr{
			height: 28px;
		}
	</style>
	
</head>
	<script type="text/javascript">
		$(function() {
			//datagrid初始化
			$('#dg').datagrid(
			{
				//请求数据的url
				url : '../../apply/listApply.do?item_submit=' + '${apply.item_submit}' + '&item_status=' + '${apply.item_status}' + '&item_user=' + '${apply.item_user}' + '&history_flag=' + '${apply.history_flag}',
				title : '当前列表',
				rownumbers : true,
				height : 800,
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
				idField : 'item_id',
				striped : true,	//隔行换色
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : '#toolbar',
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				onLoadSuccess: function (data) {
		            if (data.total != 0) {
		            	var array1 = [];
		            	var array2 = [];
		            	for(var i = 0 ; i < data.rows.length; i++) {
		            	//console.log(data.row[i].apply_time);
		            		if(data.rows[i].apply_time != null) {
		            			//console.log(typeof data.rows[i].history_flag);
		            			array1.push(data.rows[i].apply_time);
		            			if(data.rows[i].history_flag === "2") {
		            				array2.push(data.rows[i].history_flag);
		            			}
		            		}
		            	}
	            		if(array1.length == 0) {
	            			$("#dg").datagrid("hideColumn", "apply_time");
	            			$("#dg").datagrid("hideColumn", "item_status");
	            			$("#dg").datagrid("hideColumn", "item_starttime");
	            			$("#dg").datagrid("hideColumn", "item_deadline");
	            		} else {
	            			//$("#dg").datagrid("hideColumn", "item_submit");
	            			if(array2.length != 0) {
	            				$("#dg").datagrid("hideColumn", "option");
	            				$("#addApply").hide();
	            			}
	            		}
		            } else {
		            	$.messager.alert("提示框","未查询到相关数据！", "info");
		            }
		        },
				columns : [ [ 
					{field : 'item_id',title : '项目编号',align : 'center',width : 100, hidden : true}, 
					{field : 'item_name',title : '项目名称',align : 'center',width : 100}, 
					{field : 'item_type',title : '项目类别',align : 'center',width : 100},
					{field : 'item_user',title : '项目申报人',align : 'center',width : 100},
					{field : 'user_title',title : '申报人职称',align : 'center',width : 100},
					{field : 'apply_year',title : '申报年份',align : 'center',width : 100},
					{field : 'user_department',title : '所属系部',align : 'center',width : 100},
					{field : 'item_starttime',title : '项目起始日期',align : 'center',width : 100, formatter : dateFormatter}, 
					{field : 'item_deadline',title : '项目截止日期',align : 'center',width : 100, formatter : dateFormatter}, 
					{field : 'item_submit',title : '提交状态',align : 'center',width : 100, formatter : item_submitFormatter}, 
					{field : 'apply_time',title : '提交时间',align : 'center',width : 100, formatter : datetimeFormatter}, 
					{field : 'item_status',title : '当前状态',align : 'center',width : 100, formatter : item_statusFormatter}, 
					{field : 'item_description',title : '项目描述',align : 'center',width : 100}, 
					{field : 'history_flag',title : '时间标志',align : 'center',width : 100, hidden : true}, 
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
		
		function addApply() { //回调函数
			//document.getElementById("user_name").disabled = false;
			$("#fm").form("reset");
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "新增申报项目书");
			//将url设置为添加
			url = "${pageContext.request.contextPath }/apply/addApply.do";
		}
		
		function editApply() {
			//获取选中要修改的行
			var selectedRows = $("#dg").datagrid("getSelections");
			//确保被选中行只能为一行
			if (selectedRows.length != 1) {
				if(selectedRows.length  == 0) {
					$.messager.alert("系统提示","请选择一条记录进行修改！","info");
				} else {
					$.messager.alert("系统提示","一次只能选择一条记录！","warning");
				}
				return;
			}
			//获取选中行
			var row = selectedRows[0];
			console.log(row)
			row.item_starttime = dateFormatter(row.item_starttime);
			row.item_deadline = dateFormatter(row.item_deadline);
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "编辑项目申报书");
			//将数组回显对话框中
			$("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
			//document.getElementById("user_name").disabled = true;
			url = "${pageContext.request.contextPath }/apply/updateApply.do";
		}
		
		function removeApply() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","请您至少选择一条要删除的数据！","info");
				return;
			}
			//定义选中 选中item_id数组
			var ids = [];
			//循环遍历将选中行的id push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].item_id);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","您确定要删除选中的<font color=red>" + selectedRows.length + "</font>条数据么？",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/apply/deleteApplyBatchs.do",
					{
						idsStr : ids.join(","),		//将ids数组中的所有元素转换一个字符串，传到后台
					},
					function(data) {
						if (data.state) {
							$.messager.alert("系统提示","恭喜您，批量删除成功！","info");
							$("#dg").datagrid("unselectAll");
							$("#dg").datagrid("reload");
						} else {
							$.messager.alert("系统提示","批量删除失败，请重新操作！","error");
						}
					},"json");
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		}
		
		function submitBatchs() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","请至少选择一项需要提交的项目申报书！","info");
				return;
			}
			//定义选中 选中item_id数组
			var ids = [];
			//循环遍历将选中行的id push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].item_id);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","您确定要提交选中的<font color=red>" + selectedRows.length + "</font>个申报项目么？",
			function(flag) {
				var item_submit = "2";
				changeStatusBatchs(flag, ids, item_submit);
			});
		}
		
		function changeStatusBatchs(r, ids, item_submit) {
			if (r) {
				$.post("${pageContext.request.contextPath }/apply/submitApplyBatchs.do",
				{
					idsStr : ids.join(","),
					item_submit : item_submit
				},
				function(data) {
					//console.log(data.data);
					if (data.state) {
						$.messager.alert("系统提示","恭喜您，批量提交成功！","info");
						$("#dg").datagrid("unselectAll");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示","批量提交失败，请重新操作！","error");
					}
				},"json");
			} else {
				$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
			}
		}
		
		function reload() {
			$("#dg").datagrid("reload");
		}
		
		function print() {
			alert("print");
		}
		
		function page_excel() {
			alert("page_excel");
		}
		
		function help() {
			alert("help");
		}
		
		function search() {
			var str = $("#searchBox").val();
			var apply_year = $("#year").combobox("getValue");
			var item_type = $("#type").combobox("getValue");
			
			if(item_type === "-----请选择项目类别-----") {
				item_type = "";
			}
    		
			$("#dg").datagrid("load",{
				str : str,
				apply_year : apply_year,
				item_type : item_type,
			});
		}
		
		function clear() {
			//$("#year").combobox("clear");
			//$("#type").combobox("clear");
			$("#year").combobox("setValue", "");
			$("#type").combobox("setValue", "-----请选择项目类别-----");
			$("#searchBox").val("");
		}

		//定义全局url，用于修改和添加操作
		var url;
		// 添加或者修改用户
		function saveDialog() {
			$("#fm").form("submit", {
				url : url,
				onSubmit : function() {
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					var data = JSON.parse(data);
					console.log(data);
					console.log(data.message);
					console.log(data.state);
					console.log(data.data);
					if (data.state) {
						$.messager.alert("系统提示", "恭喜您，数据保存成功！", "info");
						$("#fm").form("reset");
						$("#dlg").dialog("close"); //关闭对话框
						$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
						$("#dg").datagrid("reload"); //刷新一下
					} else {
						$.messager.alert("系统提示", "数据保存失败，请重新操作！", "error");
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
		
		function item_submitFormatter(value,row,index) {
			if(value == 1) {
				return "<a href='javascript:void(0);' onclick='changeSubmit("+index+")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/mini_edit.png'/><font color='red'>未提交</font></a>";
			} else if(value == 2){
				return "<font color='green'>已提交</font>";
			} else {
				return "";
			}
		}
		
		function dateFormatter(value){
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
	            return year + '-' + month + '-' + day;
			}
        }
        
        function datetimeFormatter(value){
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
        
		function item_statusFormatter(value,row,index) {
			if(value === "1") {
				return "<font color='purple'>等待系部审核⋯⋯</font>";
			} else if(value === "2" || value ==="3") {
				return "<font color='#2D3E50'>等待专家评审⋯⋯</font>";
			} else if(value === "4"){
				return "<font color='blue'>等待最终审批⋯⋯</font>";
			} else if(value === "5"){
				return "<font color='green'>已批准立项</font>";
			} else if(value === "6"){
				return "<font color='red'>本次申报失败</font>";
			} else {
				return "";
			}
		}
		
		function optionFormatter(value, row, index) {
			var array = [];
			if(row.item_submit === "1") {
				array.push(row.item_submit);
			}
			if(array.length != 0) {
				$("#editApply").show();
				return [
		            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png'/>修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",  
		            "<a href='javascript:void(0);' onclick='destory(" + row.item_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/cancel.png'/>删除</a>",
		        ].join("");
			} else {
				$("#editApply").hide();
				$("#submitBatchs").hide();
				$("#removeApply").hide();
				return [
		            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png'/>查看详细</a>&nbsp;&nbsp;&nbsp;",  
		        ].join("");
			}
		}
		
		function changeSubmit(index) {
			//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			if(row.item_submit === "1") {
				$.messager.confirm("更改提交状态", "是否提交项目申报书：<font color=red>" + row.item_name + "</font>？", function(r){
					var item_submit = "2";
					changeStatus(r, row.item_id, item_submit);
				});
			}
		}
		
		function changeStatus(r, item_id, item_submit) {
			if (r) {
				$.post("${pageContext.request.contextPath }/apply/submitApply.do",
				{
					item_id : item_id,
					item_submit : item_submit
				},
				function(data) {
					if (data.state) {
						$.messager.alert("系统提示","恭喜您，申报书提交成功！","info");
						$("#dg").datagrid("unselectAll");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示","申报书提交失败！","error");
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
			row.item_starttime = dateFormatter(row.item_starttime);
			row.item_deadline = dateFormatter(row.item_deadline);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "编辑项目申报书");
				$("#fm").form("load", row);
				//document.getElementById("user_name").disabled = true;
				url = "${pageContext.request.contextPath }/apply/updateApply.do";
			}
		};
		
		 function destory(item_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//提示是否确认删除
			$.messager.confirm("系统提示","您是否确定要删除申报项目：<font color=red>" + row.item_name + "</font>？",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/apply/deleteApplyById.do",
					{
						item_id : item_id,
					},
					function(data) {
						if (data.state) {
							$.messager.alert("系统提示","恭喜您，数据删除成功！", "info");
							$("#dg").datagrid("reload");
						} else {
							$.messager.alert("系统提示","数据删除失败，请重新操作！", "error");
						}
					},"json");
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		};
		
		function loadType() {
			$.ajax({
			    type: "POST",
			    url: '../../itemType/list.do',
			    dataType: "json",
			    success: function(data) {
			    	//js中的方法：unshift() 方法可向数组的开头添加一个或更多元素，并返回新的长度
			    	data.unshift({itemType_id : "", itemType_name : "-----请选择项目类别-----", "itemType_createTime" : "", "item_description" : "", "item_count" : ""});
			        $('#type').combobox({
			            data: data,
			            valueField: 'itemType_name',		//相当于数据库里的字段值
			            textField: 'itemType_name',			//显示在页面下拉列表上的字段值
			            onSelect : function(record) {
							//alert("选择一个时触发");
							//console.log(record);
						},
			        });
			        //默认选中第一项
			        $('#type').combobox('select',"-----请选择项目类别-----");
			    },
			});
		}
		
	</script>
	
	<body onload="loadType();">
	
		<%
			Calendar calendar=Calendar.getInstance(); 
    		int year=calendar.get(Calendar.YEAR); 
			request.getSession().setAttribute("year", year);
		 %>
	
		<div id="toolbar" style="padding:5px;">
			<!-- 工具栏 -->
			<div>
				<a id="addApply" class="easyui-linkbutton" data-options="iconCls:'icon-item_add',plain:true" href="javascript:addApply();">新增申报</a>
				<a id="editApply" class="easyui-linkbutton" data-options="iconCls:'icon-item_edit',plain:true" href="javascript:editApply();">修改项目申报书</a>
				<a id="removeApply" class="easyui-linkbutton" data-options="iconCls:'icon-item_delete',plain:true" href="javascript:removeApply();">批量删除</a>
				<a id="submitBatchs" class="easyui-linkbutton" data-options="iconCls:'icon-enabled',plain:true" href="javascript:submitBatchs();">批量提交</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" href="javascript:print();">打印文档</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-page_excel',plain:true" href="javascript:page_excel();">导出Excel</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" href="javascript:help();">帮助中心</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新页面</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- <span>按条件查询：</span>&nbsp;&nbsp; -->
				<span>&nbsp;&nbsp;申报年份：</span>
				<select id="year" name="apply_year" class="easyui-combobox" style="width:125px;">
					<option value="">----请选择年份----</option>
					<option value="${year }">${year }</option>
					<option value="${year-1 }">${year-1 }</option>
					<option value="${year-2 }">${year-2 }</option>
					<option value="${year-3 }">${year-3 }</option>
					<option value="${year-4 }">${year-4 }</option>
					<option value="${year-5 }">${year-5 }</option>
					<option value="${year-6 }">${year-6 }</option>
					<option value="${year-7 }">${year-7 }</option>
					<option value="${year-8 }">${year-8 }</option>
					<option value="${year-9 }">${year-9 }</option>
				</select>
				<span>&nbsp;&nbsp;项目类别：</span>
				<select id="type" name="item_type" class="easyu1i-combobox" style="width:150px;" >
					<!-- <option value="">-----请选择项目类别-----</option> -->
				</select>
				<span>&nbsp;&nbsp;项目名称：</span>
				<input type="text" id="searchBox" name="str" placeholder="请输入关键字" size="20" onkeydown="if(event.keyCode==13) search()"/>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:search();">开始查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-clear',plain:true," href="javascript:clear();">重置查询</a>
			</div>
		</div>
		
		<table id="dg"></table>
		
		<div id="dlg" class="easyui-dialog" style="width:500px; height:480px; padding:10px 20px" data-options="iconCls:'icon-save',closed:true,collapsible:true,minimizable:true,maximizable:true,resizable:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="item_id" name="item_id"/>
				<table cellspacing="8px">
					<tr>
						<td>项目名称</td>
						<td>
							<input type="text" id="item_name" name="item_name" class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>项目类别</td>
						<td>
							<select id="item_type" class="easyui-combobox" name="item_type" style="width:150px;" data-options="valueField:'itemType_name',textField:'itemType_name',url:'../../itemType/list.do'" > 
								<!-- <option value="">-----请选择项目类别-----</option> -->
							</select>
						</td>
					</tr>
					<tr>
						<td>项目申报人</td>
						<td>
							<input type="text" id="item_user" name="item_user" value="${user.user_name }">&nbsp;
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
						<td>起始日期</td>
						<td>
							<input type="text" id="item_starttime" name="item_starttime" class="easyui-datebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>截止日期</td>
						<td>
							<input type="text" id="item_deadline" name="item_deadline" class="easyui-datebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>项目描述</td>
						<td>
							<input type="text" id="item_description" name="item_description" class="easyui-textbox" required="true">&nbsp;
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