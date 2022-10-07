#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"


;-----------------正式的函数区----------------
url := "http://api1.r34.cc/jb/百度查快递"

;读取文件
JsonData := {"json64": readFile(tempjsonpath)
		     , "docx64": "nothing"			 }
		     
;发送编码后的base64字段
result := getWebPage(url,JsonData)
data := JSON.Load(result)
;jsontemparr := JSON.Load(data.json64)


;将读取到base64字符解码后写入文件
writeBase64File(tempjsonpath,data.json64)

;writeBase64File("mb2.docx",data.docx64)

;MsgBox Finish...

