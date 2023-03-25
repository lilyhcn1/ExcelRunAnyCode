#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


FormatTime, TimeString, ,, M月d日 hh点mm分。
txt = 现在是%TimeString%
spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)