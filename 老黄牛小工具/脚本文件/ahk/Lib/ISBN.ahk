#Include %A_LineFile%\..\JSON.ahk
apikey := ""



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
fv := returnfirstvalue(parsed["contents"])     ;�����ȡcontent�����ݣ��Զ���ľ���content,������ahk���һ��ֵ
;msgbox % fv


      if(apikey = ""){
        msgbox,"��������api������ISBN.ahk"
        run,https://jike.xyz/api/isbn.html
        Exit 
      }

;��ȡapi�Ľ�� 
url = https://api.jike.xyz/situ/book/isbn/%fv%?apikey=%apikey%

res := geturlcontent(url)
;msgbox % res
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp2.json
FileAppend,%res%,d:\�ϻ�ţС����\ExcelQuery\temp\temp2.json
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;����excel��Ҫ������
arr2 := []
;newr := returnfirstvalue(r["pois"]["0"])
newr :=r["data"]

arr2["script"] := "ahk"
arr2["w"] := "all"    ;allʱ�����м�ֵ��д�룬keyʱ����ֵд��
arr2["content"] := newr




;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
;run,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json

;�����������ƣ�ǿ�Ƶ�3��
sleep 3000


























