<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系部审核管理</title>
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
				url : '../../review1/listReview1.do?review1_status=' + '${review1_status }' + '&user_department=' + '${apply.user_department }' + '&history_flag=' + '${apply.history_flag }',
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
				idField : 'review1_id',
				striped : true,	//隔行换色
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : '#toolbar',
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				onLoadSuccess: function (data) {
		            if (data.total != 0) {
		            	var array = [];
		            	for(var i = 0 ; i < data.rows.length; i++) {
		            		if(data.rows[i].review1_status === "1")
		            			array.push(data.rows[i].review1_status);
		            	}
	            		if(array.length == data.rows.length) {
	            			$("#dg").datagrid("hideColumn", "review1_user");
	            			$("#dg").datagrid("hideColumn", "review1_operator");
	            			$("#dg").datagrid("hideColumn", "review1_time");
	            			$("#dg").datagrid("hideColumn", "review1_remark");
	            		} else if(array.length != 0 && array.length != data.rows.length) {
	            			$("#dg").datagrid("hideColumn", "review1_status");
	            			$("#dg").datagrid("hideColumn", "review1_user");
	            			$("#dg").datagrid("hideColumn", "review1_operator");
	            			$("#dg").datagrid("hideColumn", "review1_time");
	            			$("#dg").datagrid("hideColumn", "review1_remark");
	            			$("#dg").datagrid("hideColumn", "option");
	            		}
		            } else {
		            	$.messager.alert("提示框","未查询到相关数据！", "info");
		            }
		        },
				columns : [ [ 
					{field : 'review1_id',title : '审核序号',align : 'center',width : 100, hidden : true}, 
					{field : 'item_id',title : '项目编号',align : 'center',width : 100, hidden : true}, 
					{field : 'item_name',title : '项目名称',align : 'center',width : 100}, 
					{field : 'item_type',title : '项目类别',align : 'center',width : 100},
					{field : 'item_user',title : '项目申报人',align : 'center',width : 100}, 
					{field : 'user_department',title : '所属系部',align : 'center',width : 100}, 
					{field : 'user_title',title : '职称',align : 'center',width : 100}, 
					{field : 'apply_year',title : '申报年份',align : 'center',width : 100}, 
					{field : 'apply_time',title : '提交时间',align : 'center',width : 100, formatter : datetimeFormatter}, 
					{field : 'item_description',title : '项目描述',align : 'center',width : 100},
					{field : 'review1_status',title : '审核状态',align : 'center',width : 100, formatter : review1_statusFormatter},
					{field : 'review1_user',title : '审核单位',align : 'center',width : 100},
					{field : 'review1_operator',title : '操作人员',align : 'center',width : 100},
					{field : 'review1_time',title : '审核时间',align : 'center',width : 100, formatter : datetimeFormatter},
					{field : 'review1_remark',title : '备注',align : 'center',width : 100},
					{field : 'history_flag',title : '时间标志',align : 'center',width : 100},
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
		
		function reload() {
			$("#dg").datagrid("reload");
		}
		
		function search() {
			var str = $("#searchBox").val();
			var item_type = $("#type").combobox("getValue");
			
			if(item_type === "-----请选择项目类别-----") {
				item_type = "";
			}
    		
			$("#dg").datagrid("load",{
				str : str,
				item_type : item_type,
			});
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
						$.messager.alert("系统提示", "恭喜您，数据保存成功！","info");
						//alert(1);
						$("#fm").form("reset");
						$("#dlg").dialog("close"); //关闭对话框
						$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
						$("#dg").datagrid("reload"); //刷新一下
					} else {
						$.messager.alert("系统提示", "数据保存失败，请重新操作！","error");
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
        
		function review1_statusFormatter(value,row,index) {
			if(value === "1") {
				return "<a href='javascript:void(0);' onclick='changeReview("+index+")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/mini_edit.png'/><font color='purple'>待审核</font>";
			} else if(value === "2") {
				return "<font color='green'>审核通过</font>";
			} else if(value === "3"){
				return "<font color='red'>审核不通过</font>";
			} else {
				return "";
			}
		}
		
		function optionFormatter(value, row, index) {
			return [
	            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png' title='查看详细'/>查看详细</a>",  
	        ].join("");
		}
		
		function changeReview(index) {
			//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//将时间格式化，因为当前数据的实际格式为JSON序列化的形式，而并非"yyyy-MM-dd"，只有格式化之后，数据才能够正确回填到form表格
			row.item_starttime = dateFormatter(row.item_starttime);
			row.item_deadline = dateFormatter(row.item_deadline);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "审核项目信息");
				$("#fm").form("load", row);
				//console.log(row);
				document.getElementById("item_name").disabled = true;
				document.getElementById("item_type").disabled = true;
				document.getElementById("item_user").disabled = true;
				//document.getElementById("user_department").disabled = true;
				document.getElementById("item_starttime").disabled = true;
				document.getElementById("item_deadline").disabled = true;
				document.getElementById("item_description").disabled = true;
				url = "${pageContext.request.contextPath }/review1/updateReview1.do";
			}
		}
		
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
		<div id="toolbar" style="padding:5px;">
			<!-- 工具栏 -->
			<div>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span>按条件查询：</span>&nbsp;&nbsp;
				<select id="type" name="item_type" class="easyui-combobox" style="width:150px;" >
					<!-- <option value="">-----请选择项目类别-----</option> -->
				</select>
				<input type="text" id="searchBox" name="str" placeholder="按项目名称或申报人查找" size="20" onkeydown="if(event.keyCode==13) search()"/>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:search();">查询</a>
			</div>
		</div>
		
		<table id="dg"></table>
		
		<div id="dlg" class="easyui-dialog" style="width:500px; height:480px; padding:10px 20px" data-options="iconCls:'icon-save',closed:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="review1_id" name="review1_id"/>
				<input type="hidden" id="item_id" name="item_id"/>
				<input type="hidden" id="review1_user" name="review1_user" value="${user.user_department }"/>
				<input type="hidden" id="review1_operator" name="review1_operator" value="${user.real_name }"/>
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
					<!-- <tr>
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
					</tr> -->
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
							<input type="text" id="item_description" name="item_description" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
					<!-- <tr>
						<td>更改审核状态</td>
						<td>
							<select id="review1_status" name="review1_status" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="2">审核通过</option>
								<option value="3">审核不通过</option>
							</select> &nbsp;
						</td>
					</tr> -->
					<tr>
						<td>更改审核状态</td>
						<td>
							<input type="radio" name="review1_status" value="2" />审核通过&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="review1_status" value="3" />审核不通过
						</td>
					</tr>
					<tr>
						<td>备注</td>
						<td>
							<input type="text" id="review1_remark" name="review1_remark" class="easyui-textbox" required="true">&nbsp;
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