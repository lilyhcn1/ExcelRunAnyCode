#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------


;��ȡ�ļ�
  ;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)

txt:=getarrkey(arr,"now_val")
path := getwholepath(txt)
if FileExist(path) && txt !=""{
  SoundPlay, %path% , Wait
}else{
  msgbox,Ҫ���ŵ��ļ������ڣ�����·���Ƿ���ȷ��
}

