
#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

txt1 := readjsonconkey("�ı�����")
txt2 := readjsonconkey("�ļ�·��")
;-------------1.��ȡ�������----------
if (txt1 != "" and txt2 !="" ){  ;��������


arr:=main(txt1,txt2)


arr2["���н��"] :="��"

}else{  ;�����Ĵ���
    arr2["�ļ�·��"] := "D:\�ϻ�ţС����\wordģ��\�ı�����.txt"
    arr2["�ı�����"] := "�����ı����ݣ�~"
    arr2["���н��"] :="�������Ҳ����ؼ��ʣ���ע�⡣"
}


;-------------2.����д�����----------
savearr2json(arr2)

main(ByRef txt1,ByRef txt2 :=""){
writetext(txt1, txt2)
}






