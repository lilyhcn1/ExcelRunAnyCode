#Include %A_ScriptDir%\JSON.ahk
#Include %A_ScriptDir%\lilyfunall.ahk

tempjsonpath := "d:\�ϻ�ţС����\ExcelQuery\temp\temp.json"
tempjsonpath2 := "d:\�ϻ�ţС����\ExcelQuery\temp\temp2.json"
;��ȡ�ļ�
FileRead, jsonstr, %tempjsonpath%
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;msgbox % fv
TrayTip %fv%, "fv��ֵ"
;��ȡapi�Ľ��
url := "http://restapi.amap.com/v3/place/text?key=26aa795b3f47e3cd309c0fa938d39650&keywords="fv
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;����excel��Ҫ������
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


;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
writetext(stringified,tempjsonpath2)
run,%tempjsonpath2%























