#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%


BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")



;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;msgbox % fv


;读取api的结果
ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; 高精度识别
ret:=ocr.GetOcr("D:\老黄牛小工具\ExcelQuery\temp\temp.jpg","general_basic")							; 普通精度识别




;构造excel需要的数组
arr2 := []
temparr :=[]
;newr := returnfirstvalue(r["pois"]["0"])
newr :=ret

arr2["script"] := "ahk"
arr2["w"] := "all"

for k,v in JSON.Load(ret).words_result{
  temparr[k] := v.words
}
arr2["contents"] := temparr


;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\老黄牛小工具\ExcelQuery\temp\temp.json
;run,d:\老黄牛小工具\ExcelQuery\temp\temp.json

























