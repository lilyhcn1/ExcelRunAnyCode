#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------


FormatTime, TimeString, ,, M��d�� hh��mm�֡�
txt = ������%TimeString%
spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)