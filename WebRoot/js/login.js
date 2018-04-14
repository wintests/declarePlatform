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
		missingMessage : "请输入管理员账号",
		invalidMessage : "管理员账号不能为空",
	});
	
	//管理员密码验证
	$("#password").validatebox({
		required : true,
		validType : "length[6,30]",
		missingMessage : "请输入管理员密码",
		invalidMessage : "管理员密码必须在6-30位之间",
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
						location.href = "home.do";
					} else {
						$.messager.alert("登录失败！","用户名或密码错误","warning",function() {
							$("#password").select();
						});
					}
				},
				"dataType":"json",
			});
		}
	});
});