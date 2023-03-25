#SingleInstance, Force
;
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

ffmpeg := checkandgetpath("ffmpeg")

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    outputpath :=  StrReplace(inputpath, "mp4", "gif")
    ;msgbox % inputpath
    exestr = %ffmpeg% -i "%inputpath%" -y "%outputpath%"
    ;startstr(exestr)
    ;msgbox % exestr
    runwait, %exestr%
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}



