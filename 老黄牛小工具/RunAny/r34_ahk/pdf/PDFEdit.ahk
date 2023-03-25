#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("PDFEdit")
s :=""

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%_提取.%ext%
    ;startstr(runstr)  ;临时打印出字符串

}

runstr = %exe% %inputpath%
run,%runstr%, , Min
