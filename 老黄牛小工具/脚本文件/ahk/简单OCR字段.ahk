#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

try{
  ;��ȡ�ļ�
  FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  ;fv := returnfirstvalue(parsed["contents"])
  ;msgbox % fv

  
  ;��ȡapi�Ľ��
  ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
  ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; �߾���ʶ��
  ret:=ocr.GetOcr("D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg","general_basic")							; ��ͨ����ʶ��





}catch{
  temparr["�ֶ�1"] :="������"
  temparr["�ֶ�2"] :="������"
  temparr["�ֶ�3"] :="������"
  temparr["�ֶ�4"] :="������"
  temparr["�ֶ�5"] :="������"
  temparr["�ֶ�6"] :="������"
  temparr["�ֶ�7"] :="������"
  temparr["�ֶ�8"] :="������"
  temparr["�ֶ�9"] :="������"
  temparr["�ֶ�10"] :="������"
  temparr["�ֶ�11"] :="������"
  temparr["�ֶ�12"] :="������"
  temparr["�ֶ�13"] :="������"
  temparr["�ֶ�14"] :="������"
  temparr["�ֶ�15"] :="������"
  temparr["�ֶ�16"] :="������"
  temparr["�ֶ�17"] :="������"
  temparr["�ֶ�18"] :="������"
  temparr["�ֶ�19"] :="������"
  temparr["�ֶ�20"] :="������"
  temparr["�ֶ�21"] :="������"
  temparr["�ֶ�22"] :="������"
  temparr["�ֶ�23"] :="������"
  temparr["�ֶ�24"] :="������"
  temparr["�ֶ�25"] :="������"
  temparr["�ֶ�26"] :="������"
  temparr["�ֶ�27"] :="������"
  temparr["�ֶ�28"] :="������"
  temparr["�ֶ�29"] :="������"
  temparr["�ֶ�30"] :="������"
  temparr["���н��"] :="�ĸ��ط������ˣ���ע�⣡"
}

n := 1
for k,v in JSON.Load(ret).words_result{
kk := "�ֶ�" n
;msgbox % kk
temparr[kk] :=  v.words
n := n+1
}


savearr2json(temparr)

























