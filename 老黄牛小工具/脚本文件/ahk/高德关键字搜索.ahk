#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []
gdapi := readini("ApiKeys","gdapi")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("地址文本")
;-------------1.读取输入变量----------
if (img1 != ""){  ;正常运行
;读取api的结果
url := "http://restapi.amap.com/v3/place/text?key=" gdapi "&keywords=" img1
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;构造excel需要的数组

;newr := returnfirstvalue(r["pois"]["0"])
newr :=returnfirstvalue(r["pois"])
arr2["地址"] := newr["address"]
;msgbox % arr2["address"]
arr2["区"] := newr["adname"]
arr2["市"] := newr["cityname"]
arr2["省"] := newr["pname"]
arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["地址文本"] :="杭州市滨江区网商路699号"
    arr2["地址"] := "待返回"
    ;msgbox % arr2["address"]
    arr2["区"] := "待返回"
    arr2["市"] := "待返回"
    arr2["省"] := "待返回"
    arr2["运行结果"] :="哪个地方出错了，请注意！"
}


;-------------2.最终写入变量----------
savearr2json(arr2)





















