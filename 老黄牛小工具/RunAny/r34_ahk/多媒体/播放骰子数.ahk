#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------


Random, rand, 1, 6
txt = ������ %rand% �㣬repeat,������ %rand% ��!~
spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)