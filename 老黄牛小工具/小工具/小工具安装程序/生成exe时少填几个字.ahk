CoordMode, Mouse, Screen
if (x1 > 0) {
}else{
  msgbox % "请在3秒内将光标移动到搜索框等相应位置，以便于获取鼠标坐标进行第二次操作。"
}
TrayTip,,% "正在进行操作，请不要移动鼠标。"
mousemove,x1, y1 
Sleep % 3000
MouseGetPos, x1, y1 
Send, {LButton}
SendInput % "{TEXT}" . "老黄牛之家"
Sleep % 100
SendInput % "{TEXT}" . "" ;发送空字符，保证不出错
Send, {tab 1}
Sleep % 200
SendInput % "{TEXT}" . "ExcelRunAnyCode"
Sleep % 100
SendInput % "{TEXT}" . "" ;发送空字符，保证不出错
Send, {tab 1}
Sleep % 200
SendInput % "{TEXT}" . "通过表格来调用各种外部程序实现各种各样不同的功能。"
Sleep % 100
SendInput % "{TEXT}" . "" ;发送空字符，保证不出错
Send, {tab 1}
Sleep % 200
Sleep % 3000
msgbox % "请手动点击浏览"
Sleep % 3000
Send, {LButton  }
Sleep % 200
Sleep % 1000
SendInput % "{TEXT}" . "D:\老黄牛小工具\小工具\小工具安装程序\r34.ico"
Sleep % 100
SendInput % "{TEXT}" . "" ;发送空字符，保证不出错
