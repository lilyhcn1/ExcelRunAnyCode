#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------

path = D:\老黄牛小工具\Excel插件\res\简单代码生成器.xlsx
newpath =%A_Desktop%\简单代码生成器.xlsx
if FileExist(path){
    FileCopy, %path%, %newpath% , 1
    ;startstr(newpath)
    run,%ComSpec% /c %newpath%,, min
}else{
  newpath := checkandgetpath("简单代码生成器")
  run,%newpath%
}


