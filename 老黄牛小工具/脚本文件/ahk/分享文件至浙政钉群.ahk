;��Ⱥ���������ӡ���һ��Ҫ������D:\�ϻ�ţС����\�����ļ�\myconf.ini
#Include %A_LineFile%\..\JSON.ahk
;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := parsed["outputfile"]
if(fv=error)then{
  Loop %0%{  ; ��ȡ���εĳ��ļ���
      GivenPath := %A_Index%  ; ��ȡ��һ�������в���.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
  PathToCopy:=LongPath  
}else{
  PathToCopy :=fv
}


WinShow,������ ahk_class StandardFrame_DingTalkGov
WinActivate,������ ahk_class StandardFrame_DingTalkGov
