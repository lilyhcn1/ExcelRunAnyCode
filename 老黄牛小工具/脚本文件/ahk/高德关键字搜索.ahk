#Include %A_ScriptDir%\JSON.ahk

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
url := "http://restapi.amap.com/v3/place/text?key=26aa795b3f47e3cd309c0fa938d39650&keywords="fv
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;����excel��Ҫ������
arr2 := []
;newr := returnfirstvalue(r["pois"]["0"])
newr :=returnfirstvalue(r["pois"])

arr2["script"] := "ahk"
arr2["w"] := "key"
arr2["content"] := newr

arr2["address"] := newr["address"]
;msgbox % arr2["address"]
arr2["adname"] := newr["adname"]
arr2["cityname"] := newr["cityname"]
arr2["pcode"] := newr["pcode"]
arr2["pname"] := newr["pname"]



;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
;run,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json

























