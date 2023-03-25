#SingleInstance, Force
;
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

ffmpeg := checkandgetpath("ffmpeg")
s :=""
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    outputts :=  StrReplace(inputpath, "mp4", "ts")
    ;msgbox % inputpath
    exestr = %ffmpeg% -i "%inputpath%"  "%outputpath%"
    ;startstr(exestr)
    ;msgbox % exestr
    
    tempexe = %ffmpeg% -i "%inputpath%"  -y -vcodec copy -acodec copy -vbsf h264_mp4toannexb "%outputts%"
    ;startstr(tempexe)
    runwait,%tempexe%, , Min
    s = %s%file '%outputts%'`n
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}
;msgbox % param
SplitPath, param, name, dir, ext, name_no_ext, drive

outputpath =%dir%\all.mp4

mp4list := "d:\老黄牛小工具\ExcelQuery\temp\mp4list.txt"
writetext(s,mp4list)


exestr = %ffmpeg%  -f concat -safe 0  -i "%mp4list%" -y  -c copy "%outputpath%"
;startstr(exestr)
runwait,%mp4list%
runwait, %exestr%
FileDelete,  %dir%\*.ts
;run, %comspec% /c del %dir%\*.ts

