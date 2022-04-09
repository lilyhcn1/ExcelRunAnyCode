#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
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
  for k,v in JSON.Load(ret).words_result{
    temparr["识别结果"] := temparr["识别结果"]  v.words "`n"
  }
}else{  ;出错后的处理

    temparr["图片地址"] :="D:\老黄牛小工具\ExcelQuery\temp\temp.jpg"
    temparr["识别结果"] :="待返回"
    temparr["运行结果"] :="哪个地方出错了，请注意！"
}



;-------------2.写入变量----------
savearr2json(temparr)






