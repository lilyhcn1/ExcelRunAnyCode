#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;获取json中的值，可取二维的
txt :=getjsonkey("now_val")

;msgbox, %txt%
Haystack := txt
;reg :="^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
;reg :="PO[0-9]+"

;reg为最后要提取的变量，可以统一输入
arr :=[]
arr["reg"] := "请输入正则公式,正则公式比较复杂，请自行上网检索。`n 相关网站：`nhttps://c.runoob.com/front-end/854/（30秒内免再输入）"
arr :=arrupdate(arr)


;str := JSON.Dump(arr,, 4)
;startstr(str)
;msgbox, 正则提取arr的数据

reg := arr["reg"]

FoundPos := RegExMatch(Haystack, reg, Match)
;msgbox, %Match%

;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;写入值到当前单元格
writeexcelcell("'" Match)


;savearr2json(temparr)



















