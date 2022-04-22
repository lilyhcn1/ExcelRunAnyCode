#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

try{
  ;¶ÁÈ¡ÎÄ¼þ
  FileRead, jsonstr, d:\ÀÏ»ÆÅ£Ð¡¹¤¾ß\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  ;fv := returnfirstvalue(parsed["contents"])
  ;msgbox % fv

  
  ;¶ÁÈ¡apiµÄ½á¹û
  ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
  ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; ¸ß¾«¶ÈÊ¶±ð
  ret:=ocr.GetOcr("D:\ÀÏ»ÆÅ£Ð¡¹¤¾ß\ExcelQuery\temp\temp.jpg","general_basic")							; ÆÕÍ¨¾«¶ÈÊ¶±ð





}catch{
  temparr["×Ö¶Î01"] :="´ý·µ»Ø"
  temparr["×Ö¶Î02"] :="´ý·µ»Ø"
  temparr["×Ö¶Î03"] :="´ý·µ»Ø"
  temparr["×Ö¶Î04"] :="´ý·µ»Ø"
  temparr["×Ö¶Î05"] :="´ý·µ»Ø"
  temparr["×Ö¶Î06"] :="´ý·µ»Ø"
  temparr["×Ö¶Î07"] :="´ý·µ»Ø"
  temparr["×Ö¶Î08"] :="´ý·µ»Ø"
  temparr["×Ö¶Î09"] :="´ý·µ»Ø"
  temparr["×Ö¶Î10"] :="´ý·µ»Ø"
  temparr["×Ö¶Î10"] :="´ý·µ»Ø"
  temparr["×Ö¶Î11"] :="´ý·µ»Ø"
  temparr["×Ö¶Î12"] :="´ý·µ»Ø"
  temparr["×Ö¶Î13"] :="´ý·µ»Ø"
  temparr["×Ö¶Î14"] :="´ý·µ»Ø"
  temparr["×Ö¶Î15"] :="´ý·µ»Ø"
  temparr["×Ö¶Î16"] :="´ý·µ»Ø"
  temparr["×Ö¶Î17"] :="´ý·µ»Ø"
  temparr["×Ö¶Î18"] :="´ý·µ»Ø"
  temparr["×Ö¶Î19"] :="´ý·µ»Ø"
  temparr["×Ö¶Î20"] :="´ý·µ»Ø"
  temparr["×Ö¶Î21"] :="´ý·µ»Ø"
  temparr["×Ö¶Î22"] :="´ý·µ»Ø"
  temparr["×Ö¶Î23"] :="´ý·µ»Ø"
  temparr["×Ö¶Î24"] :="´ý·µ»Ø"
  temparr["×Ö¶Î25"] :="´ý·µ»Ø"
  temparr["×Ö¶Î26"] :="´ý·µ»Ø"
  temparr["×Ö¶Î27"] :="´ý·µ»Ø"
  temparr["×Ö¶Î28"] :="´ý·µ»Ø"
  temparr["×Ö¶Î29"] :="´ý·µ»Ø"
  temparr["×Ö¶Î30"] :="´ý·µ»Ø"
  temparr["ÔËÐÐ½á¹û"] :="ÄÄ¸öµØ·½³ö´íÁË£¬Çë×¢Òâ£¡"
}

n := 1
for k,v in JSON.Load(ret).words_result{
kk := "×Ö¶Î" n
;msgbox % kk
temparr[kk] :=  v.words
n := n+1
}


savearr2json(temparr)

























