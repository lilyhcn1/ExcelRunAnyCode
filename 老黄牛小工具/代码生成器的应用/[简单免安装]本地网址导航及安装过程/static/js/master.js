//底栏定位
//当页面主体内容高度小于浏览器窗口高度时，底栏定位到底部
$(function() {
	function footerPosition() {
		$("div.footer").removeClass("fixed-bottom");
		var contentHeight = document.body.scrollHeight, //网页正文全文高度
			winHeight = window.innerHeight; //可视窗口高度，不包括浏览器顶部工具栏
		if(!(contentHeight > winHeight)) {
			//当网页正文高度小于可视窗口高度时，为footer添加类fixed-bottom
			$("div.footer").addClass("fixed-bottom");
		} else {
			$("div.footer").removeClass("fixed-bottom");
		}
	}
	footerPosition();
	$(window).resize(footerPosition); //浏览器窗口大小改变时调用footerPosition
});
//底栏定位结束

//搜索建议
function getSuggestion() {
	var strdomin = $.trim($("#input_search").val());
	//jsonp跨域请求，参数wd为关键字；参数p恒为3，暂时不知道用途；参数cb为请求成功后的回调函数的名字，自己实现这个函数来处理得到的数据
	var qsData = {
		'wd': strdomin,
		'p': '3',
		'cb': 'getData'
	};
	$.ajax({
		async: false,
		url: "https://sp0.baidu.com/5a1Fazu8AA54nxGko9WTAnF6hhy/su",
		type: "GET",
		dataType: 'script',
		data: qsData,
		timeout: 500,
		success: function(json) {},
		error: function(xhr) {}
	});
}

function getData(mydata) { //参数mydata即为返回的数据，suggestion以数组形式保存在mydata.s中
	//先清除原来的suggesion列表
	clearSuggestion();
	var length = mydata.s.length;
	var data = mydata.s;
	if(length == 0) {
		//没有请求到suggestion时则不显示suggestion列表
		hiddenSuggestion();
	} else {
		//显示suggestion列表
		showSuggestion();
		//suggestionLength和index是两个全局变量，代表列表项长度和索引，在编写键盘事件函数时会用到
		suggestionLength = (length > 10 ? 10 : length);
		index = 0;
		for(i = 0; i < (length > 10 ? 10 : length); i++) {
			var li = $("<li id='li" + i + "' onMouseDown='mouseOverEvent(this)' onMouseOut='mouseOutEvent(this)' onclick='search()'></li>").text(data[i]);
			$("#suggestionUl").append(li);
		}
	}
}

function showSuggestion() {
	$("#suggestion").removeAttr("hidden");
}

function hiddenSuggestion() {
	$("#suggestion").attr("hidden", "hidden");
}

function clearSuggestion() {
	$("#suggestionUl").html("");
}

function mouseOverEvent(x) {
	$("#input_search").val(x.innerHTML); //更新输入框的内容
	x.className = "mouseOver"; //修改样式为高亮
	//若不清除onblur属性，在点击鼠标时，将先执行hiddenSuggestion方法，这样鼠标就点击不到对应的suggestion项，无法执行search方法进行搜索
	$("#input_search").removeAttr("onblur");
}

function mouseOutEvent(x) {
	x.className = "mouseOut"; //将样式恢复原样
	$("#input_search").attr("onblur", "hiddenSuggestion()");
}

function move(x) {
	if(x.keyCode == 13) { //按回车，则执行搜索操作
		search();
	} else if(x.keyCode == 40 && index == 0) { //若第一次按下键，则选中第一个suggestion项，并更新索引值
		var li0 = document.getElementById("li0");
		mouseOverEvent(li0);
		index = 1;
	} else if(x.keyCode == 40 && index == suggestionLength) { //若在选中最后一个suggestion项时按下键，则选中第一个suggestion项，并更新索引值
		var li0 = document.getElementById("li0");
		mouseOverEvent(li0);
		var li = document.getElementById("li" + (suggestionLength - 1));
		mouseOutEvent(li);
		index = 1;
	} else if(x.keyCode == 38 && index == 1) { //若在选中第一个suggestion项时按上键，则选中最后一个suggestion项，并更新索引值
		var li = document.getElementById("li" + (suggestionLength - 1));
		mouseOverEvent(li);
		var li2 = document.getElementById("li0");
		mouseOutEvent(li2);
		index = suggestionLength;
	} else if(x.keyCode == 38) { //按上键的普通情况
		var li2 = document.getElementById("li" + (index - 1));
		index--;
		var li = document.getElementById("li" + (index - 1));
		mouseOverEvent(li);
		mouseOutEvent(li2);
	} else if(x.keyCode == 40) { //按下键的普通情况
		var li2 = document.getElementById("li" + (index - 1));
		index++;
		var li = document.getElementById("li" + (index - 1));
		mouseOverEvent(li);
		mouseOutEvent(li2);
	}
}

//注意要先把输入框中的内容转码，防止出现#截断符号使其后内容被忽略的情况
function search() {
	hiddenSuggestion();
	var value_search = encodeURIComponent($.trim($("#input_search").val()));
	window.open("https://www.baidu.com/s?wd=" + value_search);
}
//搜索建议结束

//浏览器兼容性提示
function browertest(win) {
	var theUA = win.navigator.userAgent.toLowerCase();
	if((theUA.match(/msie\s\d+/) && theUA.match(/msie\s\d+/)[0]) || (theUA.match(/trident\s?\d+/) && theUA.match(/trident\s?\d+/)[0])) {
		var ieVersion = theUA.match(/msie\s\d+/)[0].match(/\d+/)[0] || theUA.match(/trident\s?\d+/)[0];
		if(ieVersion < 9) {
			var str = "您的浏览器版本过于古老";
			var str2 = "推荐使用:<a href='https://browser.360.cn/ee/' style='color:blue;'>360极速浏览器</a>或者" +
				"<a href='https://www.firefox.com.cn/' style='color:blue;'>火狐浏览器</a>,";
			document.writeln("<pre style='text-align:center;color:#fff;background-color:#0cc; height:100%;border:0;position:fixed;top:0;left:0;width:100%;z-index:1234'>" +
				"<h2 style='padding-top:200px;margin:0'><strong>" + str + "<br/></strong></h2><h2>" +
				str2 + "</h2><h2 style='margin:0'><strong>如果你使用的是双核浏览器,请切换到极速模式访问<br/></strong></h2></pre>");
			document.execCommand("Stop");
		};
	}
}
browertest(window);
//浏览器兼容性提示结束

//返回顶部
$(function() {
	var backButton = $('.back_to_top');

	function backToTop() {
		$('html,body').animate({
			scrollTop: 0
		}, 800);
	}
	backButton.on('click', backToTop);
	$(window).on('scroll', function() { /*当滚动条的垂直位置大于浏览器所能看到的页面的那部分的高度时，回到顶部按钮就显示 */
		if($(window).scrollTop() > $(window).height())
			backButton.fadeIn();
		else
			backButton.fadeOut();
	});
	$(window).trigger('scroll'); /*触发滚动事件，避免刷新的时候显示回到顶部按钮*/
}());
//返回顶部结束
