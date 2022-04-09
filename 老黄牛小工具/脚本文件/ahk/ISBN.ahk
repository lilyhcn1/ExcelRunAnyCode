#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
temparr := []
jikeapi := readini("ApiKeys","jikeapi")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("ISBN")
;-------------1.读取输入变量----------
if (img1 != ""){  ;正常运行
  ;读取api的结果 
  url = https://api.jike.xyz/situ/book/isbn/%img1%?apikey=%jikeapi%

  res := geturlcontent(url)
  ;msgbox % res

  r := JSON.Load(res)
  ;newr=returnfirstvalue2(r)


    ;构造excel需要的数组
    arr2 := []
    ;newr := returnfirstvalue(r["pois"]["0"])
    newr :=r["data"]

    temparr :=newr
}else{  ;出错后的处理
  temparr["ISBN"] :="9787506380263"
  temparr["author"] :="待返回"
  temparr["authorIntro"] :="待返回"
  temparr["brand"] :="待返回"
  temparr["code"] :="待返回"
  temparr["createTime"] :="待返回"
  temparr["description"] :="待返回"
  temparr["designed"] :="待返回"
  temparr["douban"] :="待返回"
  temparr["doubanScore"] :="待返回"
  temparr["froms"] :="待返回"
  temparr["id"] :="待返回"
  temparr["localPhotoUrl"] :="待返回"
  temparr["name"] :="待返回"
  temparr["num"] :="待返回"
  temparr["pages"] :="待返回"
  temparr["photoUrl"] :="待返回"
  temparr["price"] :="待返回"
  temparr["published"] :="待返回"
  temparr["publishing"] :="待返回"
  temparr["reviews"] :="待返回"
  temparr["size"] :="待返回"
  temparr["subname"] :="待返回"
  temparr["tags"] :="待返回"
  temparr["translator"] :="待返回"
  temparr["uptime"] :="待返回"
  temparr["weight"] :="待返回"
}


;-------------2.最终写入变量----------
savearr2json(temparr)




















