#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
temparr := []
tianapiaddressparse := readini("ApiKeys","tianapiaddressparse")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("��ַ�ı�")
;-------------1.��ȡ�������----------
if (img1 != ""){  ;��������
  ;��ȡapi�Ľ��
  url := "http://api.tianapi.com/txapi/addressparse/index?key=" tianapiaddressparse "&text="img1
  ;msgbox % url
  res := geturlcontent(url)
  r := JSON.Load(res)
  ;newr=returnfirstvalue2(r)


  ;����excel��Ҫ������
  arr2 := []
  newr := returnfirstvalue(r["newslist"])
  temparr :=newr
}else{  ;�����Ĵ���

    temparr["��ַ�ı�"] :="����13800138000�����б���������·699��310052"
    temparr["mobile"] :="������"
    temparr["name"] :="������"
    temparr["province"] :="������"
    temparr["city"] :="������"
    temparr["district"] :="������"
    temparr["postcode"] :="������"
    temparr["detail"] :="������"
    temparr["���н��"] :="�ĸ��ط������ˣ���ע�⣡"
}


;-------------2.����д�����----------
savearr2json(temparr)




















