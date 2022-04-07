#Include %A_ScriptDir%\JSON.ahk
#Include %A_ScriptDir%\lilyfunall.ahk

tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"
;读取文件
FileRead, jsonstr, %tempjsonpath%
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;msgbox % fv
TrayTip %fv%, "fv的值"
;读取api的结果
url := "http://restapi.amap.com/v3/place/text?key=26aa795b3f47e3cd309c0fa938d39650&keywords="fv
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;构造excel需要的数组
arr2 := []
conarr:=[]
;newr := returnfirstvalue(r["pois"]["0"])
newr :=returnfirstvalue(r["pois"])

conarr["address"] := newr["address"]
;msgbox % arr2["address"]
conarr["adname"] := newr["adname"]
conarr["cityname"] := newr["cityname"]
conarr["pcode"] := newr["pcode"]
conarr["pname"] := newr["pname"]

arr2["script"] := "ahk"
arr2["w"] := "key"
arr2["content"] := conarr


;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
writetext(stringified,tempjsonpath2)
run,%tempjsonpath2%























