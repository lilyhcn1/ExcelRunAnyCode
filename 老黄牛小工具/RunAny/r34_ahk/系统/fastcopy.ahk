#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%
exe := checkandgetpath("fastcopy")

exestr = %exe%
run,%exestr%



