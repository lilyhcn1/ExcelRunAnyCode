#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("aria2c")
s :=""

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%_加水印.%ext%


}


runstr = %exe% --dir %A_Desktop%   %param%

run,%runstr%, , Min