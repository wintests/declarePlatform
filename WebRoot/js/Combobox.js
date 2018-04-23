$(function(){
	$("#itemType_name").combobox({
		valueField : "itemType_id",
		textField : "itemType_name",
		url : "../../itemType/list.do",
		/*filter: function(q, row){
			var opts = $(this).combobox('options');
			return row[opts.textField].indexOf(q) >= 0;
		},
		formatter: function(row){
			var opts = $(this).combobox('options');
			return "[" + row[opts.textField] + "]";
		},
		
		onSelect : function(record) {
			alert("选择一个时触发");
			console.log(record);
		},
		onUnselect : function(record) {
			alert("取消选择一个时触发");
			console.log(record);
		},*/
	});
	
});

