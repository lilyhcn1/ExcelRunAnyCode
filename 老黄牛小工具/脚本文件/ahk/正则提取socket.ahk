#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")

;msgbox, %txt%
Haystack := txt
;reg :="^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
;reg :="PO[0-9]+"

;regΪ���Ҫ��ȡ�ı���������ͳһ����
arr :=[]
arr["reg"] := "����������ʽ,����ʽ�Ƚϸ��ӣ�����������������`n �����վ��`nhttps://c.runoob.com/front-end/854/��30�����������룩"
arr :=arrupdate(arr)


;str := JSON.Dump(arr,, 4)
;startstr(str)
;msgbox, ������ȡarr������

reg := arr["reg"]

FoundPos := RegExMatch(Haystack, reg, Match)
;msgbox, %Match%

;MsgBox, % "FoundPos: " FoundPos "`n" "Match: " Match
;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" Match)


;savearr2json(temparr)



















