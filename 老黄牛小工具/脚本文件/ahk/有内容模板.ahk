#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------

path = D:\老黄牛小工具\Excel插件\res\主文件.xlsx
newpath =%A_Desktop%\主文件.xlsx
if FileExist(path){
    pathnew := path
    FileCopy, %path%, %newpath% , 1
    run,%newpath%
}else if FileExist(path2){
    pathnew := path2
    run,%pathnew%
}else if FileExist(path3){
    pathnew := path3
    run,%pathnew%

;-------------0.引用函数----------
temparr := []
tianapiaddressparse := readini("ApiKeys","tianapiaddressparse")
;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
img1 := readjsonconkey("地址文本")
;-------------1.读取输入变量----------
if (img1 != ""){  ;正常运行
  ;读取api的结果
  url := "http://api.tianapi.com/txapi/addressparse/index?key=" tianapiaddressparse "&text="img1
  ;msgbox % url
  res := geturlcontent(url)
  r := JSON.Load(res)
  ;newr=returnfirstvalue2(r)


  ;构造excel需要的数组
  arr2 := []
  newr := returnfirstvalue(r["newslist"])
  temparr :=newr
}else{  ;出错后的处理

    temparr["地址文本"] :="马云13800138000杭州市滨江区网商路699号310052"
    temparr["mobile"] :="待返回"
    temparr["name"] :="待返回"
    temparr["province"] :="待返回"
    temparr["city"] :="待返回"
    temparr["district"] :="待返回"
    temparr["postcode"] :="待返回"
    temparr["detail"] :="待返回"
    temparr["运行结果"] :="哪个地方出错了，请注意！"
}


;-------------2.最终写入变量----------
savearr2json(temparr)


ffmpeg := checkandgetpath("ffmpeg")
s :=""
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    outputts :=  StrReplace(inputpath, "mp4", "ts")
    ;msgbox % inputpath
    exestr = %ffmpeg% -i "%inputpath%"  "%outputpath%"
    ;startstr(exestr)
    ;msgbox % exestr
    
    tempexe = %ffmpeg% -i "%inputpath%"  -y -vcodec copy -acodec copy -vbsf h264_mp4toannexb "%outputts%"
    ;startstr(tempexe)
    runwait,%tempexe%, , Min
    s = %s%file '%outputts%'`n
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}
;msgbox % param
SplitPath, param, name, dir, ext, name_no_ext, drive

outputpath =%dir%\合并的视频.mp4

mp4list := "d:\老黄牛小工具\ExcelQuery\temp\mp4list.txt"
writetext(s,mp4list)


exestr = %ffmpeg%  -f concat -safe 0  -i "%mp4list%" -y  -c copy "%outputpath%"
;startstr(exestr)
runwait,%mp4list%
runwait, %exestr%
FileDelete,  %dir%\*.ts
;run, %comspec% /c del %dir%\*.ts

