#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%
tr(暂时只能打印office软件。)
Loop, %0%
{
    param := %A_Index%
    inputpath := param

    Runwait, print "%inputpath%"

}

