#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------


;��ȡ�ļ�
  ;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)
;TrayTip, Timed TrayTip, This will be displayed for 5 seconds.
txt:=getarrkey(arr,"","now_val")


spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)



;msgbox,%pathnew%
