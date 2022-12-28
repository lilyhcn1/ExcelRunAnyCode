#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;获取json中的值，可取二维的
txt :=getjsonkey("now_val")

;msgbox, %txt%
Haystack := "PO0129005/一般贸易"
;reg :="^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
reg :="PO[0-9]+"

FoundPos := RegExMatch(Haystack, reg, Match)
;msgbox, %Match%

;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;写入值到当前单元格
writeexcelcell("'" Match)


;savearr2json(temparr)



















