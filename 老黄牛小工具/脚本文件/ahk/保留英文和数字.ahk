#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")


Haystack := txt
reg :="[^a-zA-Z0-9]"

txt := RegExReplace(Haystack, reg, "")


;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" txt)


;savearr2json(temparr)






























