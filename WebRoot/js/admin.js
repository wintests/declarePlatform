$(function() {

	$("#nav").tree({
		// url : "nav.php",
		lines : true,
		onLoadSuccess : function(node, data) {
			if (data) {
				$(data).each(function(index, value) {
					if (this.state == "close") {
						$("#nav").tree("expandAll");
					}
				});
			}
		},
		onClick : function(node) {
			if (node.url) {
				if ($("#tabs").tabs("exist", node.text)) {
					$("#tabs").tabs("select", node.text);
				} else {
					$("#tabs").tabs("add", {
						title : node.text,
						iconCls : node.iconCls,
						closeable : true,
					// href : node.url + ".php",
					});
				}
			}
		}
	});

	$("#tabs").tabs({
		fit : true,
	});
});

function logout() {
	/*
	 * $.messager.defaults = { ok : "是", cancel : "否", };
	 */

	$.messager.confirm("操作提示", "是否退出当前用户", function(flag) {
		if (flag) {
			location.href = "logout.do";
		}
	});
}
