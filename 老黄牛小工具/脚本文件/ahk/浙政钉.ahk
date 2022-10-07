#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("钉钉名")
txt2 := readjsonconkey("发送文本")
;-------------1.读取输入变量----------
if (txt1 != "" and txt2 !="" ){  ;正常运行


main(txt1,txt2)
arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["钉钉名"] := "老黄牛"
    arr2["发送文本"] := "要发送的文本"
    arr2["运行结果"] :="标题行找不到关键词，请注意。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(ByRef 参数07,ByRef 参数11 :=""){
;------------------------
;引入变量
global txt1,txt2
;-----------引用变量-------------

CoordMode, Mouse, Screen
if (x1 > 0) {
}else{
  msgbox % "因技术限制，此操作有很多限制条件。`r`n1.开始后不能动鼠标。`r`n2.3秒内将光标移动到钉钉的搜索框。`r`n3.消息不会自动发送，确定后手动回车发送。"
}

TrayTip,,% "请在3秒内将光标移动到搜索框。"
mousemove,x1, y1 
Sleep % 3000
MouseGetPos, x1, y1 
Send, {LButton}
Send, {Backspace 99}
Sleep % 300
SendInput % "{TEXT}" . 参数07
Sleep % 2500
Send, {Enter}
Sleep % 300
Send, {Backspace 99}
Sleep % 300
SendInput % "{TEXT}" . 参数11
Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 5000
;Send, {Enter}

}




