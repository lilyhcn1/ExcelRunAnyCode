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


if FileExist(path){
    pathnew := path
    run,%pathnew%
}else if FileExist(path2){
    pathnew := path2
    run,%pathnew%
}else if FileExist(path3){
    pathnew := path3
    run,%pathnew%
}else if FileExist(path4){
    pathnew := path4
    run,%pathnew%
}else if FileExist(path5){
    pathnew := path5
    run,%pathnew%
}

;msgbox,%pathnew%
























