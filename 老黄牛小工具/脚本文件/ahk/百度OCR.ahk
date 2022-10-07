#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

try{
  ;读取文件
  FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  ;fv := returnfirstvalue(parsed["contents"])
  ;msgbox % fv

  
  ;读取api的结果
  ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
  ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; 高精度识别
  ret:=ocr.GetOcr("D:\老黄牛小工具\ExcelQuery\temp\temp.jpg","general_basic")							; 普通精度识别





}catch{
  temparr["运行结果"] :="哪个地方出错了，请注意！"
}


for k,v in JSON.Load(ret).words_result{
  temparr["识别结果"] := temparr["识别结果"]  v.words "`n"
}


savearr2json(temparr)

























