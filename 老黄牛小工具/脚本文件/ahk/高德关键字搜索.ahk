#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []
gdapi := readini("ApiKeys","gdapi")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("��ַ�ı�")
;-------------1.��ȡ�������----------
if (img1 != ""){  ;��������
;��ȡapi�Ľ��
url := "http://restapi.amap.com/v3/place/text?key=" gdapi "&keywords=" img1
;msgbox % url
res := geturlcontent(url)
r := JSON.Load(res)
;newr=returnfirstvalue2(r)


;����excel��Ҫ������

;newr := returnfirstvalue(r["pois"]["0"])
newr :=returnfirstvalue(r["pois"])
arr2["��ַ"] := newr["address"]
;msgbox % arr2["address"]
arr2["��"] := newr["adname"]
arr2["��"] := newr["cityname"]
arr2["ʡ"] := newr["pname"]
arr2["���н��"] :="��"

}else{  ;�����Ĵ���
    arr2["��ַ�ı�"] :="�����б���������·699��"
    arr2["��ַ"] := "������"
    ;msgbox % arr2["address"]
    arr2["��"] := "������"
    arr2["��"] := "������"
    arr2["ʡ"] := "������"
    arr2["���н��"] :="�ĸ��ط������ˣ���ע�⣡"
}


;-------------2.����д�����----------
savearr2json(arr2)





















