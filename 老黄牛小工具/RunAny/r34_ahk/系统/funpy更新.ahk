#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%



Loop, %0%
{
    param := %A_Index%
    inputpath := param

}


tempfd :="D:\老黄牛小工具\ExcelQuery\temp"
fd1 := "D:\server_run\fastapi"
fd2 := "D:\老黄牛小工具\脚本文件\py"
;fd3 := "D:\老黄牛小工具\RunAny\r34_ahk\截图识别（自建识别）\Lib"

FileCopy, %inputpath%, %fd1%\lilyfun.py , 1
FileCopy, %inputpath%, %fd2%\lilyfun.py , 1
;FileCopy, %inputpath%, %fd3%\lilyfun.ahk , 1
tr("更新完毕，请检查")