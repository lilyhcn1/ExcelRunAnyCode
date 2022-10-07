#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"

url := "http://api1.r34.cc/jb/读标题"
fkeyold := ""    ;旧的文件的标题行名称
fkeynew := ""    ;新的文件的标题行名称





;-----------------正式的函数区----------------
;读取文件
FileRead, jsonstr, %tempjsonpath%
;msgbox % jsonstr
parsed := JSON.Load(jsonstr)
;旧的文件路径，通常是文件模板
if(fkeyold <> ""){
	mbpath := parsed["contents"][fkeyold]
}
;新的文件路径，通常是生成的文件，可以是相对路径
if(fkeynew <> ""){   
	nowpath := parsed["excelpath"]
	genfname := parsed["contents"][fkeynew]
	if(FileExist(genfname)){
		newfilepath := genfname 
	}else{
		newfilepath := nowpath  "\"  genfname 
	}
}


;msgbox % newfilepath
;TrayTip,,% newfilepath
;Sleep % 500
;读取文件
if(fkeyold <> ""){
	f64 :=readFile(mbpath)
}else{
	f64 := ""
}
if(fkeynew <> ""){
	nowpath := parsed["excelpath"]
	genfname := parsed["contents"][fkeynew]
	newfilepath := nowpath  "\"  genfname 
}
JsonData := {"json64": readFile(tempjsonpath)
		    , "f64": f64			 
			, "fkeyold": fkeyold
			, "fkeynew": fkeynew			 }
		     
;发送编码后的base64字段
result := getWebPage(url,JsonData)
data := JSON.Load(result)
;jsontemparr := JSON.Load(data.json64)

;将读取到base64字符解码后写入文件
writeBase64File(tempjsonpath,data.json64)

if(fkeynew <> ""){
	writeBase64File(newfilepath,data.f64)
}


;TrayTip,,% "操作完成。"
;-----------------正式的函数区结束----------------

