<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

	<!-- 引入 EasyUI 核心 UI 文件 CSS  -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.3.5/themes/default/easyui.css"/> 
	<!-- 引入 EasyUI 图标文件  -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.3.5/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/admin.css" />

</head>
<body class="easyui-layout">

	<div data-options="region:'north',title:'header',split:true,noheader:true," style="height:60px;background:#666;">
		<div class="logo">后台管理</div>
		<div class="logout">您好，${si.user_name } | <a href="#">退出用户</a></div>
	</div>   
    <div data-options="region:'south',title:'footer',split:true,noheader:true," style="height:35px;line-height:30px;text-align:center;">&copy;2018. Powered by JAVA and EasyUI.</div>   
    <div data-options="region:'west',title:'导航',split:true,iconCls:'icon-world'," style="width:180px;padding:10px;">
    	<ul id="nav"></ul>
    </div>   
    <div data-options="region:'center'," style="overflow:hidden;">
    	<div id="tabs">
    		<div title="起始页" data-options="iconCls:'icon-house'" style="padding:0 10px;display:block;">
    		欢迎来到后台管理系统
    		</div>
    	</div>
    </div>
    
    <!-- 引入 jQuery 核心库，这里采用的是 2.0 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.3.5/jquery.min.js"></script>
	<!-- 引入 jQuery EasyUI 核心库，这里采用的是 1.3.5 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
	<!-- 引入 EasyUI 中文提示信息 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>
	<!-- 引入自己开发的 JS 文件  -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin.js"></script>

</body>
</html>