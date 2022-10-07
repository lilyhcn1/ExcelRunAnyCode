#Include %A_LineFile%\..\JSON.ahk
;错误检查 1 接口有没申请 ，2 第一个值返回对不对
; 函数：找到数组的第一个值
returnfirstvalue(ByRef arr){
  For index, value in arr{
      ;MsgBox % "Item " index " is '" arr[index] "'"
      if(arr["ask"] <> ""){
        fv := arr["ask"]
      }else{
        fv := arr[index]
      }
      break
  }
  return fv
}


; 函数：get方式获取返回值
geturlcontent(ByRef url){
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("Get", url, true)
    whr.Send()
    whr.WaitForResponse()
    r := whr.ResponseText
  return r
}



; 函数：get方式获取返回值
readtext(ByRef path){
FileRead, jsonstr, path
  return jsonstr
}


;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;msgbox % fv

;读取api的结果
url := "http://api.tianapi.com/txapi/pinyin/index?key=6fc9b18a18857af8ae0619e0ec3de9ee&text="fv
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


;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\老黄牛小工具\ExcelQuery\temp\temp.json

























