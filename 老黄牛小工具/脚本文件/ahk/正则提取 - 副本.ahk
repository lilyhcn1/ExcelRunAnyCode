#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")

;msgbox, %txt%
Haystack := "PO0129005/һ��ó��"
;reg :="^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
reg :="PO[0-9]+"

FoundPos := RegExMatch(Haystack, reg, Match)
;msgbox, %Match%

;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" Match)


;savearr2json(temparr)



















