#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------

path = D:\老黄牛小工具\Excel插件\res\主文件.xlsx
newpath =%A_Desktop%\主文件.xlsx
if FileExist(path){
    FileCopy, %path%, %newpath% , 1
    ;startstr(newpath)
    run,%ComSpec% /c %newpath%,, min
}else{
  newpath := checkandgetpath("主文件")
  run,%newpath%
}


