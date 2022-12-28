#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := name_no_ext ;脚本的名字等于文件名

;获取json中的值，可取二维的
txt :=getjsonkey("now_val")


txt := txt "," jbname
;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;写入值到当前单元格
writeexcelcell("'" txt)


;savearr2json(temparr)



















