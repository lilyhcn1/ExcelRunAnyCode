#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------


;��ȡ�ļ�
  ;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)
TrayTip, Timed TrayTip, This will be displayed for 5 seconds.
path:=getarrkey(arr,"","now_val")
excelpath :=getarrkey(arr,"","excelpath")  
newpath := getwholepath(path,excelpath) ;��ȡ����·��


if (InStr(path, "http")){
  run,%path%
}else{
  if (FileExist(newpath)){
    run,%newpath%
  }else{
  TrayTip, "Error","�ļ������ڣ�~"
  }

}


;msgbox,%pathnew%
























