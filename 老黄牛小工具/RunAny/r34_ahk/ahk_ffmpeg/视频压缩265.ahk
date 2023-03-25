#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

ffmpeg := checkandgetpath("ffmpeg")
s :=""
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%压缩后.%ext%
    ;msgbox % inputpath -i 11.mp4 -c:v libx265 -crf 23 -c:a aac -b:a 224k -y out.mp4
    exestr = %ffmpeg% -i "%inputpath%" -c:v libx265 -crf 23 -c:a aac -b:a 224k -y "%outputpath%"
    ;startstr(exestr)
    runwait,%exestr%

    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}

