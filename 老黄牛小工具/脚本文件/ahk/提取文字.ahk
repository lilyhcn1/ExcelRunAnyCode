#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")

;msgbox, %txt%
Haystack := txt
;Haystack := "PO0129005/һ��ó��"
;reg :="^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
;reg :="PO[0-9]+"

;regΪ���Ҫ��ȡ�ı���������ͳһ����
arr :=[]
arr["ǰ��"] := "Ҫ���������ֵ�ǰ�沿�֣�������������ڣ�30�����������룩"
arr["��"] := "���沿�֣�������������ڣ�30�����������룩"
arr :=arrupdatefromini(arr)
reg := arr["ǰ��"]".*"arr["��"]


FoundPos := RegExMatch(Haystack, reg, Match)
Match := StrReplace(Match, arr["ǰ��"], "")
Match := StrReplace(Match, arr["��"], "")

;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" Match)


;savearr2json(temparr)



















