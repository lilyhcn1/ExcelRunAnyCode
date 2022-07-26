#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive

jbpath :="D:\老黄牛小工具\脚本文件"

jbname := A_Args[1] ;自动下载脚本专用的，直接传过来

fkeyold := ""   ;要发送的旧文件的标题行名称
fkeynew := ""   ;要接收的新文件的标题行名称
;msgbox % jbname


;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
apiserver := getserverurl()
;这里要改改
;apiserver := "http://192.168.7.38:8001"
url := apiserver "/dl/" jbname
;msgbox % url
  JsonData := {"json64": "" }
           
  ;发送编码后的base64字段
result := getWebPage(url,JsonData)
;writetext(result,"C:\Users\lilyhcn\Desktop\aa.txt")
data2 := JSON.Load(result)
data := JSON.Load(data2)

ahkpath := jbpath "\" data.ext "\" jbname  "." data.ext
;msgbox % ahkpath
writetext(data.f64,ahkpath) 

;PostCsvAndFile(url,fkeyold,fkeynew)

