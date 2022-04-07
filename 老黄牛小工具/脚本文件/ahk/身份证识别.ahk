#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"

url := "http://api1.r34.cc/jb/身份证识别"
fkeyold := "图片路径"   ;旧的文件的标题行名称
fkeynew := ""   ;新的文件的标题行名称

;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
PostCsvAndFile(url,fkeyold,fkeynew)


