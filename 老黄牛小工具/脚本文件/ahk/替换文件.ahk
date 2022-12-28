#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="微信名"
input2 := "发送文本"
input3 := "发送文件"
info := "运行结果"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
;-------------1.读取输入变量----------
if (val1 != "" ){  ;正常运行

main()
arr2[info] :="√"

}else{  ;出错后的处理
    arr2[input1] := "老黄牛"
    arr2[input2] := "要发送的文本"
    arr2[input3] := "D:\老黄牛小工具\ExcelQuery\temp\temp.json"    
    
    arr2[info] := "标题行找不到关键词【" input1 "】或为空，请检查。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(){
;------------------------
;引入变量
global val1,val2,val3
;-----------引用变量-------------

FileToClipboard(val3)
WinShow,微信 ahk_class WeChatMainWndForPC
WinActivate,微信 ahk_class WeChatMainWndForPC
Sleep,300
Send ^f
Sleep,200
Send {text} %val1%
Sleep,1500
OutputDebug, "找到"
Send {Enter}
OutputDebug, "进入"
Sleep 1000
OutputDebug,  "粘贴"
Send ^v
Sleep 1000
Send {Enter}
Sleep 2000
SendInput % "{TEXT}" . val2
Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 100
Send {Enter}

}

 
GetFullPath(fpath)
{
 Loop, %fpath%
  Return, A_LoopFileLongPath
}



