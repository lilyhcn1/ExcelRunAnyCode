#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

;reg为最后要提取的变量，可以统一输入
arr :=[]
floderpath :="E:\Seafile\私人资料库\"
if !FileExist(floderpath){
  arr["1旧文本"] := "E:\Seafile\私人资料库\"
  arr["2新文本"] := "D:\Seafile\私人资料库\"
  oldstr := arr["1旧文本"]
  newstr := arr["2新文本"]
}else{
  arr["1旧文本"] := "D:\Seafile\私人资料库\"
  arr["2新文本"] := "E:\Seafile\私人资料库\"
  oldstr := arr["1旧文本"]
  newstr := arr["2新文本"]

}


    inputpath := "D:\老黄牛小工具\RunAny\RunAny.ini"
    outputpath :=  inputpath
    ;msgbox, %outputpath%
    txt := readtext(inputpath)
    newtxt := StrReplace(txt, oldstr, newstr)
    writetextgbk(newtxt,outputpath)

tr("替换完毕")