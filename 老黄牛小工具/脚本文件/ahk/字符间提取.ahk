#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

;��ȡjson�е�ֵ����ȡ��ά��
txt :=getjsonkey("now_val")
Haystack := txt
;regΪ���Ҫ��ȡ�ı���������ͳһ����
arr :=[]
arr["ǰ��"] := "Ҫ���������ֵ�ǰ�沿�֣�������������ڣ�30�����������룩"
arr["��"] := "���沿�֣�������������ڣ�30�����������룩"
arr :=arrupdatefromini(arr)
reg := arr["ǰ��"]".*"arr["��"]

FoundPos := RegExMatch(Haystack, reg, Match)
Match := StrReplace(Match, arr["ǰ��"], "")
Match := StrReplace(Match, arr["��"], "")

;д��ֵ����ǰ��Ԫ��
writeexcelcell("'" Match)






















