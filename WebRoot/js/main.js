$(function() {

//	$("#nav").tree({
//		// url : "nav.php",
//		lines : true,
//		onLoadSuccess : function(node, data) {
//			if (data) {
//				$(data).each(function(index, value) {
//					if (this.state == "close") {
//						$("#nav").tree("expandAll");
//					}
//				});
//			}
//		},
//		onClick : function(node) {
//			if (node.url) {
//				if ($("#tabs").tabs("exist", node.text)) {
//					$("#tabs").tabs("select", node.text);
//				} else {
//					$("#tabs").tabs("add", {
//						title : node.text,
//						iconCls : node.iconCls,
//						closeable : true,
//					// href : node.url + ".php",
//					});
//				}
//			}
//		}
//	});
//
//	$("#tabs").tabs({
//		fit : true,
//	});
});

function logout() {
	/*
	 * $.messager.defaults = { ok : "是", cancel : "否", };
	 */
	$.messager.confirm("操作提示", "是否退出当前用户", function(flag) {
		console.log(flag);
		if (flag) {
			location.href = "logout.do";
		}
	});
}

/**
 * 打开选项卡
 * @param text  选项卡标题
 * @param url   请求打开路径
 * @param icon  选项卡图标
 */
function openTab(text,url,icon) {
    //判断当前选项卡是否存在
    if($('#tabs').tabs('exists',text)){
        //如果存在 显示
        $("#tabs").tabs("select",text);
    }else{
        //如果不存在 则新建一个
    	//alert(url)
        $("#tabs").tabs('add',{
            title : text,
            closable : true,   //是否允许选项卡摺叠。
            iconCls : icon,    //显示图标
            //url 远程加载所打开的url
            content:"<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='" + url + "'></iframe>"
        });
    }
}

function openPasswordModifyDialog() {
	$("#dlg").dialog("open").dialog("setTitle", "修改密码");
}

function modifyPassword() {
	$("#fm").form("submit",{
		url: "user/modifyPassword.do",
		onSubmit: function() {
			var newUser_pass = $("#user_pass").val();
			var newUser_pass2 = $("#user_pass2").val();
			if(!$(this).form("validate")) {
				return false; //验证不通过直接false，即没填
			} 
			if(newUser_pass != newUser_pass2) {
				$.messager.alert("系统提示", "两次密码必须填写一致");
				return false;
			}
			return true;
		}, //进行验证，通过才让提交
		success: function(data) {
			//var data = eval("(" + data + ")"); //将json格式的data转换成js对象
			var data = JSON.parse(data);
			//console.log(data)
			if(data.state) {
				$.messager.alert("系统提示", "密码修改成功，下一次登陆生效");
				closePasswordModifyDialog();
			} else {
				$.messager.alert("系统提示", "密码修改失败");
				return;
			} 
		}
	});
}

function closePasswordModifyDialog() {
	$("#user_pass").val(""); //保存成功后将内容置空
	$("#user_pass2").val("");
	$("#dlg").dialog("close"); //关闭对话框
}
