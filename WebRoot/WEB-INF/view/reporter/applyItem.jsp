<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>新增申报项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../head.jspf" %>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3_3/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3_3/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3_3/lang/zh-cn/zh-cn.js"></script>
	<style type="text/css">
		table{
			border-top:1px solid #000;
			border-left:1px solid #000;
			border-right:1px solid #000;
			border-bottom:1px solid #000;
		}
		
		a{
			text-decoration:none;
		}
		
		a:hover{
			text-decoration:underline;
			font-weight:bold;
			font-size: 14px;
			/* color: #E96129; */
		}
	</style>
	<script type="text/javascript">
	
		function submitData() {
			if($("#fm").form("validate")) {
				$.messager.confirm("系统提示","<font size='2'>是否直接提交申报项目？</font>", function(flag) {
					if(flag) {
						$("#item_submit").val("2");
						$("#fm").form("submit",{
							url: "${pageContext.request.contextPath}/apply/addApply.do",
							onSubmit: function() {
								var item_description = UE.getEditor("editor").getContent();
								$("#item_description").val(item_description); //将UEditor编辑器中的内容放到隐藏域中提交到后台
								var item_type = $("#item_type").combobox("getValue");
								if(item_type === "-----请选择项目类别-----") {
									$("#item_type").combobox("setValue", "");
								}
								return $(this).form("validate");
							}, //进行验证，通过才让提交
							success: function(data) {
								//将json格式的result转换成js对象
								console.log(data);
								var data = JSON.parse(data);
								if(data.state) {
									$.messager.alert("系统提示", "<font size='2'>申报提交成功！</font>","info");
									$("#fm").form("reset");
									UE.getEditor("editor").setContent("");
								} else {
									$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
									return;
								}
							}
						});
					}
				});
			} else {
				$.messager.alert("系统提示", "<font size='2'>存在必填项未填写完整，不能提交！</font>", "info");
			}
		}
		
		function saveData() {
			if($("#fm").form("validate")) {
				$("#fm").form("submit",{
					url: "${pageContext.request.contextPath}/apply/addApply.do",
					onSubmit: function() {
						$("#item_submit").val("1");
						var item_description = UE.getEditor("editor").getContent();
						$("#item_description").val(item_description); //将UEditor编辑器中的内容放到隐藏域中提交到后台
						var item_type = $("#item_type").combobox("getValue");
						if(item_type === "-----请选择项目类别-----") {
							$("#item_type").combobox("setValue", "");
						}
						return $(this).form("validate");
					}, //进行验证，通过才让提交
					success: function(data) {
						//将json格式的result转换成js对象
						console.log(data);
						var data = JSON.parse(data);
						if(data.state) {
							$.messager.alert("系统提示", "<font size='2'>保存成功，请到<font color='red'>待提交的项目</font>中查看！</font>","info");
							$("#fm").form("reset");
							UE.getEditor("editor").setContent("");
						} else {
							$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
							return;
						}
					}
				});
			} else {
				$.messager.alert("系统提示", "<font size='2'>存在必填项未填写完整，不能保存！</font>", "info");
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
			        $('#item_type').combobox({
			            data: data,
			            valueField: 'itemType_name',		//相当于数据库里的字段值
			            textField: 'itemType_name',			//显示在页面下拉列表上的字段值
			        });
			        //默认选中第一项
			        $('#item_type').combobox('select',"-----请选择项目类别-----");
			    },
			});
		}
		
		function submitFileUpload() {
			var option = {
					type:'POST',
					url:'${pageContext.request.contextPath }/upload/uploadFile.do',
					dataType:'text',
					data:{
						fileName : 'importFile'
					},
					success:function(data){
						//console.log(data);
						//把json格式的字符串转换成json对象(data为文件路径fullPath和relativePath)
						var jsonObj = $.parseJSON(data);
						//返回服务器图片路径，把图片路径设置给img标签
						//$("#imgSrc").attr("src",jsonObj.fullPath);
						//数据库保存相对路径
						$("#filePath").val(jsonObj.relativePath);
					}
				};
			$("#fm").ajaxSubmit(option);
		}
	</script>
</head>

<body style="margin: 10px; font-family: microsoft yahei" onload="loadType();">
	<div id="p" class="easyui-panel" title="填写申报信息" style="padding: 10px; width: 1720px">
		<form id="fm" method="POST">
			<input type="hidden" id="item_user" name="item_user" value="${user.real_name }">
			<input type="hidden" id="user_title" name="user_title" value="${user.user_title }">
			<input type="hidden" id="user_department" name="user_department" value="${user.user_department }">
			<input type="hidden" id="item_submit" name="item_submit" value="1">
			<h2 align="center">请填写申报信息</h2>
			<hr/><br/>
			<table cellspacing="20px" align="center" width="60%">
				<tr>
					<td width="80px">项目名称：</td>
					<td>
						<input type="text" id="item_name" name="item_name" class="easyui-validatebox" data-options="required:true">
					</td>
					<td>项目类别：</td>
					<td>
						<select id="item_type" class="easyui-combobox" name="item_type" style="width:170px;" data-options="valueField:'itemType_name',textField:'itemType_name',url:'../../itemType/list.do'" > 
							<!-- <option value="">-----请选择项目类别-----</option> -->
						</select>
					</td>
				</tr>
				<tr>
					<td width="80px">起始日期：</td>
					<td width="180px">
						<input type="text" id="item_starttime" name="item_starttime" class="easyui-datebox" required="true">
					</td>
					<td width="80px">截止日期：</td>
					<td width="180px">
						<input type="text" id="item_deadline" name="item_deadline" class="easyui-datebox" required="true">
					</td>
				</tr>
				<tr>
					<td>附件上传：</td>
					<td>
						<input type='file' id='importFile' name='importFile' class="file" onchange='submitFileUpload()' />
				        <input type='hidden' id='filePath' name='path' value='' reg="^.+$" tip="亲！您忘记上传文件了。" />
					</td>
				</tr>
				<tr>
					<td>项目描述：</td>
					<td>
						<!-- 加载编辑器的容器 -->
						<script id="editor" type="text/plain" style="width:123%; height:300px;"></script>
						<input type="hidden" id="item_description" name="item_description"> <%-- UEditor不能作为表单的一部分提交，所以用这种隐藏域的方式 --%>
					</td>
				</tr>
				<tr>
					<td></td>
					<td align="right">
						<a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit',plain:true">提交申报</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:saveData()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">暂时保存</a>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<%-- 实例化编辑器 --%>
	<script type="text/javascript">
		var ue = UE.getEditor('editor');
		/* ue.addListener("ready", function(){
			//通过UE自己封装的ajax请求数据
			UE.ajax.request("${pageContext.request.contextPath}/admin/blogger/findBlogger.do",
					{
						method: "POST",
						async: false,
						data: {},
						onsuccess: function(result) { //
							result = eval("(" + result.responseText + ")");
							$("#nickname").val(result.nickname);
							$("#sign").val(result.sign);
							UE.getEditor('item_description').setContent(result.item_description);
						}
					});
		}); */
	</script>

</body>
</html>
