#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


;读取文件
  ;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)

txt:=getarrkey(arr,"","now_val")


spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)



;msgbox,%pathnew%
