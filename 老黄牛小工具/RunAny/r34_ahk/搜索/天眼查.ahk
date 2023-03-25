#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%



Loop, %0%
{
    param := %A_Index%
    inputpath := param
    outputts :=  StrReplace(inputpath, "mp4", "ts")
    ;msgbox % inputpath
}


run, https://www.tianyancha.com/search?key=%param%