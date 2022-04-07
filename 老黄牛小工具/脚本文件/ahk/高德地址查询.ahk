#Include %A_LineFile%\..\JSON.ahk
#Include %A_LineFile%\..\Jxon.ahk
;������ 1 �ӿ���û���� ��2 ��һ��ֵ���ضԲ���
; �������ҵ�����ĵ�һ��ֵ
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

JsonToAHK(json, rec := false) {
   static doc := ComObjCreate("htmlfile")
         , __ := doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
         , JS := doc.parentWindow
   if !rec
      obj := %A_ThisFunc%(JS.eval("(" . json . ")"), true)
   else if !IsObject(json)
      obj := json
   else if JS.Object.prototype.toString.call(json) == "[object Array]" {
      obj := []
      Loop % json.length
         obj.Push( %A_ThisFunc%(json[A_Index - 1], true) )
   }
   else {
      obj := {}
      keys := JS.Object.keys(json)
      Loop % keys.length {
         k := keys[A_Index - 1]
         obj[k] := %A_ThisFunc%(json[k], true)
      }
   }
   Return obj
}


; ������get��ʽ��ȡ����ֵ
geturlcontent(ByRef url){
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("Get", url, true)
    whr.Send()
    whr.WaitForResponse()
    r := whr.ResponseText
  return r
}



; ������get��ʽ��ȡ����ֵ
readtext(ByRef path){
FileRead, jsonstr, path
  return jsonstr
}


;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;msgbox % fv

;��ȡapi�Ľ��
url := "http://api.tianapi.com/txapi/addressparse/index?key=6fc9b18a18857af8ae0619e0ec3de9ee&text="fv
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;����excel��Ҫ������
arr2 := []
newr := returnfirstvalue(r["newslist"])
arr2["script"] := "ahk"
arr2["w"] := "all"
arr2["content"] := newr
;arr2["contentall"] := res

;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
;run,d:\�ϻ�ţС����\ExcelQuery\temp\temp2.json
























