#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")


Haystack := txt
reg :="[^\u4e00-\u9fa5]+"
FoundPos := RegExMatch(Haystack, reg, Match)
MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" Match)


;savearr2json(temparr)



















