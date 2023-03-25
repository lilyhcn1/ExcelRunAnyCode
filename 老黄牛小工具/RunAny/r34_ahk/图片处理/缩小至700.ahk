#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("nconvert")
picsize  := 700

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%.%ext%
    ;msgbox % inputpath
    type =%ext%
    if(type="jpg"){
    	type = "jpeg"
    }
    runstr = %exe%  -quiet -overwrite -out %type% -ratio -resize %picsize%  0 "%inputpath%"
    ;startstr(runstr)
    ;msgbox % exestr
    runwait, %runstr%
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}




