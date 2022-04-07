#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%


BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")



;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := returnfirstvalue(parsed["contents"])
;msgbox % fv


;��ȡapi�Ľ��
ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; �߾���ʶ��
ret:=ocr.GetOcr("D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg","general_basic")							; ��ͨ����ʶ��




;����excel��Ҫ������
arr2 := []
temparr :=[]
;newr := returnfirstvalue(r["pois"]["0"])
newr :=ret

arr2["script"] := "ahk"
arr2["w"] := "all"

for k,v in JSON.Load(ret).words_result{
  temparr[k] := v.words
}
arr2["contents"] := temparr


;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
;msgbox % arr2["w"]
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
;run,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json

























