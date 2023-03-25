#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("nconvert")
picsize  := 1920

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%.png
    ;msgbox % inputpath
    runstr = %exe%  -quiet -overwrite -out png -ratio "%inputpath%"
    ;startstr(runstr)
    ;msgbox % exestr
    runwait, %runstr%, min
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}




