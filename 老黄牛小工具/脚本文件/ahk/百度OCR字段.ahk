#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("ͼƬ��ַ")
;-------------1.��ȡ�������----------
if (img1 != ""){  ;��������
    ;��ȡapi�Ľ��
    ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
    ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; �߾���ʶ��
    ret:=ocr.GetOcr(img1,"general_basic")							; ��ͨ����ʶ��

n := 1
for k,v in JSON.Load(ret).words_result{
if (n<10){
kk := "�ֶ�0" n
}else{
kk := "�ֶ�" n
}


;msgbox % kk
temparr[kk] :=  v.words
n := n+1
}
 
  
 
}else{  ;�����Ĵ���

    temparr["ͼƬ��ַ"] :="D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg"
  temparr["�ֶ�01"] :="������"
  temparr["�ֶ�02"] :="������"
  temparr["�ֶ�03"] :="������"
  temparr["�ֶ�04"] :="������"
  temparr["�ֶ�05"] :="������"
  temparr["�ֶ�06"] :="������"
  temparr["�ֶ�07"] :="������"
  temparr["�ֶ�08"] :="������"
  temparr["�ֶ�09"] :="������"
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



;-------------2.д�����----------
savearr2json(temparr)






















