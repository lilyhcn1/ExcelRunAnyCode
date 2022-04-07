#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"


;-----------------正式的函数区----------------
url := "http://api1.r34.cc/jb2/语音识别"




;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
mbpath := parsed["contents"]["文件地址"]

;msgbox % newfilepath
TrayTip,,% newfilepath
;Sleep % 500
;读取文件
JsonData := {"json64": readFile(tempjsonpath)
		     , "fkey": "文件地址"			 
		     , "f64": readFile(mbpath)						 }
		     
;发送编码后的base64字段
result := getWebPage(url,JsonData)
data := JSON.Load(result)
;jsontemparr := JSON.Load(data.json64)


;将读取到base64字符解码后写入文件
writeBase64File(tempjsonpath,data.json64)

;writeBase64File(newfilepath,data.docx64)

TrayTip,,% "操作完成。"


