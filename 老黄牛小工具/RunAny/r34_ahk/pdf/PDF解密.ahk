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
    outputpath =  %dir%\%name_no_ext%_解密.%ext%
    ;startstr(runstr)  ;临时打印出字符串
    InputBox, psword, r34小工具, 请输入密码。
    ;一定要加双引号，要不文件夹有空格就会出错
    
    runstr = %exe% -decrypt "%inputpath%"  owner=%psword% -o "%outputpath%"
    ;startstr(runstr)
    runwait,%runstr%, , Min
    
    ;cpdf -decrypt in.pdf owner=fred -o out.pdf
}


