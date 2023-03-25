#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("realesrgan")

;InputBox, picsize,  图片缩小工具,    图片的横向尺寸缩小至。, , , , , , , , 1920

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%-清晰大图.%ext%
    ;msgbox % inputpath
    runstr = %exe%  -i "%inputpath%" -o "%outputpath%" -n realesrgan-x4plus
    ;startstr(runstr)
    ;msgbox % exestr
    runwait, %runstr%
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}




