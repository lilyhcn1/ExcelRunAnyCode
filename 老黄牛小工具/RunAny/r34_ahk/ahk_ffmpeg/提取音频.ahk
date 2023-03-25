#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

ffmpeg := checkandgetpath("ffmpeg")
s :=""
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    outputpath :=  StrReplace(inputpath, "mp4", "mp3")
    ;msgbox % inputpath
    exestr = %ffmpeg% -i "%inputpath%" -f mp3 -vn -y "%outputpath%"
    ;startstr(exestr)
    runwait,%exestr%, , Min

    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}



