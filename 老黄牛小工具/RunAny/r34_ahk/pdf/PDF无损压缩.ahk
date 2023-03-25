#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("cpdf")
s :=""
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%_压缩后.%ext%

    ;startstr(runstr)  ;临时打印出字符串

    runstr = %exe% -squeeze   "%inputpath%" -o "%outputpath%"  
    ;startstr(runstr)
    runwait,%runstr%, , Min
    
    ;cpdf in.pdf page -o out.pdf
}


