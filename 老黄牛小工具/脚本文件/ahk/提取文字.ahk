#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;获取json中的值，可取二维的
txt :=getjsonkey("now_val")

;msgbox, %txt%
Haystack := txt
;Haystack := "PO0129005/一般贸易"
;reg :="^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
;reg :="PO[0-9]+"

;reg为最后要提取的变量，可以统一输入
arr :=[]
arr["前部"] := "要搜索的文字的前面部分（结果不包括在内，30秒内免再输入）"
arr["后部"] := "后面部分（结果不包括在内，30秒内免再输入）"
arr :=arrupdatefromini(arr)
reg := arr["前部"]".*"arr["后部"]


FoundPos := RegExMatch(Haystack, reg, Match)
Match := StrReplace(Match, arr["前部"], "")
Match := StrReplace(Match, arr["后部"], "")

;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;写入值到当前单元格
writeexcelcell("'" Match)


;savearr2json(temparr)



















