#Include %A_ScriptDir%\JSON.ahk

; 函数：找到数组的第一个值
returnfirstvalue(ByRef arr){
  For index, value in arr{
      ;MsgBox % "Item " index " is '" arr[index] "'"
      fv := arr[index]
      break
  }
  return fv
}

; 函数：找到数组的第一个值
returnexcelpath(ByRef arr){
  fv = %A_ScriptDir%
  For index, value in arr{
      if(index ="excelpath"){
        fv := arr[index]
        break
      }
  }

  return fv
}


; 函数：get方式获取返回值
geturlcontent(ByRef url){
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("Get", url, true)
    whr.Send()
    whr.WaitForResponse()
    r := whr.ResponseText
  return r
}



; 函数：get方式获取返回值
readtext(ByRef path){
FileRead, jsonstr, path
  return jsonstr
}


;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
path := parsed["now_val"]
excelpath :=returnexcelpath(parsed)
path2 = %excelpath%\%path%
path3 = %excelpath%\..\%path%
path4 = %excelpath%\生成文件夹\%path%
path5 = %excelpath%\output\%path%
;msgbox,%A_ScriptDir%\..\%path%
;msgbox,%path%

if FileExist(path){
    pathnew := path
}else if FileExist(path2){
    pathnew := path2
}else if FileExist(path3){
    pathnew := path3
}else if FileExist(path4){
    pathnew := path4
}else if FileExist(path5){
    pathnew := path5
}
if FileExist(pathnew){
  run,"D:\老黄牛小工具\脚本文件\vbs\打印wordvbs.vbs " %pathnew%
}

if (InStr(path, "http")){
  run,%path%
}


;msgbox,%pathnew%
























