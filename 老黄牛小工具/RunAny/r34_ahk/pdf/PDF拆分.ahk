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
    outputpath =  %dir%\%name_no_ext%_提取.%ext%
    ;startstr(runstr)  ;临时打印出字符串
    InputBox, ch,r34小工具,PDF拆分后，每个的PDF的页数。, , , , , , , , 1
    
    runstr = %exe% -split "%inputpath%" -o "%dir%\%name_no_ext%_`%`%`%.pdf" -chunk %ch%
    ;startstr(runstr)
    runwait,%runstr%, , Min
    
    ;cpdf -split in.pdf -o Chunk%%%.pdf -chunk 10
}


