#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
temparr := []
jikeapi := readini("ApiKeys","jikeapi")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("ISBN")
;-------------1.��ȡ�������----------
if (img1 != ""){  ;��������
  ;��ȡapi�Ľ�� 
  url = https://api.jike.xyz/situ/book/isbn/%img1%?apikey=%jikeapi%

  res := geturlcontent(url)
  ;msgbox % res

  r := JSON.Load(res)
  ;newr=returnfirstvalue2(r)


    ;����excel��Ҫ������
    arr2 := []
    ;newr := returnfirstvalue(r["pois"]["0"])
    newr :=r["data"]

    temparr :=newr
}else{  ;�����Ĵ���
  temparr["ISBN"] :="9787506380263"
  temparr["author"] :="������"
  temparr["authorIntro"] :="������"
  temparr["brand"] :="������"
  temparr["code"] :="������"
  temparr["createTime"] :="������"
  temparr["description"] :="������"
  temparr["designed"] :="������"
  temparr["douban"] :="������"
  temparr["doubanScore"] :="������"
  temparr["froms"] :="������"
  temparr["id"] :="������"
  temparr["localPhotoUrl"] :="������"
  temparr["name"] :="������"
  temparr["num"] :="������"
  temparr["pages"] :="������"
  temparr["photoUrl"] :="������"
  temparr["price"] :="������"
  temparr["published"] :="������"
  temparr["publishing"] :="������"
  temparr["reviews"] :="������"
  temparr["size"] :="������"
  temparr["subname"] :="������"
  temparr["tags"] :="������"
  temparr["translator"] :="������"
  temparr["uptime"] :="������"
  temparr["weight"] :="������"
}


;-------------2.����д�����----------
savearr2json(temparr)




















