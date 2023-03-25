#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

;reg为最后要提取的变量，可以统一输入
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