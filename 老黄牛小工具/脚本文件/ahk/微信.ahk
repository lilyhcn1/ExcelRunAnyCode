#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("微信名")
txt2 := readjsonconkey("发送文本")
;-------------1.读取输入变量----------
if (txt1 != "" and txt2 !="" ){  ;正常运行


main()
arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["微信名"] := "老黄牛"
    arr2["发送文本"] := "要发送的文本"
    arr2["运行结果"] :="标题行找不到关键词，请注意。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(){
;------------------------
;引入变量
global txt1,txt2
;-----------引用变量-------------

WinShow,微信 ahk_class WeChatMainWndForPC
WinActivate,微信 ahk_class WeChatMainWndForPC
Sleep,300
Send ^f
Sleep,200
Send {text} %txt1%

Sleep,1500
Send {Enter}
Sleep 500
SendInput % "{TEXT}" . txt2

Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 5000
;Send {Enter}

}




