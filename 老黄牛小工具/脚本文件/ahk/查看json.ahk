#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;FileRead, jsonstr, D:\老黄牛小工具\ExcelQuery\temp\temp.json,utf-8
FileRead, jsonstr, D:\老黄牛小工具\ExcelQuery\temp\temp.json
;msgbox % jsonstr

clipboard := jsonstr
run,https://www.bejson.com/
Sleep % 2000
msgbox % "请在点击确认后2秒内，选中文本框。会自动粘贴文字到窗口。"

Sleep % 2000
Send, ^a
Sleep % 100
Send, {Delete}
Sleep % 100
Send, ^v






















