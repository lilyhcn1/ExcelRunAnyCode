#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("曾大大按键软件")
s :=""
runstr = %exe%
run,%runstr%