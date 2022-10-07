#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;获取json中的值，可取二维的
txt :=getjsonkey("now_val")


Haystack := txt
reg :="[^a-zA-Z0-9]"

txt := RegExReplace(Haystack, reg, "")


;写入值到当前单元格
writeexcelcell("'" txt)


;savearr2json(temparr)






























