function calender() {
	var time = new Date();
	var year = time.getFullYear();
	var month = toPair(time.getMonth() + 1);
	var day = toPair(time.getDate());
	var hour = toPair(time.getHours());
	var minute = toPair(time.getMinutes());
	var second = toPair(time.getSeconds());
	var dateweek;

	switch (time.getDay()) {
	case 0:
		dateweek = "星期日";
		break;
	case 1:
		dateweek = "星期一";
		break;
	case 2:
		dateweek = "星期二";
		break;
	case 3:
		dateweek = "星期三";
		break;
	case 4:
		dateweek = "星期四";
		break;
	case 5:
		dateweek = "星期五";
		break;
	case 6:
		dateweek = "星期六";
		break;
	}

	var timeDiv = document.getElementById('timeDiv');
	timeDiv.innerHTML = "今天是：" + year + "年" + month + "月" + day + "日　" + hour
			+ ":" + minute + ":" + second + "　" + dateweek;
	var mytime = setTimeout("calender()", 1000);
}

calender();

function toPair(str) {
	if (Number(str) < 10) {
		return "0" + str;
	} else {
		return str;
	}
}