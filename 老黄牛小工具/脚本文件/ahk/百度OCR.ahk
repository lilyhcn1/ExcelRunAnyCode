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
  temparr["���н��"] :="�ĸ��ط������ˣ���ע�⣡"
}


for k,v in JSON.Load(ret).words_result{
  temparr["ʶ����"] := temparr["ʶ����"]  v.words "`n"
}


savearr2json(temparr)

























