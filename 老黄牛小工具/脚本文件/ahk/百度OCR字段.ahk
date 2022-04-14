#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("图片地址")
;-------------1.读取输入变量----------
if (img1 != ""){  ;正常运行
    ;读取api的结果
    ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
    ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; 高精度识别
    ret:=ocr.GetOcr(img1,"general_basic")							; 普通精度识别

n := 1
for k,v in JSON.Load(ret).words_result{
kk := "字段" n
;msgbox % kk
temparr[kk] :=  v.words
n := n+1
}
 
  
 
}else{  ;出错后的处理

    temparr["图片地址"] :="D:\老黄牛小工具\ExcelQuery\temp\temp.jpg"
  temparr["字段1"] :="待返回"
  temparr["字段2"] :="待返回"
  temparr["字段3"] :="待返回"
  temparr["字段4"] :="待返回"
  temparr["字段5"] :="待返回"
  temparr["字段6"] :="待返回"
  temparr["字段7"] :="待返回"
  temparr["字段8"] :="待返回"
  temparr["字段9"] :="待返回"
  temparr["字段10"] :="待返回"
  temparr["字段11"] :="待返回"
  temparr["字段12"] :="待返回"
  temparr["字段13"] :="待返回"
  temparr["字段14"] :="待返回"
  temparr["字段15"] :="待返回"
  temparr["字段16"] :="待返回"
  temparr["字段17"] :="待返回"
  temparr["字段18"] :="待返回"
  temparr["字段19"] :="待返回"
  temparr["字段20"] :="待返回"
  temparr["字段21"] :="待返回"
  temparr["字段22"] :="待返回"
  temparr["字段23"] :="待返回"
  temparr["字段24"] :="待返回"
  temparr["字段25"] :="待返回"
  temparr["字段26"] :="待返回"
  temparr["字段27"] :="待返回"
  temparr["字段28"] :="待返回"
  temparr["字段29"] :="待返回"
  temparr["字段30"] :="待返回"
  temparr["运行结果"] :="哪个地方出错了，请注意！"
}



;-------------2.写入变量----------
savearr2json(temparr)






















