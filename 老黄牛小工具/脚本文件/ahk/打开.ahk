#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


;读取文件
  ;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)
TrayTip, Timed TrayTip, This will be displayed for 5 seconds.
path:=getarrkey(arr,"","now_val")
excelpath :=getarrkey(arr,"","excelpath")  
newpath := getwholepath(path,excelpath) ;获取绝对路径


if (InStr(path, "http")){
  run,%path%
}else{
  if (FileExist(newpath)){
    run,%newpath%
  }else{
  TrayTip, "Error","文件不存在！~"
  }

}


;msgbox,%pathnew%
























