<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
	<%@include file="./head.jspf"%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/login.css" />
	<link rel="shortcut icon" href="#" />
	<!-- 引入自己开发的 JS 文件  -->
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/login.js"></script> --%>
	
	<script type="text/javascript">
		$(function(){
			//登录界面
			$("#login").dialog({
				title : "登录界面",
				width : 300,
				height : 180,
				modal : true,
				iconCls : "icon-login",
				buttons : "#btn",
				//align : "center",
			});
			
			//管理员账号验证
			$("#manager").validatebox({
				required : true,
				missingMessage : "请输入账号",
				invalidMessage : "账号不能为空",
			});
			
			//管理员密码验证
			$("#password").validatebox({
				required : true,
				validType : "length[6,30]",
				missingMessage : "请输入密码",
				invalidMessage : "密码必须在6-30位之间",
			});
			
			//加载时判断验证
			if (!$('#manager').validatebox('isValid')) {
				$('#manager').focus();
			} else if (!$('#password').validatebox('isValid')) {
				$('#password').focus();
			}
			
			//点击登录
			$("#btn a").click(function() {
				if(!$("#manager").validatebox("isValid")) {
					$("#manager").focus();
				} else if(!$("#password").validatebox("isValid")) {
					$("#password").focus();
				} else {
					$.ajax({
						url : "checklogin.do",
						type : "post",
						data : {
							user_name : $("#manager").val(),
							user_pass : $("#password").val(),
						},
						beforeSend : function() {
							$.messager.progress({
								text : "正在登录中...",
							});
						},
						success : function(data) {
							$.messager.progress("close");
							/*此处的data指数据库中受影响的行数*/
							if(data.data != null) {
								if(data.data.signln_valid != "1") {
									location.href = "home.do";
								} else {
									$.messager.alert("登录失败！","<font size='2'>该用户已被禁用，请联系相关人员处理！</font>","warning",function() {
										$("#password").select();
									});
								}
							} else {
								console.log(data);
								$.messager.alert("登录失败！","<font size='2'>用户名或密码错误！</font>", "error",function() {
									$("#password").select();
								});
							}
						},
						"dataType":"json",
					});
				}
			});
		});
	</script>
	
</head>
<body>
	<div id="login">
		<p>账号：<input type="text" id="manager" name="user_name" class="textbox"/></p>
		<p>密码：<input type="password" id="password" name="user_pass" class="textbox"/></p>
	</div>

	<div id="btn">
		<a href="#" class="easyui-linkbutton">登录</a>
	</div>
	
</body>
</html>