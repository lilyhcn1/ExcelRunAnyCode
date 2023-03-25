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
    InputBox, page,r34小工具,提取格式，1-2，6（英文逗号）。
    ;一定要加双引号，要不文件夹有空格就会出错
    
    runstr = %exe%  "%inputpath%" %page% -o "%outputpath%"
    ;startstr(runstr)
    runwait,%runstr%, , Min
    
    ;cpdf in.pdf page -o out.pdf
}


