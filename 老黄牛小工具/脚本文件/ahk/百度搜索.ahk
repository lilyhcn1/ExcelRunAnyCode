#Include %A_ScriptDir%\JSON.ahk

; �������ҵ�����ĵ�һ��ֵ
returnfirstvalue(ByRef arr){
  For index, value in arr{
      ;MsgBox % "Item " index " is '" arr[index] "'"
      fv := arr[index]
      break
  }
  return fv
}

; �������ҵ�����ĵ�һ��ֵ
returnexcelpath(ByRef arr){
  fv = %A_ScriptDir%
  For index, value in arr{
      if(index ="excelpath"){
        fv := arr[index]
        break
      }
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
path := parsed["now_val"]

run,https://www.baidu.com/s?wd=%path%


;msgbox,%pathnew%
























