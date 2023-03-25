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
    outputpath =  %dir%\%name_no_ext%.%ext%
    ;startstr(runstr)  ;临时打印出字符串
    
    ;一定要加双引号，要不文件夹有空格就会出错
    
    ;runstr = %exe% -i "%inputpath%"  -y -vcodec copy -acodec copy -vbsf h264_mp4toannexb "%outputts%"
    ;runwait,%tempexe%, , Min
    s = %s%"%inputpath%"`n
    ;cpdf -merge in.pdf in2.pdf -o out.pdf
}

SplitPath, param, name, dir, ext, name_no_ext, drive

outputpath =%dir%\合并.%ext%

;这里是文件列表
mp4list := "d:\老黄牛小工具\ExcelQuery\temp\mp4list.txt"
msgbox , 请编辑文件列表，每行一个。
writetext(s,mp4list)
runwait, %mp4list%
s := utf8readtext(mp4list)
snew := StrReplace(s, "`r`n", " ")


runstr = %exe% -merge %snew% -o  "%outputpath%"
;startstr(runstr)
;runwait,%mp4list%
runwait, %runstr%
;FileDelete,  %dir%\*.ts
;run, %comspec% /c del %dir%\*.ts

