#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("ffmpeg")
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
FileCopy, %inputpath%, %fd3%\lilyfun.ahk , 1


arr :=[]
arr["1旧文本"] := "要输入要被替换的文本。"
arr["2新文本"] := "请输入要新的文本。"
arr :=arrupdatefromini(arr)
oldstr := arr["1旧文本"]
newstr := arr["2新文本"]
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath :=  inputpath
    ;msgbox, %outputpath%
    txt := readtext(inputpath)
    newtxt := StrReplace(txt, oldstr, newstr)
    writetext(newtxt,outputpath)
}
tr("替换完毕")