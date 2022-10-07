#Include %A_LineFile%\..\JSON.ahk
apikey := ""



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
fv := returnfirstvalue(parsed["contents"])     ;这里读取content的数据，自定义的就是content,并返回ahk或第一个值
;msgbox % fv


      if(apikey = ""){
        msgbox,"请先申请api并填入ISBN.ahk"
        run,https://jike.xyz/api/isbn.html
        Exit 
      }

;读取api的结果 
url = https://api.jike.xyz/situ/book/isbn/%fv%?apikey=%apikey%

res := geturlcontent(url)
;msgbox % res
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp2.json
FileAppend,%res%,d:\老黄牛小工具\ExcelQuery\temp\temp2.json
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;构造excel需要的数组
arr2 := []
;newr := returnfirstvalue(r["pois"]["0"])
newr :=r["data"]

arr2["script"] := "ahk"
arr2["w"] := "all"    ;all时把所有键值都写入，key时按键值写入
arr2["content"] := newr




;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\老黄牛小工具\ExcelQuery\temp\temp.json
;run,d:\老黄牛小工具\ExcelQuery\temp\temp.json

;服务器的限制，强制等3秒
sleep 3000


























