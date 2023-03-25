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
    outputpath =  %dir%\%name_no_ext%_提取视频.%ext%
;msgbox % param
InputBox, st,开始时间,时间样式为XX:XX:XX。, , , , , , , , 00:00:05
InputBox, lt,持继时间,直接输入秒数。, , , , , , , , 10


    tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
    ; tempexe = %ffmpeg%  -ss %st% -i input.mp4 -t %lt% -c:v copy -c:a copy output.mp4

    ;startstr(tempexe)
    runwait,%tempexe%, , Min
    
}
run,%outputpath%


