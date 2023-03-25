#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("cpdf")
s :=""
msgbox, 请保证pdf文档所在目录中，有一个watermark.pdf文档。
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%_加水印.%ext%
    watermark = %dir%\watermark.pdf
    ;startstr(runstr)  ;临时打印出字符串

    
    runstr = %exe% -stamp-on  "%watermark%" "%inputpath%" -o "%outputpath%"  
    ;startstr(runstr)
    runwait,%runstr%, , Min
    
    ;cpdf in.pdf page -o out.pdf
}


