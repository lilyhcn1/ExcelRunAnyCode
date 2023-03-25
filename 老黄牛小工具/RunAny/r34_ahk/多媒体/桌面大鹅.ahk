#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("桌面大鹅")
s :=""
runstr = %exe%
run,%runstr%