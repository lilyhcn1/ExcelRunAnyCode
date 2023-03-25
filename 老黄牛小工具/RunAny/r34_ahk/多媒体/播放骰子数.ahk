#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


Random, rand, 1, 6
txt = 骰子是 %rand% 点，repeat,骰子是 %rand% 点!~
spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)