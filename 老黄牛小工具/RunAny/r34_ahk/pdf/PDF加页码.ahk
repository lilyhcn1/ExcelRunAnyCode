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
    outputpath =  %dir%\%name_no_ext%_加页码.%ext%
    watermark = %dir%\watermark.pdf
    ;startstr(runstr)  ;临时打印出字符串

    
    runstr = %exe% -bottom 10 -font Courier -add-text "`%Page"  "%inputpath%" -o "%outputpath%"  
    ;startstr(runstr)
    runwait,%runstr%, , Min
    
    ;cpdf -topleft 10 -font Courier -add-text "Page %Page" in.pdf -o out.pdf
}


