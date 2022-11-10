fd :="D:\老黄牛小工具\代码生成器的应用\[简单免安装]本地网址导航及安装过程\相关文件\本地文件协议安装"

FileCopy, %A_WorkingDir%\手动安装\start.exe, %fd%\start.exe
FileCreateDir %fd%
run,%A_WorkingDir%\手动安装\浏览器协议.reg

;if FileExist(%fd%"\start.exe"){
;    MsgBox, At least one .txt file exists.
;}else{
;    MsgBox, error
;}

sleep 5000

msgbox,% "安装完成~"