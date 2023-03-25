#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%

ffmpeg := checkandgetpath("ffmpeg")
s :=""
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%_加水印.%ext%
    watermark = %dir%\watermark.pdf
    ;startstr(runstr)  ;临时打印出字符串

    runstr = %exe% -stamp-on  "%watermark%" "%inputpath%" -o "%outputpath%"  
    ;startstr(runstr)
    runwait,%runstr%, , Min

}
;msgbox % param
SplitPath, param, name, dir, ext, name_no_ext, drive

outputpath =%dir%\合并的视频.mp4

mp4list := "d:\老黄牛小工具\ExcelQuery\temp\mp4list.txt"
writetext(s,mp4list)


exestr = %ffmpeg%  -f concat -safe 0  -i "%mp4list%" -y  -c copy "%outputpath%"
;startstr(exestr)
runwait,%mp4list%
runwait, %exestr%
FileDelete,  %dir%\*.ts
;run, %comspec% /c del %dir%\*.ts

