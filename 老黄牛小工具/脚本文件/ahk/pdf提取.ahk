#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%

jbname := "pdf提取" ;脚本的名字
fkeyold := "pdf地址"   ;旧的文件的标题行名称
fkeynew := "pdf提取到"   ;新的文件的标题行名称

;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
apiserver := getserverurl()
url := apiserver "/jb/" jbname
PostCsvAndFile(url,fkeyold,fkeynew)




