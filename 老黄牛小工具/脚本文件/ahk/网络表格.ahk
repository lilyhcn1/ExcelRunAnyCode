#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------

path = D:\老黄牛小工具\Excel插件\res\网络表格.xlsx
newpath =%A_Desktop%\网络表格.xlsx
if FileExist(path){
    FileCopy, %path%, %newpath% , 1
    
}else{
  newpath := checkandgetpath("网络表格")
}
run,%ComSpec% /k %newpath%,, min

