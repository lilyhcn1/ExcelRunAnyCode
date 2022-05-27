#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := name_no_ext ;脚本的名字等于文件名

fkeyold := ""   ;要发送的旧文件的标题行名称
fkeynew := ""   ;要接收的新文件的标题行名称

temptxt := "d:\老黄牛小工具\ExcelQuery\temp\temp.txt"
jhead := "D:\老黄牛小工具\小工具\jhead\jhead.exe"

filepath := readjsonconkey("文件绝对路径")
FileDelete, temptxt
runstr := "cmd.exe /c " jhead " " filepath " >" temptxt
;msgbox % runstr
RunWait, %runstr%,,min

FileRead, str, %temptxt%

arr:={}

Loop, Parse, str, `n, `r
{
    左右分割符列数 := InStr(A_LoopField, ":")
    ;msgbox % 左右分割符列数
    if (左右分割符列数>0){
      key :=Trim(SubStr(A_LoopField, 1, 左右分割符列数-1))
      ;msgbox % key
      val := Trim(SubStr(A_LoopField, 左右分割符列数+1, StrLen(A_LoopField)))
      ;msgbox % val
      arr[key] := val
    }

}
savearr2json(arr)




