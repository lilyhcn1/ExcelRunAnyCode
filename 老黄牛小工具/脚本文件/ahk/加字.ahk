#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := name_no_ext ;�ű������ֵ����ļ���

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")


txt := txt "," jbname
;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" txt)


;savearr2json(temparr)



















