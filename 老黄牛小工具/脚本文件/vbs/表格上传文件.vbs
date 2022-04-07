Set oArgs = WScript.Arguments
on error resume next
filepath0=WScript.Arguments(0)
filepath1=WScript.Arguments(1)
filepath2=WScript.Arguments(2)
filepath3=WScript.Arguments(3)
filepath=Trim(filepath0 & " " & filepath1 & " " & filepath2 & " " & filepath3)
dim fso, f
set fso = CreateObject("Scripting.FileSystemObject")
set f = fso.CreateTextFile("D:\老黄牛小工具\ExcelQuery\temp.txt", true) '第二个参数表示目标文件存在时是否覆盖
f.Write(filepath)
f.Close()
set f = nothing
set fso = nothing

if filepath="" then
  msgbox ("请把相应的文件拖到本文件上！~")
else
  set xlapp=getobject(,"excel.application")
  xlapp.run "表格网络上传文件"
end if
