#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := name_no_ext ;脚本的名字等于文件名

fkeyold := ""   ;要发送的旧文件的标题行名称
fkeynew := "声音文件名"   ;要接收的新文件的标题行名称

;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
#apiserver := getserverurl()
apiserver := "http://192.168.7.102:8001"
url := apiserver "/jb/" jbname
PostCsvAndFile(url,fkeyold,fkeynew)

