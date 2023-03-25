#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%



Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    newdir = %dir%\%name_no_ext%
    if !FileExist(newdir){
      FileCreateDir, %newdir%
    }
    FileCopy, %inputpath%, %newdir%\%name_no_ext%.%ext% , 1
    filedelete, %inputpath%
}


tr("复制完毕！~")