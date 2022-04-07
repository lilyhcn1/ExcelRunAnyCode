#Include %A_ScriptDir%\JSON.ahk
#Include %A_ScriptDir%\Jxon.ahk
#Include %A_ScriptDir%\lilyfun.ahk



;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;if(fv==""){
;msgbox % fv
;}
;msgbox % fv

;读取api的结果
url := "http://api.tianapi.com/txapi/addressparse/index?key=6fc9b18a18857af8ae0619e0ec3de9ee&text="fv
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;构造excel需要的数组
arr2 := []
newr := returnfirstvalue(r["newslist"])
arr2["script"] := "ahk"
arr2["w"] := "all"
arr2["content"] := newr
;arr2["contentall"] := res

;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\老黄牛小工具\ExcelQuery\temp\temp.json
;run,d:\老黄牛小工具\ExcelQuery\temp\temp.json
























