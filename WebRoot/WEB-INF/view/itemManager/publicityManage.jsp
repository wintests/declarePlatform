<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>立项审批管理</title>
	<%@include file="../head.jspf"%>
	<style type="text/css">
		a{
			text-decoration:none;
		}
		
		#searchBox{
		    background: #fff8f8;
		    font-size: 12px;
		    width: 150px;
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
				url : '../../publicity/listPublicity.do?publicity_status=' + '${publicity_status }' + '&history_flag=' + '${apply.history_flag}',
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
				sortOrder : 'asc',
				remoteSort : false,
				//指定id为标识字段，在删除，更新的时候有用，如果配置此字段，在翻页时，换页不会影响选中的项
				idField : 'publicity_id',
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
		            		if(data.rows[i].publicity_status != "1") {
		            			array1.push(data.rows[i].publicity_status);
		            			if(data.rows[i].publicity_grade	!= null) {
		            				array2.push(data.rows[i].publicity_grade);
		            			}
		            		}
		            	}
	            		if(array1.length == 0) {
	            			$("#dg").datagrid("hideColumn", "item_starttime");
	            			$("#dg").datagrid("hideColumn", "item_deadline");
	            			$("#dg").datagrid("hideColumn", "review2_user");
	            			//$("#dg").datagrid("hideColumn", "publicity_status");
	            			$("#dg").datagrid("hideColumn", "publicity_grade");
	            			$("#dg").datagrid("hideColumn", "publicity_time");
	            			$("#dg").datagrid("hideColumn", "publicity_remark");
	            		} else {
	            			if(array2.length == 0) {
		            			$("#dg").datagrid("hideColumn", "publicity_grade");
		            			$("#dg").datagrid("hideColumn", "option");
		            		}
	            		}
		            } else {
		            	$.messager.alert("提示框","<font size='2'>未查询到相关数据！</font>", "info");
		            }
		        },
				columns : [ [ 
					{field : 'publicity_id',title : '审批序号',align : 'center',width : 100, hidden : true}, 
					{field : 'item_id',title : '项目编号',align : 'center',width : 100, hidden : true}, 
					{field : 'item_name',title : '项目名称',align : 'center',sortable : true,width : 100}, 
					{field : 'item_type',title : '项目类别',align : 'center',width : 100},
					{field : 'item_user',title : '项目申报人',align : 'center',sortable : true,width : 100}, 
					{field : 'user_title',title : '职称',align : 'center',width : 100}, 
					{field : 'apply_year',title : '申报年份',align : 'center',sortable : true,width : 100}, 
					{field : 'item_starttime',title : '开始日期',align : 'center',width : 100, formatter : dateFormatter}, 
					{field : 'item_deadline',title : '截止日期',align : 'center',width : 100, formatter : dateFormatter}, 
					{field : 'review1_user',title : '推荐单位',align : 'center',width : 100},
					{field : 'review2_user',title : '评审专家',align : 'center',width : 100},
					{field : 'review2_score',title : '评审得分',align : 'center',sortable : true,width : 100, formatter : review2_scoreFormatter},
					{field : 'publicity_status',title : '审批状态',align : 'center',width : 100, formatter : publicity_statusFormatter},
					{field : 'publicity_grade',title : '立项等级',align : 'center',width : 100, formatter : publicity_gradeFormatter},
					{field : 'publicity_time',title : '审批时间',align : 'center',sortable : true,width : 100, formatter : datetimeFormatter},
					{field : 'publicity_remark',title : '备注',align : 'center',width : 100},
					{field : 'history_flag',title : '时间标志',align : 'center',width : 100},
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
		
		function reload() {
			$("#dg").datagrid("reload");
		}
		
		function print() {
			alert("print");
		}
		
		function page_excel() {
			//先返回页面参数对象，然后得到对象的页数pageNumber和页面大小pageSize
			var options = $("#dg" ).datagrid("getPager" ).data("pagination" ).options;
		    var pageNumber = options.pageNumber;
		    var pageSize = options.pageSize;
		
			var apply_year = $("#year").combobox("getValue");
			var item_type = $("#type").combobox("getValue");
			var user_department = $("#department").combobox("getValue");
			var user_title = $("#title").combobox("getValue");
			var str = $("#searchBox").val();
			
			if(item_type === "-----请选择项目类别-----") {
				item_type = "";
			}
			
			window.location.href = "../../resource/publicityExcelExport.do?publicity_status=" + '${publicity_status }' + '&history_flag=' + '${apply.history_flag}'
								+ "&apply_year=" + apply_year + "&item_type=" + item_type + "&user_department=" + user_department 
								+ "&user_title=" + user_title + "&str=" + str + "&page=" + pageNumber + "&rows=" + pageSize;
		}
		
		function help() {
			alert("help");
		}
		
		function search() {
			var str = $("#searchBox").val();
			var apply_year = $("#year").combobox("getValue");
			var item_type = $("#type").combobox("getValue");
			var user_department = $("#department").combobox("getValue");
			var user_title = $("#title").combobox("getValue");
			
			if(item_type === "-----请选择项目类别-----") {
				item_type = "";
			}
			
			$("#dg").datagrid("load",{
				str : str,
				apply_year : apply_year,
				item_type : item_type,
				user_department : user_department,
				user_title : user_title,
			});
		}
		
		function clear() {
			$("#year").combobox("setValue", "");
			$("#type").combobox("setValue", "-----请选择项目类别-----");
			$("#department").combobox("setValue", "");
			$("#title").combobox("setValue", "");
			$("#searchBox").val("");
		}
		
		//定义全局url
		var url;
		
		function saveDialog() {
			$("#fm").form("submit", {
				url : url,
				onSubmit : function() {
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					var data = JSON.parse(data);
					if (data.state) {
						$.messager.alert("系统提示", "<font size='2'>恭喜您，数据保存成功！</font>", "info");
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
		
		function publicity_statusFormatter(value,row,index) {
			if(value === "1") {
				return "<a href='javascript:void(0);' onclick='changeReview("+index+")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/mini_edit.png'/><font color='purple'>待审批</font>";
			} else if(value === "2") {
				return "<font color='green'>已立项</font>";
			} else if(value === "3"){
				return "<font color='red'>不允许立项</font>";
			} else {
				return "";
			}
		}
		
		function publicity_gradeFormatter(value, row, index) {
			if(value === "1") {
				return "重点";
			} else if(value === "2") {
				return "一般";
			} else {
				return "";
			}
		}
		
		function review2_scoreFormatter(value,row,index) {
			if(value >= 90 && value <= 100) {
				return "A";
			} else if(value >= 80 && value < 90) {
				return "B";
			} else if(value >= 70 && value < 80) {
				return "C";
			} else if(value >= 60 && value < 70) {
				return "D";
			} else if(value >= 0 && value < 60){
				return "<font color='red'>E</font>";
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
        
		
		function optionFormatter(value, row, index) {
			if(row.publicity_status === "1") {
				return [
		            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png'/>批准立项</a>&nbsp;&nbsp;&nbsp;",  
		            "<a href='javascript:void(0);' onclick='failure(" + row.publicity_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/cancel.png'/>不允许立项</a>",
		        ].join("");
			} else {
				return [
		            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png'/>查看详细</a>&nbsp;&nbsp;&nbsp;",  
		        ].join("");
			}
		}
		
		function modify(index){
		 	//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			console.log(row);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "审批当前项目");
				$("#fm").form("load", row);
				url = "${pageContext.request.contextPath }/publicity/updatePublicity.do";
			}
		};
		
		function failure(publicity_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//提示是否不允许立项
			$.messager.confirm("系统提示","<font size='2'>您是否确定以下项目将不允许立项：<font color=red>" + row.item_name + "</font>？</font>",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/publicity/updatePublicity.do",
					{
						publicity_id : publicity_id,
						publicity_status : '3',
						publicity_remark : row.publicity_remark
					},
					function(data) {
						if (data.state) {
							$.messager.alert("系统提示","<font size='2'>恭喜您，操作成功！</font>", "info");
							$("#dg").datagrid("reload");
						} else {
							$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
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
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新页面</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" href="javascript:print();">打印文档</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-page_excel',plain:true" href="javascript:page_excel();">导出Excel</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" href="javascript:help();">帮助中心</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- <span>按条件查询：</span>&nbsp;&nbsp; -->
				<span>&nbsp;&nbsp;申报年份：</span>
				<select id="year" name="apply_year" class="easyui-combobox" style="width:100px;">
					<option value="">----请选择----</option>
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
				<span>&nbsp;&nbsp;所属系部：</span>
				<select id="department" name="user_department" class="easyui-combobox" style="width:100px;">
					<option value="">-----请选择-----</option>
					<option value="计算机系">计算机系</option>
					<option value="软件工程系">软件工程系</option>
					<option value="信息安全系">信息安全系</option>
					<option value="网络工程系">网络工程系</option>
				</select>
				<span>&nbsp;&nbsp;申报人职称：</span>
				<select id="title" name="user_title" class="easyui-combobox" style="width:100px;">
					<option value="">-----请选择-----</option>
					<option value="教授">教授</option>
					<option value="副教授">副教授</option>
					<option value="研究员">研究员</option>
					<option value="副研究员">副研究员</option>
					<option value="讲师">讲师</option>
					<option value="助教">助教</option>
				</select> &nbsp;
				<span>&nbsp;&nbsp;项目申报人或项目名称：</span>
				<input type="text" id="searchBox" name="str" placeholder="请输入关键字" size="20" onkeydown="if(event.keyCode==13) search()"/>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:search();">开始查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-clear',plain:true," href="javascript:clear();">重置查询</a>
			</div>
		</div>
		
		<table id="dg"></table>
		
		<div id="dlg" class="easyui-dialog" style="width:500px; height:480px; padding:10px 20px" data-options="iconCls:'icon-guide_edit',closed:true,collapsible:true,minimizable:true,maximizable:true,resizable:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="publicity_id" name="publicity_id"/>
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
							<input type="text" id="item_user" name="item_user" class="easyui-validatebox" required="true">&nbsp;
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
						<td>推荐单位</td>
						<td>
							<input type="text" id="review1_user" name="review1_user" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td><h3>评审得分</h3></td>
						<td>
							<input type="text" id="review2_score" name="review2_score" class="easyui-numberbox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>是否允许立项</td>
						<td>
							<input type="radio" name="publicity_status" value="2" />批准立项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="publicity_status" value="3" />不允许立项
						</td>
					</tr>
					<tr>
						<td>立项等级</td>
						<td>
							<input type="radio" name="publicity_grade" value="1" />重点&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="publicity_grade" value="2" />一般
						</td>
					</tr>
					<tr>
						<td>备注</td>
						<td>
							<input type="text" id="publicity_remark" name="publicity_remark" class="easyui-textbox" required="true">&nbsp;
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