#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
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
  for k,v in JSON.Load(ret).words_result{
    temparr["ʶ����"] := temparr["ʶ����"]  v.words "`n"
  }
}else{  ;�����Ĵ���

    temparr["ͼƬ��ַ"] :="D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg"
    temparr["ʶ����"] :="������"
    temparr["���н��"] :="�ĸ��ط������ˣ���ע�⣡"
}



;-------------2.д�����----------
savearr2json(temparr)






