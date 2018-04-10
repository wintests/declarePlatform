<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
	
	<!-- 引入 EasyUI 核心 UI 文件 CSS  -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.3.5/themes/default/easyui.css"/> 
	<!-- 引入 EasyUI 图标文件  -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.3.5/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/login.css" />
</head>
<body>

	<div id="login">
		<p>管理员账号：<input type="text" id="manager" name="user_name" class="textbox"/></p>
		<p>管理员密码：<input type="password" id="password" name="user_pass" class="textbox"/></p>
	</div>

	<div id="btn">
		<a href="#" class="easyui-linkbutton">登录</a>
	</div>

<!-- 引入 jQuery 核心库，这里采用的是 2.0 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.3.5/jquery.min.js"></script>
	<!-- 引入 jQuery EasyUI 核心库，这里采用的是 1.3.6 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
	<!-- 引入 EasyUI 中文提示信息 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>
	<!-- 引入自己开发的 JS 文件  -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/login.js"></script>

</body>
</html>