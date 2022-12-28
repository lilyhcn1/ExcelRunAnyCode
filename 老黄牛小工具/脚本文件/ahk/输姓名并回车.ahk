#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("姓名")
txt2 := "无"
;-------------1.读取输入变量----------
if (txt1 != "" and txt2 !="" ){  ;正常运行


main(txt1,txt2)
arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["姓名"] := "老黄牛"
    ;arr2["发送文本"] := "要发送的文本"
    arr2["运行结果"] :="标题行找不到关键词，请注意。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(ByRef 参数01,ByRef 参数11 :=""){
;------------------------
;引入变量
global txt1,txt2
;-----------引用变量-------------

;---------------- 参数01 -----------------
if (flag <> 1) {
  msgbox % "请先选好操作界面，点击“确认”后，3秒后进行操作。"
  TrayTip,,% "请3秒内将光标移动到指定搜索框。"
  Sleep % 2000
  flag := 1
}
;点击并删除原有数据
Click %x1%, %y1%, 1
Sleep % 500
;输入姓名
SendInput % "{TEXT}" . 参数01
Sleep % 4000
;输入回车
Send, {Enter}
Sleep % 500
}




