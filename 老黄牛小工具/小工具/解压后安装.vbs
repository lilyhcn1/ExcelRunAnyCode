On error resume Next
IniPath = "D:\老黄牛小工具\配置文件\myconf.ini"
DstPATH = "老黄牛小工具\配置文件\myconf.ini"

set fs = CreateObject("Scripting.FileSystemObject")

rem 备份配置文件
if(fs.fileExists(inipath)) Then 
	rem MsgBox(IniPath & "存在！inipath")
	fs.CopyFile inipath,DstPATH,True
end if


rem 安装老黄牛小工具
if(fs.FolderExists("老黄牛小工具")) Then 
	fso.CopyFolder "老黄牛小工具","e:\老黄牛小工具"
	if(fs.fileExists("D:\老黄牛小工具\小工具\AutoHotkey.exe")) Then 
        MsgBox("老黄牛小工具安装完毕！~")
	end if 
else
    MsgBox("【老黄牛小工具】不存在，请检查！~")

end if
set fs = Nothing
