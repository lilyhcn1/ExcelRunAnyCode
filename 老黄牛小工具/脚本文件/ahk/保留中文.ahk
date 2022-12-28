#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;获取json中的值，可取二维的
txt :=getjsonkey("now_val")


Haystack := txt
reg :="[^\u4e00-\u9fa5]+"
FoundPos := RegExMatch(Haystack, reg, Match)
MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;写入值到当前单元格
writeexcelcell("'" Match)


;savearr2json(temparr)



















