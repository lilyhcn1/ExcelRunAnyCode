#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
temparr := []
tianapiaddressparse := readini("ApiKeys","tianapiaddressparse")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("地址文本")
;-------------1.读取输入变量----------
if (img1 != ""){  ;正常运行
  ;读取api的结果
  url := "http://api.tianapi.com/txapi/addressparse/index?key=" tianapiaddressparse "&text="img1
  ;msgbox % url
  res := geturlcontent(url)
  r := JSON.Load(res)
  ;newr=returnfirstvalue2(r)


  ;构造excel需要的数组
  arr2 := []
  newr := returnfirstvalue(r["newslist"])
  temparr :=newr
}else{  ;出错后的处理

    temparr["地址文本"] :="马云13800138000杭州市滨江区网商路699号310052"
    temparr["mobile"] :="待返回"
    temparr["name"] :="待返回"
    temparr["province"] :="待返回"
    temparr["city"] :="待返回"
    temparr["district"] :="待返回"
    temparr["postcode"] :="待返回"
    temparr["detail"] :="待返回"
    temparr["运行结果"] :="哪个地方出错了，请注意！"
}


;-------------2.最终写入变量----------
savearr2json(temparr)




















